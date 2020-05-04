# Start with Ubuntu base image
FROM ubuntu:16.04

# Install wget and build-essential
RUN apt-get update && apt-get install -y -qq \
  build-essential \
  wget vim module-init-tools libxml2 > /dev/null

RUN cd /tmp && \
    # Download run file
    wget http://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda_10.2.89_440.33.01_linux.run -o /dev/null && \
    # cuDNN library
    wget https://unl.box.com/shared/static/ocsjhy347tc8gan88xvazcpxx56qovf4.tgz -o /dev/null && \
    # NCCL
    wget https://unl.box.com/shared/static/4b4jlzroeii6ug13il4jlhjz5yr32bki.txz -o /dev/null && \
    # Make the run file executable and extract
    chmod +x cuda_10.2.89_440.33.01_linux.run && \
    # Install toolkit (silent)
     ./cuda_10.2.89_440.33.01_linux.run --toolkit --silent && \
    # Install cuDNN
    tar -zxvf ocsjhy347tc8gan88xvazcpxx56qovf4.tgz && \
    cp -a cuda/lib64/* /usr/local/cuda/lib64 && cp -a cuda/include/* /usr/local/cuda/include && \
    # Install NCCL
    tar -Jxvf 4b4jlzroeii6ug13il4jlhjz5yr32bki.txz && cp -a nccl_2.6.4-1+cuda10.2_x86_64/lib/* /usr/local/cuda/lib64 && \
    cp -a nccl_2.6.4-1+cuda10.2_x86_64/include/* /usr/local/cuda/include && \
    # Clean up
    rm -rf /tmp/cuda* /tmp/NVIDIA* /tmp/*.tgz  /tmp/*.txz

ENV PATH=/usr/local/cuda/bin:$PATH \
  LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH \
  CUDA_HOME=/usr/local/cuda \
  LC_ALL=C

ADD cuda.conf /etc/ld.so.conf.d
RUN ldconfig -v

RUN mkdir /work /common
