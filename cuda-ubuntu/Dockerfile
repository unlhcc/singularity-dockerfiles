# Start with Ubuntu base image
FROM ubuntu

# Install wget and build-essential
RUN apt-get update && apt-get install -y \
  build-essential \
  wget vim  module-init-tools

RUN cd /tmp && \
    # Download run file
    wget https://developer.nvidia.com/compute/cuda/8.0/prod/local_installers/cuda_8.0.44_linux-run -o /dev/null && \
    # The driver version must match exactly what's installed on the GPU nodes, so install it separately
    wget http://us.download.nvidia.com/XFree86/Linux-x86_64/367.57/NVIDIA-Linux-x86_64-367.57.run

# Make the run file executable and extract
RUN cd /tmp && chmod +x cuda_8.0.44_linux-run NVIDIA-Linux-x86_64-367.57.run && ./cuda_8.0.44_linux-run -extract=`pwd` && \
    # Install CUDA drivers (silent, no kernel)
    ./NVIDIA-Linux-x86_64-367.57.run -s --no-kernel-module && \
     # Install toolkit (silent)
     ./cuda-linux64-rel-*.run -noprompt && \
    # Clean up
    rm -rf /tmp/cuda* /tmp/NVIDIA*

ENV PATH=/usr/local/cuda/bin:$PATH \
  LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH \
  CUDA_HOME=/usr/local/cuda

ADD environment /environment
ADD docker_environment /docker_environment
RUN mkdir /work
