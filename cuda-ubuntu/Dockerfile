# Start with Ubuntu base image
FROM ubuntu:16.04

ARG DEBIAN_FRONTEND="noninteractive"

# Install wget and build-essential
RUN apt-get update && apt-get install -y -qq \
  software-properties-common gnupg-curl wget vim module-init-tools build-essential > /dev/null

RUN wget -q https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-ubuntu1604.pin && \
  mv cuda-ubuntu1604.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \
  apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub && \
  add-apt-repository "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/ /" && \
  wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/nvidia-machine-learning-repo-ubuntu1604_1.0.0-1_amd64.deb && \
  apt install ./nvidia-machine-learning-repo-ubuntu1604_1.0.0-1_amd64.deb && \
  apt-get -qq update && \
  apt-get install -y -qq cuda-toolkit-10-2 libcudnn7=7.6.5.32-1+cuda10.2 libcudnn7-dev=7.6.5.32-1+cuda10.2 \
    libnvinfer6=6.0.1-1+cuda10.2 libnvinfer-dev=6.0.1-1+cuda10.2 libnvinfer-plugin6=6.0.1-1+cuda10.2 \
    libnccl2=2.6.4-1+cuda10.2 libnccl-dev=2.6.4-1+cuda10.2 > /dev/null

ENV PATH=/usr/local/cuda/bin:$PATH \
  LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH \
  CUDA_HOME=/usr/local/cuda \
  LC_ALL=C

RUN mkdir /work /common
