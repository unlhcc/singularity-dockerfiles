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
      python3.10 \
      python3-pip \
      python3.10-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Miniconda package manager.
RUN wget -q -P /tmp https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash /tmp/Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda \
    && rm /tmp/Miniconda3-latest-Linux-x86_64.sh

# Install conda packages.
ENV PATH="/opt/conda/bin:$PATH"
ENV CONDA_PLUGINS_AUTO_ACCEPT_TOS="yes"
RUN /opt/conda/bin/conda create -y -p /opt/annevoenv -c pytorch -c nvidia -c conda-forge -c bioconda \
      python=3.10 pip numba pdbfixer 'numpy<2' pandas tqdm h5py bcbio-gff \
      'pytorch=2.1.*=*cuda12*' pytorch-cuda=12.* 'torchvision=*=*cu12*' \
      'torchaudio=*=*cu12*' torchmetrics hcc::'cudatoolkit=12.*' \
    && /opt/conda/bin/conda clean -ya

WORKDIR /app

ENV ANNEVO_VERSION=2.3.2
RUN wget -q -P ./annevo https://github.com/xjtu-omics/ANNEVO/archive/v${ANNEVO_VERSION}.tar.gz \
    && tar xvf ./annevo/v${ANNEVO_VERSION}.tar.gz -C ./annevo --strip-components 1 \
    && rm ./annevo/v${ANNEVO_VERSION}.tar.gz && \
    chmod +x ./annevo/*.py

WORKDIR /app/annevo

ENV PATH=/opt/annevoenv/bin:/app/annevo:/usr/local/cuda-12/bin:/usr/local/bin:$PATH \
    PYTHONPATH=/opt/annevoenv/lib/python3.10/site-packages/ \
    LD_LIBRARY_PATH=/.singularity.d/libs:/usr/local/cuda-12/targets/x86_64-linux/lib/:$LD_LIBRARY_PATH \
    LC_ALL=C.UTF-8
ENV NUMBA_CACHE_DIR="/scratch"

ENTRYPOINT [ "python" ]
