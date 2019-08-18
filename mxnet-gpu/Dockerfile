FROM unlhcc/cuda-ubuntu:10.0

# Enable https for apt
RUN apt-get -qq update && apt-get install -y -qq apt-transport-https

# Install MKL from Intel repo
RUN wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB && \
apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB && \
echo deb https://apt.repos.intel.com/mkl all main > /etc/apt/sources.list.d/intel-mkl.list && \
apt-get -qq update && \
apt-get -y -qq install intel-mkl-64bit-2019.1-053 > /dev/null && \
echo "/opt/intel/lib/intel64" >> /etc/ld.so.conf.d/intel.conf && \
echo "/opt/intel/mkl/lib/intel64" >> /etc/ld.so.conf.d/intel.conf && \
ldconfig

# Core build deps
RUN apt-get install -y -qq \
    ca-certificates \
    git \
    libcurl4-openssl-dev \
    libjemalloc-dev \
    libhdf5-dev \
    libturbojpeg \
    libzmq3-dev \
    software-properties-common \
    unzip \
    vim-nox \
    curl \
    sudo \
    pkg-config \
    ffmpeg \
    libopencv-dev

# Use libturbojpeg package as it is correctly compiled with -fPIC flag
# https://github.com/HaxeFoundation/hashlink/issues/147
RUN ln -s /usr/lib/x86_64-linux-gnu/libturbojpeg.so.0.1.0 /usr/lib/x86_64-linux-gnu/libturbojpeg.so

# Python deps
RUN apt-get install -y -q python-dev python3-dev virtualenv
# the version of the pip shipped with ubuntu may be too lower, install a recent version here
RUN wget -nv https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py && \
    python2 get-pip.py
RUN pip2 -q install nose cpplint==1.3.0 'numpy>1.16.0,<2.0.0' nose-timer 'requests<2.19.0,>=2.18.4' h5py==2.8.0rc1 scipy==1.0.1 boto3 Cython==0.29.7 \
    matplotlib scikit-learn scikit-plot
RUN pip3 -q install nose cpplint==1.3.0 pylint==2.3.1 'numpy>1.16.0,<2.0.0' nose-timer 'requests<2.19.0,>=2.18.4' h5py==2.8.0rc1 scipy==1.0.1 \
    boto3 Cython==0.29.7 matplotlib scikit-learn scikit-plot

# Note: we specify an exact cmake version to work around a cmake 3.10 CUDA 10 issue.
# Reference: https://github.com/clab/dynet/issues/1457
RUN mkdir /opt/cmake && cd /opt/cmake && \
    wget -nv https://cmake.org/files/v3.12/cmake-3.12.4-Linux-x86_64.sh && \
    sh cmake-3.12.4-Linux-x86_64.sh --prefix=/opt/cmake --skip-license && \
    ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake && \
    rm cmake-3.12.4-Linux-x86_64.sh

# Build and install mxnet with GPU and MKL
ENV MXNET_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu/libmxnet.so
RUN curl -sSL https://apache.org/dist/incubator/mxnet/1.5.0/apache-mxnet-src-1.5.0-incubating.tar.gz | tar xz -C /opt && \
    cd /opt/apache-mxnet-src-1.5.0-incubating && mkdir build && cd build && \
    cmake -DUSE_CUDA=1 -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda -DBLAS=MKL \
        -DUSE_CUDNN=1 -DUSE_MKLDNN=1 -DCMAKE_INSTALL_PREFIX=/usr -DUSE_LAPACK=OFF .. && \
    make -j 4 && make install && cp mklml/mklml_lnx_2019.0.5.20190502/lib/* /opt/intel/mkl/lib/intel64 && ldconfig && \
    cd ../python && pip install . && pip3 install . && rm -rf /opt/apache-mxnet-src-1.5.0-incubating

