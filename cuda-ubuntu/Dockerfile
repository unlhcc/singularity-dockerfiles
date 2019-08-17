# Start with Ubuntu base image
FROM ubuntu:16.04

# Install wget and build-essential
RUN apt-get update && apt-get install -y -qq \
  build-essential \
  wget vim  module-init-tools > /dev/null

RUN cd /tmp && \
    # Download run file
    wget https://developer.nvidia.com/compute/cuda/10.0/Prod/local_installers/cuda_10.0.130_410.48_linux -o /dev/null && \
    # Patch 1
    wget http://developer.download.nvidia.com/compute/cuda/10.0/Prod/patches/1/cuda_10.0.130.1_linux.run -o /dev/null && \
    # The driver version must match exactly what's installed on the GPU nodes, so install it separately
    wget http://us.download.nvidia.com/XFree86/Linux-x86_64/410.73/NVIDIA-Linux-x86_64-410.73.run -o /dev/null && \
    # cuDNN library
    wget https://unl.box.com/shared/static/s1xz9rf2nd0ui4woki5o5d5itru2papx.tgz -o /dev/null && \
    # Make the run file executable and extract
    chmod +x cuda_10.0.130_410.48_linux cuda_10.0.130.1_linux.run NVIDIA-Linux-x86_64-410.73.run && ./cuda_10.0.130_410.48_linux -extract=`pwd` && \
    # Install CUDA drivers (silent, no kernel)
    ./NVIDIA-Linux-x86_64-410.73.run -s --no-kernel-module && \
    # Install toolkit (silent)
     ./cuda-linux.10.0.130-24817639.run -noprompt && \
    # Install Patch 1
    ./cuda_10.0.130.1_linux.run --silent --accept-eula && \
    # Install cuDNN
    tar -zxvf s1xz9rf2nd0ui4woki5o5d5itru2papx.tgz && \
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
