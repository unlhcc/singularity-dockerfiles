# Start with Ubuntu base image
FROM ubuntu:20.04

ARG DEBIAN_FRONTEND="noninteractive"

# Install wget and build-essential
RUN apt-get update && apt-get install -y -qq \
  software-properties-common curl wget vim build-essential apt-utils > /dev/null

RUN wget -q https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin && \
  mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \
  apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub && \
  add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /" && \
  wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu2004/x86_64/nvidia-machine-learning-repo-ubuntu2004_1.0.0-1_amd64.deb && \
  apt install ./nvidia-machine-learning-repo-ubuntu2004_1.0.0-1_amd64.deb && \
  apt-get -qq update

RUN apt-get install -y -qq cuda-toolkit-11-2 libcudnn8=8.1.1.33-1+cuda11.2 libcudnn8-dev=8.1.1.33-1+cuda11.2 \
    libnvinfer-dev libnvinfer-plugin8 python3-libnvinfer-dev \
    libnccl2=2.8.4-1+cuda11.2 libnccl-dev=2.8.4-1+cuda11.2 > /dev/null

ENV PATH=/usr/local/cuda/bin:$PATH \
  LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH \
  CUDA_HOME=/usr/local/cuda \
  LC_ALL=C
