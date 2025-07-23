# Copyright 2024 DeepMind Technologies Limited
#
# AlphaFold 3 source code is licensed under CC BY-NC-SA 4.0. To view a copy of
# this license, visit https://creativecommons.org/licenses/by-nc-sa/4.0/
#
# To request access to the AlphaFold 3 model parameters, follow the process set
# out at https://github.com/google-deepmind/alphafold3. You may only use these
# if received directly from Google. Use is subject to terms of use available at
# https://github.com/google-deepmind/alphafold3/blob/main/WEIGHTS_TERMS_OF_USE.md

# This image is modification of https://github.com/google-deepmind/alphafold3/blob/v3.0.1/docker/Dockerfile

ARG CUDA=12.8
FROM nvidia/cuda:${CUDA}.0-base-ubuntu22.04
ARG CUDA

# Use bash to support string substitution.
SHELL ["/bin/bash", "-c"]

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      software-properties-common \
      build-essential \
      cmake \
      cuda-command-line-tools-${CUDA/./-} \
      git \
      libcusolver-12-1 \
      kalign \
      tzdata \
      wget \
      zlib1g \
      zlib1g-dev \
      python3.11 \
      python3-pip \
      python3.11-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Miniconda package manager.
RUN wget -q -P /tmp https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash /tmp/Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda \
    && rm /tmp/Miniconda3-latest-Linux-x86_64.sh

# Install conda packages.
ENV PATH="/opt/conda/bin:$PATH"
ENV CONDA_PLUGINS_AUTO_ACCEPT_TOS="yes"
RUN /opt/conda/bin/conda create -y -p /opt/alphafoldenv -c conda-forge \
      python=3.11 \
      bioconda::hmmer=3.4 \
      pdbfixer \
      pip \
    && /opt/conda/bin/conda clean -ya

WORKDIR /app

# RUN git clone https://github.com/google-deepmind/alphafold3.git
ENV ALPHAFOLD_VERSION=3.0.1
RUN wget -q -P ./alphafold https://github.com/google-deepmind/alphafold3/archive/v${ALPHAFOLD_VERSION}.tar.gz \
    && tar xvf ./alphafold/v${ALPHAFOLD_VERSION}.tar.gz -C ./alphafold --strip-components 1 \
    && rm ./alphafold/v${ALPHAFOLD_VERSION}.tar.gz

# Install pip packages.
RUN cd /app/alphafold/ && /opt/alphafoldenv/bin/pip install -q --upgrade --no-cache-dir pip \
    && /opt/alphafoldenv/bin/pip install -q --no-cache-dir -r /app/alphafold/dev-requirements.txt \
    && /opt/alphafoldenv/bin/pip install --no-deps . \
    && /opt/alphafoldenv/bin/build_data

# Add patch to adjust pair_transition_shard_spec depending on GPU memory
ADD model_config_memory.patch /app/alphafold
RUN cd /app/alphafold \
    && patch -p0 < model_config_memory.patch

# Add execute script
ADD run_alphafold.sh /usr/local/bin
RUN chmod +x /usr/local/bin/run_alphafold.sh

WORKDIR /app/alphafold

ENV PATH=/opt/alphafoldenv/bin:/usr/local/cuda-12/bin:/usr/local/bin:$PATH \
    PYTHONPATH=/opt/alphafoldenv/lib/python3.11/site-packages/ \
    LD_LIBRARY_PATH=/.singularity.d/libs:/usr/local/cuda-12/targets/x86_64-linux/lib/:$LD_LIBRARY_PATH \
    LC_ALL=C.UTF-8

# To work around a known XLA issue causing the compilation time to greatly
# increase, the following environment variable setting XLA flags must be enabled
# when running AlphaFold 3. Note that if using CUDA capability 7 GPUs, it is
# necessary to set the following XLA_FLAGS value instead:
# ENV XLA_FLAGS="--xla_disable_hlo_passes=custom-kernel-fusion-rewriter"
# (no need to disable gemm in that case as it is not supported for such GPU).
ENV XLA_FLAGS="--xla_gpu_enable_triton_gemm=false"
# Memory settings used for folding up to 5,120 tokens on A100 80 GB.
ENV XLA_PYTHON_CLIENT_PREALLOCATE=true
ENV XLA_CLIENT_MEM_FRACTION=0.95

# This image is modification of https://raw.githubusercontent.com/google-deepmind/alphafold3/refs/tags/v3.0.1/docker/Dockerfile
LABEL maintainer=hcc-support@unl.edu \
      homepage=https://github.com/google-deepmind/alphafold3 \
      description="Open source code for AlphaFold 3" \
      gpu=true \
      moduleclass=bio

ENTRYPOINT ["/app/alphafold/run_alphafold.py"]
