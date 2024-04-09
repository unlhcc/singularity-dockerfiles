ARG CUDA=11.7
FROM nvidia/cuda:${CUDA}.1-cudnn8-devel-ubuntu20.04 AS build
ARG CUDA

# Use bash to support string substitution.
SHELL ["/bin/bash", "-c"]

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      build-essential \
      cmake \
      cuda-command-line-tools-${CUDA/./-} \
      git \
      tzdata \
      wget \
      git \
    && rm -rf /var/lib/apt/lists/*

# Install Miniconda package manager.
RUN wget -q -P /tmp https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash /tmp/Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda \
    && rm /tmp/Miniconda3-latest-Linux-x86_64.sh
ENV PATH="/opt/conda/bin:$PATH"

# Install conda packages
# https://github.com/RosettaCommons/RFdiffusion/blob/main/env/SE3nv.yml
RUN conda install conda-forge::mamba && mamba create -y -n SE3nv -c pytorch -c nvidia -c defaults -c conda-forge -c bioconda \
    'python=3.9' pip 'hcc::cudatoolkit=11.*' 'pytorch=2.0.*=*cuda11*' 'torchvision=*=*cu11*' \
    pytorch-cuda=11.7 dglteam/label/cu117::dgl pyg::pyg \
    requests psutil tqdm pandas 'numpy<1.24' scipy pydantic icecream \
    torchaudio torchvision pyrsistent hydra-core torchdata && \
    conda clean -ya
RUN echo "source activate SE3nv" > ~/.bashrc
ENV PATH /opt/conda/envs/SE3nv/bin:$PATH

# Install NVIDIA apex
RUN cd /opt && git clone --recursive --branch 23.08 https://github.com/NVIDIA/apex.git && \
    cd /opt/apex && \
    pip install -v --disable-pip-version-check --no-build-isolation --no-cache-dir ./

# Clone repo and install conda packages.
RUN cd /opt && git clone --recursive --branch v1.1.0 https://github.com/RosettaCommons/RFdiffusion.git && \
    cd /opt/RFdiffusion/env/SE3Transformer && \
    pip install --no-cache-dir -r requirements.txt && \
    python setup.py install && \
    cd ../../ && \
    pip install -e .

WORKDIR /opt/RFdiffusion

ENV PATH /opt/RFdiffusion/:/opt/RFdiffusion/scripts/:/opt/RFdiffusion/helper_scripts/:$PATH
