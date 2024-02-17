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
    && rm -rf /var/lib/apt/lists/*

# Install Miniconda package manager.
RUN wget -q -P /tmp https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash /tmp/Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda \
    && rm /tmp/Miniconda3-latest-Linux-x86_64.sh
ENV PATH="/opt/conda/bin:$PATH"

# Install conda packages
# https://github.com/uw-ipd/RoseTTAFold2NA/blob/main/RF2na-linux.yml
RUN conda install conda-forge::mamba && mamba create -y -n RF2NA -c pytorch -c nvidia -c defaults -c conda-forge -c bioconda \
    python=3.10 pip mafft hhsuite blast 'hmmer>=3.3' infernal cd-hit csblast \
    hcc::cudatoolkit=11.* 'pytorch=2.0.*=*cuda11*' 'torchvision=*=*cu11*' \
    pytorch-cuda=11.7 dglteam/label/cu117::dgl pyg::pyg \
    requests psutil tqdm pandas 'numpy<1.24' scipy && \
    conda clean -ya
RUN echo "source activate RF2NA" > ~/.bashrc
ENV PATH /opt/conda/envs/RF2NA/bin:$PATH

# Clone repo and install conda packages.
RUN cd /opt && git clone --recursive --branch v0.2 https://github.com/uw-ipd/RoseTTAFold2NA.git && \
    cd /opt/RoseTTAFold2NA && \
    chmod +x run_RF2NA.sh && \
    cd SE3Transformer && \
    pip install --no-cache-dir -r requirements.txt && \
    python setup.py install

WORKDIR /opt/RoseTTAFold2NA

ENV PIPEDIR /opt/RoseTTAFold2NA/
ENV PATH /opt/RoseTTAFold2NA/:$PATH
