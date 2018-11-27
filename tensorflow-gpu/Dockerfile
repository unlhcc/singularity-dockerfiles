# Start with Ubuntu base image
FROM ubuntu:16.04

# Install wget and build-essential
RUN apt-get update && apt-get install -y \
  build-essential \
  wget vim  module-init-tools

RUN cd /tmp && \
    # Download run file
    wget https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_9.0.176_384.81_linux-run -o /dev/null && \
    # The driver version must match exactly what's installed on the GPU nodes, so install it separately
    wget http://us.download.nvidia.com/XFree86/Linux-x86_64/410.73/NVIDIA-Linux-x86_64-410.73.run -o /dev/null && \
    # Patches a'hoy!
    wget https://developer.nvidia.com/compute/cuda/9.0/Prod/patches/1/cuda_9.0.176.1_linux-run \
    https://developer.nvidia.com/compute/cuda/9.0/Prod/patches/2/cuda_9.0.176.2_linux-run \
    https://developer.nvidia.com/compute/cuda/9.0/Prod/patches/3/cuda_9.0.176.3_linux-run \
    https://developer.nvidia.com/compute/cuda/9.0/Prod/patches/4/cuda_9.0.176.4_linux-run -o /dev/null && \
    # cuDNN library
    wget https://unl.box.com/shared/static/713e2o84g4yvjloyhor60bcyn40kjgnh.tgz -o /dev/null && \
    # Make the run file executable and extract
    chmod +x *-run NVIDIA-Linux-x86_64-410.73.run && ./cuda_9.0.176_384.81_linux-run -extract=`pwd` && \
    # Install CUDA drivers (silent, no kernel)
    ./NVIDIA-Linux-x86_64-410.73.run -s --no-kernel-module && \
    # Install toolkit (silent)
     ./cuda-linux.9.0.176-22781540.run -noprompt && \
    # Patches
    ./cuda_9.0.176.1_linux-run  --silent --accept-eula && \
    ./cuda_9.0.176.2_linux-run --silent --accept-eula && \
    ./cuda_9.0.176.3_linux-run --silent --accept-eula && \
    .//cuda_9.0.176.4_linux-run --silent --accept-eula && \
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
RUN mkdir /work

# Install both 2.7/3.5 version of Python and pip
RUN apt-get update && apt-get install -y software-properties-common 
RUN apt-add-repository multiverse && apt-get update
RUN apt-get install -y libcupti-dev python-pip python-dev python3-dev python3-pip

# Install TensorFlow (and friends) for both Python 2.7 and 3.5
RUN pip install tensorflow-gpu==1.12 numpy scipy 'matplotlib<3.0' pandas scikit-learn scikit-image
RUN pip3 install tensorflow-gpu==1.12 numpy scipy matplotlib pandas scikit-learn scikit-image
