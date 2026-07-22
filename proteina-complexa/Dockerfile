
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
RUN git clone --branch dev https://github.com/NVIDIA-BioNeMo/Proteina-Complexa.git . \
    && git checkout ${PROTEINA_COMPLEXA_REF}


# Install Miniconda package manager.
RUN wget -q -P /tmp https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash /tmp/Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda \
    && rm /tmp/Miniconda3-latest-Linux-x86_64.sh

ENV CONDA_PLUGINS_AUTO_ACCEPT_TOS="yes"

ENV CONDA_OVERRIDE_CUDA="12.4"

# Install conda packages.
RUN /opt/conda/bin/conda create -y -p /workspace/.venv --override-channels -c conda-forge \
          python=3.12 \
          pip \
          pytorch-gpu \
          torchvision \
          torchaudio \
          cuda-version=12.4.* \
         && /opt/conda/bin/conda clean -ya


ENV PATH="/workspace/.venv/bin:${PATH}"


# Installs proteinfoundation + its pyproject.toml deps, and generates the
# complexa CLI entry point (mirrors build_uv_env.sh stage [4/8]: `uv pip install .`)
RUN /workspace/.venv/bin/pip install --no-cache-dir /workspace/protein-foundation-models torch-geometric

# PyG extensions (stage [5/8]).
# torch_scatter: only PyG extension actually used (seq_cond_feats.py).
# No prebuilt wheel matches conda-forge's build tag, so compiles from
# source; arch list covers V through H (+PTX for newer).
RUN /workspace/.venv/bin/pip install --no-cache-dir ninja \
    && TORCH_CUDA_ARCH_LIST="6.0;7.0;7.2;7.5;8.0;8.6;8.7;9.0+PTX" \
       /workspace/.venv/bin/pip install --no-cache-dir --no-build-isolation \
         torch-scatter 


# Graphein + Atomworks (stage [6/8]).
RUN /workspace/.venv/bin/pip install --no-cache-dir graphein "atomworks[dev]" \
    && /workspace/.venv/bin/pip install --no-cache-dir --no-deps /workspace/protein-foundation-models/community_models/colabdesign


# JAX with CUDA (stage [7/8])
RUN /workspace/.venv/bin/pip install --no-cache-dir -U "jax[cuda12]"


# Foundry (stage [8/8])
RUN /workspace/.venv/bin/pip install --no-cache-dir rc-foundry


# MAKE DIRECTORIES WRITABLE FOR complexa init/download

RUN chmod 775 /workspace/protein-foundation-models || true \
    && mkdir -p /workspace/protein-foundation-models/ckpts \
    && chmod 775 /workspace/protein-foundation-models/ckpts || true \
    && mkdir -p /workspace/protein-foundation-models/community_models \
    && chmod 775 /workspace/protein-foundation-models/community_models || true \
    && mkdir -p /workspace/protein-foundation-models/outputs \
    && chmod 775 /workspace/protein-foundation-models/outputs || true \
    && mkdir -p /workspace/.venv/outputs \
    && chmod 775 /workspace/.venv/outputs || true
 
# Create placeholder .env so complexa init won't fail
RUN touch /workspace/protein-foundation-models/.env && chmod 666 /workspace/protein-foundation-models/.env || true
 
 
# interactive `docker run` / `singularity run` sessions.
RUN mkdir -p /workspace/.venv/bin \
    && printf '#!/bin/bash\nsource /opt/conda/etc/profile.d/conda.sh\nconda activate /workspace/.venv\n' \
         > /workspace/.venv/bin/activate \
    && chmod +x /workspace/.venv/bin/activate


# prevent CTRL-D to exit the shell
ENV IGNOREEOF=10

# Install optional bioinformatics binaries if present in env/docker/internal/
# (sc, dssp, hbplus are not distributed with this repo — see README for details)
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
