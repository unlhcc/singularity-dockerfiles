# Start with Ubuntu base image
FROM ubuntu:16.04

# Env setup
ADD environment /environment
ADD docker_environment /docker_environment
ADD cuda.conf /etc/ld.so.conf.d

# Install wget and build-essential
RUN apt-get update -qq  && apt-get install -y -qq \
    build-essential \
    wget vim  module-init-tools > /dev/null && \
    cd /tmp && \
    # Download run file
    wget -q https://developer.nvidia.com/compute/cuda/9.0/Prod/local_installers/cuda_9.0.176_384.81_linux-run && \
    # The driver version must match exactly what's installed on the GPU nodes, so install it separately
    wget -q http://us.download.nvidia.com/XFree86/Linux-x86_64/375.66/NVIDIA-Linux-x86_64-375.66.run && \
    # Download patch file
    wget -q https://developer.nvidia.com/compute/cuda/9.0/Prod/patches/1/cuda_9.0.176.1_linux-run && \
    # Make the run files executable and extract
    chmod +x cuda_9.0.176_384.81_linux-run NVIDIA-Linux-x86_64-375.66.run cuda_9.0.176.1_linux-run && \
    ./cuda_9.0.176_384.81_linux-run -extract=`pwd` && \
    # Install CUDA drivers (silent, no kernel)
    ./NVIDIA-Linux-x86_64-375.66.run -s --no-kernel-module && \
    # Install toolkit (silent)
    ./cuda-linux.9.0.176-22781540.run -noprompt && \
    # Install patch
    ./cuda_9.0.176.1_linux-run --silent --accept-eula && \
    # Install cuDNN v7
    cd /tmp && wget -q https://unl.box.com/shared/static/wgczb96wddjcur0tq9c8hhnog8emcnvf.tgz && \
    cd /tmp && tar -zxf wgczb96wddjcur0tq9c8hhnog8emcnvf.tgz && mv cuda/lib64/* /usr/local/cuda/lib64 && mv cuda/include/* /usr/local/cuda/include && \
    # Clean up
    rm -rf /tmp/cuda* /tmp/NVIDIA* /tmp/*.tgz && \
    # Make /work mount
    mkdir /work && \
    # Update lib cache
    ldconfig

ENV PATH=/usr/local/cuda/bin:$PATH \
  LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH \
  CUDA_HOME=/usr/local/cuda
