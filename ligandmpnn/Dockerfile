ARG CUDA=12.1
FROM nvidia/cuda:${CUDA}.0-cudnn8-devel-ubuntu22.04
ARG CUDA

# Use bash to support string substitution.
SHELL ["/bin/bash", "-c"]

# This image is modification of https://github.com/LevitateBio/LigandMPNN/blob/0e23e1fe09ae92ad633679fecc8dbe8b45f7b4c7/Dockerfile
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      build-essential \
      python3 \
      python3-pip \
      python3-dev \
      cuda-command-line-tools-${CUDA/./-} \
      cuda-compat-${CUDA/./-} \
      git \
      tzdata \
      wget \
    && rm -rf /var/lib/apt/lists/*

# Clone repo and install Python packages
ENV LIGANDMPNN_COMMON=091ab1ff5fb4d13854cf6a7c41ec531e1d9d3e67
RUN cd /opt && mkdir LigandMPNN &&  wget https://github.com/dauparas/LigandMPNN/archive/${LIGANDMPNN_COMMON}.tar.gz && \
    tar -xzf ${LIGANDMPNN_COMMON}.tar.gz -C LigandMPNN --strip-components=1 && \
    rm *.tar.gz && \
    cd /opt/LigandMPNN && \
    chmod +x *.py && \
    pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121 && \
    pip install --no-cache-dir -r requirements.txt

# Download model files
# RUN cd /opt/LigandMPNN && \
#     bash get_model_params.sh "./model_params"

WORKDIR /opt/LigandMPNN/
