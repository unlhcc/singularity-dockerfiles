# Start with Ubuntu 16.04
FROM ubuntu:16.04

ARG DEBIAN_FRONTEND="noninteractive"

# NVIDIA repos
RUN apt-get -qq update && apt-get -qq install gnupg-curl wget software-properties-common && \
  wget -q https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_10.1.243-1_amd64.deb && \
  apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub && \
  dpkg -i cuda-repo-ubuntu1604_10.1.243-1_amd64.deb && \
  apt-get -qq update && \
  wget -q http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64/nvidia-machine-learning-repo-ubuntu1604_1.0.0-1_amd64.deb && \
  apt -qq install ./nvidia-machine-learning-repo-ubuntu1604_1.0.0-1_amd64.deb && \
  apt-get -qq update

# CUDA, CuDNN, TensorRT
RUN apt-get install -y --no-install-recommends \
    cuda-libraries-10-1 \
    libcudnn7=7.6.4.38-1+cuda10.1  \
    libcudnn7-dev=7.6.4.38-1+cuda10.1 \
    libnvinfer6=6.0.1-1+cuda10.1 \
    libnvinfer-dev=6.0.1-1+cuda10.1 \
    libnvinfer-plugin6=6.0.1-1+cuda10.1

# Install Python 3.7
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get -qq update && \
    apt-get install -qq -y python3.7 python3.7-dev python3-pip > /dev/null && \
    ln -s /usr/bin/python3.7 /usr/local/bin/python

# Install TensorFlow (and friends) for both Python 3.7
# TensorFlow 2.x requires pip > 19.0
RUN  python3 -m pip install --upgrade pip && \
  pip3 --no-cache-dir install 'tensorflow-gpu==2.2.0' 'numpy<2.0,>=1.16.0' 'six>=1.10.0' pandas scipy matplotlib scikit-learn scikit-image 'setuptools>=41.0.0' tensorflow-probability 'tensorboard==2.2.2'
