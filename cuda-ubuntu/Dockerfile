# Start with Ubuntu base image
FROM ubuntu:16.04

# Install wget and build-essential
RUN apt-get update && apt-get install -y \
  build-essential \
  wget vim  module-init-tools

RUN cd /tmp && \
    # Download run file
    wget https://developer.nvidia.com/compute/cuda/9.2/Prod2/local_installers/cuda_9.2.148_396.37_linux -o /dev/null && \
    # Patch 1
    wget https://developer.nvidia.com/compute/cuda/9.2/Prod2/patches/1/cuda_9.2.148.1_linux -o /dev/null && \
    # The driver version must match exactly what's installed on the GPU nodes, so install it separately
    wget http://us.download.nvidia.com/XFree86/Linux-x86_64/410.73/NVIDIA-Linux-x86_64-410.73.run -o /dev/null && \
    # cuDNN library
    wget https://unl.box.com/shared/static/73ynfk4rwk6hxofi58r60u1vtmbqp09v.tgz -o /dev/null && \
    # Make the run file executable and extract
    chmod +x cuda_9.2.148_396.37_linux cuda_9.2.148.1_linux NVIDIA-Linux-x86_64-410.73.run && ./cuda_9.2.148_396.37_linux -extract=`pwd` && \
    # Install CUDA drivers (silent, no kernel)
    ./NVIDIA-Linux-x86_64-410.73.run -s --no-kernel-module && \
    # Install toolkit (silent)
     ./cuda-linux.9.2.148-24330188.run -noprompt && \
    # Install Patch 1
    ./cuda_9.2.148.1_linux --silent --accept-eula && \
    # Install cuDNN
    tar -zxvf 73ynfk4rwk6hxofi58r60u1vtmbqp09v.tgz && \
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
