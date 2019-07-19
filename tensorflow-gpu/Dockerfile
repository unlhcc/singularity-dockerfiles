# Start with Ubuntu base image
FROM ubuntu:16.04

# Install wget and build-essential
RUN apt-get -qq update && apt-get -qq install -y \
  build-essential \
  wget vim  module-init-tools

RUN cd /tmp && \
    # Download run file
    wget https://developer.nvidia.com/compute/cuda/10.0/Prod/local_installers/cuda_10.0.130_410.48_linux -o /dev/null && \
    # The driver version must match exactly what's installed on the GPU nodes, so install it separately
    wget http://us.download.nvidia.com/XFree86/Linux-x86_64/410.73/NVIDIA-Linux-x86_64-410.73.run -o /dev/null && \
    # Patch 1
    wget http://developer.download.nvidia.com/compute/cuda/10.0/Prod/patches/1/cuda_10.0.130.1_linux.run -o /dev/null && \
    # cuDNN library
    wget https://unl.box.com/shared/static/713e2o84g4yvjloyhor60bcyn40kjgnh.tgz -o /dev/null && \
    # Make the run file executable and extract
    chmod +x *.run cuda_10.0.130_410.48_linux NVIDIA-Linux-x86_64-410.73.run && ./cuda_10.0.130_410.48_linux -extract=`pwd` && \
    # Install CUDA drivers (silent, no kernel)
    ./NVIDIA-Linux-x86_64-410.73.run -s --no-kernel-module && \
    # Install toolkit (silent)
     ./cuda-linux.10.0.130-24817639.run -noprompt && \
    # Install patch
    ./cuda_10.0.130.1_linux.run --silent --accept-eula && \
    # Install cuDNN
    tar -zxvf 713e2o84g4yvjloyhor60bcyn40kjgnh.tgz && \
    cp -a cuda/lib64/* /usr/local/cuda/lib64 && cp -a cuda/include/* /usr/local/cuda/include && \
    # Clean up
    rm -rf /tmp/cuda* /tmp/NVIDIA* /tmp/*.tgz

ENV PATH=/usr/local/cuda/bin:$PATH \
  LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH \
  CUDA_HOME=/usr/local/cuda \
  LC_ALL=C

ADD cuda.conf /etc/ld.so.conf.d
RUN ldconfig -v
RUN mkdir /work /common

# Install both 2.7/3.5 version of Python and pip
RUN apt-get -qq update && apt-get -qq install -y software-properties-common
RUN apt-add-repository multiverse && apt-get -qq update
RUN apt-get -qq install -y libcupti-dev python-pip python-dev python3-dev python3-pip

# Install TensorFlow (and friends) for both Python 2.7 and 3.5
RUN pip --no-cache-dir install numpy 'tensorflow-gpu==1.14' 'pandas<0.25' 'scipy<1.3.0' 'matplotlib<3.0' 'scikit-learn<=0.20' 'scikit-image<0.15' 'networkx==2.2'
RUN pip3 --no-cache-dir install numpy 'tensorflow-gpu==1.14' 'matplotlib<3.1' 'pandas<0.25' scikit-learn scikit-image scipy
