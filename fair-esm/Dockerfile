# This image is modification of https://github.com/facebookresearch/esm/blob/b5abe11e5b288ef2bfce5e77d4ade97111ae6a35/Dockerfile

FROM nvidia/cuda:11.8.0-base-ubuntu22.04 as base 
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG C.UTF-8

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get -qq update \
    && apt-get -qq install -y gnupg ca-certificates wget git \
    && apt-get -qq clean \
    && rm -rf /var/lib/apt/lists/*

RUN  export DEBIAN_FRONTEND=noninteractive \
    && wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb \
    && dpkg -i cuda-keyring_1.1-1_all.deb \
    && apt-get -qq update \ 
    && apt-get install -y --no-install-recommends \
        cuda-command-line-tools-11-8 \
        cuda-cudart-dev-11-8 \ 
        cuda-nvcc-11-8 \
        cuda-cupti-11-8 \
        cuda-nvprune-11-8 \
        cuda-libraries-11-8 \
        cuda-nvrtc-11-8 \ 
        libcufft-11-8 \
        libcurand-11-8 \
        libcusolver-dev-11-8 \ 
        libcusparse-dev-11-8 \
        libcublas-dev-11-8 \
        libcudnn8=8.6.0.163-1+cuda11.8 \
        libnvinfer-plugin8=8.6.1.6-1+cuda11.8 \
        libnvinfer8=8.6.1.6-1+cuda11.8 \
        build-essential \
        pkg-config \
        curl \
        software-properties-common \
        unzip \
    && apt-get -qq clean \
    && rm -rf /var/lib/apt/lists/* 

RUN find /usr/local/cuda-*/lib*/ -type f -name 'lib*_static.a' -not -name 'libcudart_static.a' -delete \
    && rm -f /usr/lib/x86_64-linux-gnu/libcudnn_static_v*.a \ 
    && ln -s /usr/local/cuda/lib64/stubs/libcuda.so /usr/local/cuda/lib64/stubs/libcuda.so.1 \
    && echo "/usr/local/cuda/lib64/stubs" > /etc/ld.so.conf.d/z-cuda-stubs.conf \
    && ldconfig

# Install miniconda
RUN MINICONDA="Miniconda3-latest-Linux-x86_64.sh" \
    && wget --quiet https://repo.continuum.io/miniconda/$MINICONDA \
    && bash $MINICONDA -b -p /miniconda \
    && rm -f $MINICONDA
ENV PATH="/miniconda/bin:$PATH"

# Install conda packages.
COPY environment.yml .
RUN conda env create -f environment.yml
ENV PATH "/miniconda/envs/esmfold/bin:$PATH"
RUN echo ". /miniconda/etc/profile.d/conda.sh" >> ~/.bashrc
RUN echo "conda activate esmfold" >> ~/.bashrc

# Install esmfold
# use most recent GitHub commit
# CLI scripts are added after PyPI version 2.0.0, https://github.com/facebookresearch/esm/issues/577
# Using setup.py gives error, https://github.com/facebookresearch/esm/issues/511
#ENV ESM_COMMIT=2b369911bb5b4b0dda914521b9475cad1656b2ac
#RUN wget -q -P ./esm https://github.com/facebookresearch/esm/archive/${ESM_COMMIT}.tar.gz \
#    && tar xvf ./esm/${ESM_COMMIT}.tar.gz -C ./esm --strip-components 1 \
#    && rm ./esm/${ESM_COMMIT}.tar.gz \
#    && cd ./esm && /miniconda/envs/esmfold/bin/python setup.py install

# Copy Python scripts 
ENV ESM_VERSION=2.0.0
RUN wget -q -P ./esm https://github.com/facebookresearch/esm/archive/v${ESM_VERSION}.tar.gz \
    && tar xvf ./esm/v${ESM_VERSION}.tar.gz -C ./esm --strip-components 1 \
    && rm ./esm/v${ESM_VERSION}.tar.gz
ENV ESM_SCRIPTS "/esm"
