# This image is modification of https://github.com/HannesStark/boltzgen/blob/v0.2.0/Dockerfile

ARG CUDA=12.2
FROM nvidia/cuda:${CUDA}.2-cudnn8-devel-ubuntu22.04
ARG CUDA

ENV DEBIAN_FRONTEND=noninteractive \
    PIP_NO_CACHE_DIR=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    CUDA_HOME=/usr/local/cuda \
    PIP_EXTRA_INDEX_URL=https://download.pytorch.org/whl/cu121 \
    HF_HOME=/cache
    
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3.11 \
    python3.11-dev \
    python3-pip \
    python3-venv \
    python3-wheel \
    build-essential \
    git \
    cmake \
    pkg-config \
    libffi-dev \
    libssl-dev \
    libxml2-dev \
    libxslt-dev \
    libgl1 \
    libhdf5-dev \
    libboost-all-dev \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.11 1 && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.11 1 && \
    python -m pip install --upgrade pip setuptools setuptools_scm wheel

WORKDIR /app

# RUN git clone https://github.com/HannesStark/boltzgen.git
ENV BOLTZGEN_VERSION=0.2.0
RUN wget -q -P ./boltzgen https://github.com/HannesStark/boltzgen/archive/v${BOLTZGEN_VERSION}.tar.gz \
    && tar xvf ./boltzgen/v${BOLTZGEN_VERSION}.tar.gz -C ./boltzgen --strip-components 1 \
    && rm ./boltzgen/v${BOLTZGEN_VERSION}.tar.gz

# Install pip packages.
RUN cd /app/boltzgen/ && pip install --no-cache-dir -e .

ARG DOWNLOAD_WEIGHTS=false

WORKDIR /app/boltzgen
