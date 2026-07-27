# This image is a modification of https://github.com/NVIDIA-BioNeMo/Proteina-Complexa/blob/dev/env/docker/Dockerfile
# Requires an NVIDIA GPU at runtime.
FROM nvcr.io/nvidia/pytorch:24.08-py3

ENV DEBIAN_FRONTEND=noninteractive
SHELL ["bash", "-lc"]

RUN apt-get update \
    && apt-get install -y --no-install-recommends git rsync libxrender1 libxext6 wget \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /workspace/protein-foundation-models

# Pinned to dev HEAD for reproducibility (no release tags yet).
# Recheck: git ls-remote https://github.com/NVIDIA-BioNeMo/Proteina-Complexa dev
# Pinned commit: 916eaaedce5b07c205efb6ef32370c01d366591e (dev HEAD)
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
# Pins: numpy 1.26.4 (graphein numpy<2), jax 0.4.30 (0.4.20 needs scipy.linalg.tril, removed in 1.13; atomworks needs scipy>=1.13.1), scipy/tqdm/einops at min feasible, 
#transformers 4.48.3 (5.x needs torch>=2.5, we have 2.4.1). Two files: proteinfoundation declares contradictory ==pins, so constrain them only in later layers.
# numpy==1.26.4      : graphein caps numpy<2; scipy floors 1.26.4. Only version satisfying both.
# jax/jaxlib==0.4.30 : 0.4.20 imports scipy.linalg.tril (removed in scipy 1.13); atomworks needs scipy>=1.13.1.
# scipy/tqdm/einops  : proteinfoundation's ==pins are unsatisfiable; these are the min feasible overrides.
# transformers==4.48.3: 5.x needs torch>=2.5 for DTensor; conda-forge under cuda 12.4 gives 2.4.1. Paired with sed below.
#
# Two constraint files because proteinfoundation itself declares einops==0.6 / scipy==1.12.0 /
# tqdm==4.66.4 -- constraining those during its own install is a direct contradiction.

RUN printf 'numpy==1.26.4\njax==0.4.30\njaxlib==0.4.30\ndm-haiku==0.0.11\ntransformers==4.48.3\n' \
        > /opt/pip-constraints-base.txt \
 && printf 'numpy==1.26.4\njax==0.4.30\njaxlib==0.4.30\ndm-haiku==0.0.11\nscipy==1.13.1\ntqdm==4.67.1\neinops==0.8.2\ntransformers==4.48.3\n' \
        > /opt/pip-constraints-post.txt
ENV PIP_CONSTRAINT=/opt/pip-constraints-base.txt
ENV PIP_BUILD_CONSTRAINT=/opt/pip-constraints-base.txt

# Restore upstream's own prior transformers pin (5.x needs torch>=2.5; we have 2.4.1). grep verifies the sed matched.
RUN sed -i 's|"transformers>=5.3.0"|"transformers==4.48.3"|' \
      /workspace/protein-foundation-models/pyproject.toml \
 && grep -n 'transformers' /workspace/protein-foundation-models/pyproject.toml

# Installs proteinfoundation + its pyproject.toml deps, and generates the
# complexa CLI entry point (mirrors build_uv_env.sh stage [4/8]: `uv pip install .`)
RUN /workspace/.venv/bin/pip install --no-cache-dir /workspace/protein-foundation-models torch-geometric

# proteinfoundation installed; later layers will override its einops/scipy/tqdm pins -- constrain those overrides now.
ENV PIP_CONSTRAINT=/opt/pip-constraints-post.txt
ENV PIP_BUILD_CONSTRAINT=/opt/pip-constraints-post.txt

# PyG extensions (stage [5/8]).
# torch_scatter: only PyG extension actually used (seq_cond_feats.py).
# No prebuilt wheel matches conda-forge's build tag, so compiles from
RUN /workspace/.venv/bin/pip install --no-cache-dir ninja \
    && env -u PIP_BUILD_CONSTRAINT \
           TORCH_CUDA_ARCH_LIST="6.0;7.0;7.2;7.5;8.0;8.6;8.7;9.0+PTX" \
       /workspace/.venv/bin/pip install --no-cache-dir --no-build-isolation \
         torch-scatter

# Graphein + Atomworks (stage [6/8]).
# graphein is the package holding the numpy<2 ceiling for the whole image.
RUN /workspace/.venv/bin/pip install --no-cache-dir graphein "atomworks[dev]"

# JAX with CUDA (stage [7/8]), before colabdesign.
RUN /workspace/.venv/bin/pip install --no-cache-dir "jax[cuda12]==0.4.30"

# Add haiku (pure Python -- no numpy C-ABI dependency of its own; the numpy pin
# above exists for jaxlib's compiled extension, not for haiku).
RUN /workspace/.venv/bin/pip install --no-cache-dir dm-haiku==0.0.11

# install colabdesign with --no-deps to avoid overriding JAX
RUN /workspace/.venv/bin/pip install --no-cache-dir --no-deps /workspace/protein-foundation-models/community_models/colabdesign

# Foundry (stage [8/8]).
RUN /workspace/.venv/bin/pip install --no-cache-dir rc-foundry

# pip check catches cross-layer pin violations (how numpy 2.5.1 slipped past graphein).
# proteinfoundation's einops/scipy/tqdm ==pins are unsatisfiable -> allowlisted; anything else fails.
RUN /workspace/.venv/bin/pip check > /tmp/pip-check.log 2>&1 || true; \
    cat /tmp/pip-check.log; \
    if grep -E 'has requirement' /tmp/pip-check.log \
         | grep -vE 'proteinfoundation 1\.1\.0 has requirement (einops|scipy|tqdm)'; then \
        echo "ERROR: unexpected dependency conflict (listed above)"; exit 1; \
    fi

# Create wrapper script to run complexa init from any directory
RUN printf '#!/bin/bash\ncd /workspace/protein-foundation-models\n/workspace/.venv/bin/complexa init "$@"\n' > /usr/local/bin/complexa-init-wrapper.sh \
    && chmod +x /usr/local/bin/complexa-init-wrapper.sh

# interactive `docker run` / `singularity run` sessions.
RUN mkdir -p /workspace/.venv/bin \
    && printf '#!/bin/bash\nsource /opt/conda/etc/profile.d/conda.sh\nconda activate /workspace/.venv\n' \
         > /workspace/.venv/bin/activate \
    && chmod +x /workspace/.venv/bin/activate

# Prevent CTRL-D to exit the shell
ENV IGNOREEOF=10

# Install optional bioinformatics binaries if present in env/docker/internal/
# (sc, dssp, hbplus are not distributed with this repo -- see README for details)
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

# Set auxiliary models paths
ENV RF3_CKPT_PATH="/workspace/protein-foundation-models/community_models/ckpts/RF3/rf3_foundry_01_24_latest_remapped.ckpt"
ENV RF3_EXEC_PATH="/workspace/.venv/bin/rf3"
ENV AF2_DIR=/workspace/protein-foundation-models/community_models/ckpts/AF2
ENV PYTHONPATH="/workspace/protein-foundation-models/src"

# Default entrypoint: activate venv, run passed command or open interactive bash
RUN cp env/docker/entrypoint.sh /usr/local/bin/entrypoint.sh \
    && chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
