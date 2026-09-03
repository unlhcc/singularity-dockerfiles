# This image is a modification of https://github.com/NVIDIA-BioNeMo/Proteina-Complexa/blob/dev/env/docker/Dockerfile
# Requires an NVIDIA GPU at runtime.
#
# The wrapper script at /usr/local/bin/complexa handles cd and env.sh sourcing automatically.
# The modulefile sets $COMPLEXA_DATA and loads apptainer. Users compose their own apptainer commands.

FROM nvcr.io/nvidia/pytorch:24.08-py3

ENV DEBIAN_FRONTEND=noninteractive
SHELL ["bash", "-lc"]

RUN apt-get update \
    && apt-get install -y --no-install-recommends git rsync libxrender1 libxext6 wget \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /workspace/protein-foundation-models

# Pinned to Proteina-Complexa dev HEAD (916eaaed) for reproducibility.
ARG PROTEINA_COMPLEXA_REF=916eaaedce5b07c205efb6ef32370c01d366591e
RUN git clone --branch dev --recurse-submodules https://github.com/NVIDIA-BioNeMo/Proteina-Complexa.git . \
    && git checkout ${PROTEINA_COMPLEXA_REF} \
    && git submodule update --init --recursive

# Install Miniconda package manager.
RUN wget -q -P /tmp https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash /tmp/Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda \
    && rm /tmp/Miniconda3-latest-Linux-x86_64.sh

ENV CONDA_PLUGINS_AUTO_ACCEPT_TOS="yes"

ENV CONDA_OVERRIDE_CUDA="12.4"

# Install conda packages.
#
RUN /opt/conda/bin/conda create -y -p /workspace/.venv --override-channels -c conda-forge \
          python=3.12 \
          pip \
          numpy=1.26.4 \
          pytorch-gpu \
          torchvision \
          torchaudio \
          cuda-version=12.4.* \
          openbabel \
    && /opt/conda/bin/conda clean -ya

ENV PATH="/workspace/.venv/bin:${PATH}"

# Put the conda env's libstdc++ ahead of the base image's on the loader path.
ENV LD_LIBRARY_PATH="/workspace/.venv/lib:${LD_LIBRARY_PATH}"

# Global pip constraints.
RUN printf 'numpy==1.26.4\njax==0.4.30\njaxlib==0.4.30\ndm-haiku==0.0.11\ntransformers==4.48.3\n' \
        > /opt/pip-constraints-base.txt \
 && printf 'numpy==1.26.4\njax==0.4.30\njaxlib==0.4.30\ndm-haiku==0.0.11\nscipy==1.13.1\ntqdm==4.67.1\neinops==0.8.2\ntransformers==4.48.3\n' \
        > /opt/pip-constraints-post.txt
ENV PIP_CONSTRAINT=/opt/pip-constraints-base.txt
ENV PIP_BUILD_CONSTRAINT=/opt/pip-constraints-base.txt

# Disable LTO to avoid compiler flag issues
ENV CFLAGS="-O2"
ENV CXXFLAGS="-O2"
ENV LDFLAGS=""

# Restore upstream's own prior transformers pin (5.x needs torch>=2.5; we have 2.4.1). grep verifies the sed matched.
RUN sed -i 's|"transformers>=5.3.0"|"transformers==4.48.3"|' \
      /workspace/protein-foundation-models/pyproject.toml \
 && grep -n 'transformers' /workspace/protein-foundation-models/pyproject.toml

# Stages [4/8]-[8/8]; proteinfoundation under base constraints, then overrides.
RUN set -eux; \
    PIP=/workspace/.venv/bin/pip; \
    \
    # [4/8] proteinfoundation + deps; creates the complexa CLI entry point.
    $PIP install --no-cache-dir /workspace/protein-foundation-models torch-geometric; \
    \
    # Overrides proteinfoundation's einops/scipy/tqdm pins.
    export PIP_CONSTRAINT=/opt/pip-constraints-post.txt; \
    export PIP_BUILD_CONSTRAINT=/opt/pip-constraints-post.txt; \
    \
    # [5/8] torch_scatter from source, linked against the venv's torch.
    $PIP install --no-cache-dir ninja; \
    env -u PIP_BUILD_CONSTRAINT \
        TORCH_CUDA_ARCH_LIST="6.0;7.0;7.2;7.5;8.0;8.6;8.7;9.0+PTX" \
      $PIP install --no-cache-dir --no-build-isolation torch-scatter; \
    \
    # [6/8]-[8/8] Graphein, Atomworks, JAX, Haiku, Foundry in one solve.
    $PIP install --no-cache-dir \
      graphein \
      "atomworks[dev]" \
      "jax[cuda12]==0.4.30" \
      dm-haiku==0.0.11 \
      rc-foundry; \
    \
    # colabdesign last, --no-deps so it cannot override JAX.
    $PIP install --no-cache-dir --no-deps \
      /workspace/protein-foundation-models/community_models/colabdesign


# The exports above die with the layer; restate them for the final image.
ENV PIP_CONSTRAINT=/opt/pip-constraints-post.txt
ENV PIP_BUILD_CONSTRAINT=/opt/pip-constraints-post.txt

# pip check validates cross-layer pins; allowlisted proteinfoundation conflicts are ignored, all others fail.
RUN /workspace/.venv/bin/pip check > /tmp/pip-check.log 2>&1 || true; \
    cat /tmp/pip-check.log; \
    if grep -E 'has requirement' /tmp/pip-check.log \
         | grep -vE 'proteinfoundation 1\.1\.0 has requirement (einops|scipy|tqdm)'; then \
        echo "ERROR: unexpected dependency conflict (listed above)"; exit 1; \
    fi

# Install optional bioinformatics binaries if available; see README for details.
RUN for bin in sc dssp hbplus; do \
        src="env/docker/internal/${bin}"; \
        if [ -f "$src" ]; then \
            cp "$src" /usr/local/bin/ && chmod +x "/usr/local/bin/${bin}" && \
            echo "Installed ${bin}"; \
        else \
            echo "Skipping ${bin} (not found)"; \
        fi; \
    done

ENV SC_EXEC="/usr/local/bin/sc"
ENV DSSP_EXEC="/usr/local/bin/dssp"
ENV RF3_EXEC_PATH="/workspace/.venv/bin/rf3"
ENV PYTHONPATH="/workspace/protein-foundation-models/src"

# Pre-configures .env/env.sh and finalizes the Docker environment with complexa init; sets code, data, checkpoint, venv, and /data paths.
RUN cd /workspace/protein-foundation-models \
 && cp .env_example .env \
 && sed -i \
      -e "s|^LOCAL_CODE_PATH=.*|LOCAL_CODE_PATH=/workspace/protein-foundation-models|" \
      -e "s|^LOCAL_DATA_PATH=.*|LOCAL_DATA_PATH=/workspace/protein-foundation-models/assets|" \
      -e 's|^LOCAL_CHECKPOINT_PATH=.*|LOCAL_CHECKPOINT_PATH=${LOCAL_CODE_PATH}/ckpts|' \
      -e "s|^DOCKER_REPO_PATH=.*|DOCKER_REPO_PATH=/workspace/protein-foundation-models|" \
      -e "s|^DOCKER_DATA_PATH=.*|DOCKER_DATA_PATH=/workspace/protein-foundation-models/assets|" \
      -e "s|^DOCKER_CHECKPOINT_PATH=.*|DOCKER_CHECKPOINT_PATH=/workspace/protein-foundation-models/ckpts|" \
      -e 's|^UV_VENV=.*|UV_VENV=/workspace/.venv|' \
      -e 's|^UV_SC_EXEC=.*|UV_SC_EXEC=/usr/local/bin/sc|' \
      -e 's|^UV_DSSP_EXEC=.*|UV_DSSP_EXEC=/usr/local/bin/dssp|' \
      .env \
 && /workspace/.venv/bin/complexa init docker --force \
 && mkdir -p /data

# Create a complexa wrapper script
RUN printf '#!/bin/bash\ncd /workspace/protein-foundation-models\nsource ./env.sh >/dev/null 2>&1\nexec /workspace/.venv/bin/complexa "$@"\n' > /usr/local/bin/complexa \
    && chmod +x /usr/local/bin/complexa

ENV PATH="/usr/local/bin:${PATH}"

# Simple entrypoint
RUN printf '#!/bin/bash\nexec "$@"\n' > /usr/local/bin/entrypoint.sh \
    && chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
