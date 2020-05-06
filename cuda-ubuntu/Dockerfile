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
  apt-get -qq update && \
  apt-get install -y -qq cuda-toolkit-10-2 > /dev/null

ENV PATH=/usr/local/cuda/bin:$PATH \
  LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH \
  CUDA_HOME=/usr/local/cuda \
  LC_ALL=C

RUN mkdir /work /common
