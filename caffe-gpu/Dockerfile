# Start with our CUDA Ubuntu image
FROM unlhcc/cuda-ubuntu:10.2 as builder

ARG DEBIAN_FRONTEND=noninteractive

# Install build deps
RUN apt-get -qq update && apt-get install -qq -y software-properties-common apt-utils curl > /dev/null && \
    apt-add-repository multiverse && apt-get update -qq && \
    apt-get install -qq -y apt-transport-https git cmake zlib1g-dev libbz2-dev

# Install MKL from Intel repo
RUN wget -q https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB && \
    apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB && \
    echo deb https://apt.repos.intel.com/mkl all main > /etc/apt/sources.list.d/intel-mkl.list && \
    apt-get -qq update && \
    apt-get -y -qq install intel-mkl-64bit-2019.1-053 > /dev/null

# Install Python 3.7 to be more modern
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get -qq update && \
    apt-get install -qq -y python3.7 python3.7-dev python3-pip > /dev/null && \
    ln -s /usr/bin/python3.7 /usr/local/bin/python && \
    ln -s /usr/bin/python3.7 /usr/local/bin/python3 && \
    wget -q https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    pip install -U numpy

# Use GCC 4.8 instead for r2016b
RUN apt-get install -y -qq gcc-4.8 g++-4.8 gfortran-4.8 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 100 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 100 && \
    update-alternatives --install /usr/bin/gfortran gfortran /usr/bin/gfortran-4.8 100

# compile allthethings
RUN mkdir -p /opt/caffe/lib /opt/caffe/bin /opt/caffe/include /opt/src
ENV PATH=$PATH:/opt/caffe/bin LD_LIBRARY_PATH=/opt/caffe/lib LIBRARY_PATH=/opt/caffe/lib PREFIX=/opt/caffe

# protobuf
RUN  curl -sSL https://github.com/protocolbuffers/protobuf/releases/download/v2.6.1/protobuf-2.6.1.tar.gz | tar -zx -C /opt/src && \
    cd /opt/src/protobuf-2.6.1 && \
    ./configure --prefix=${PREFIX} && \
    make -j 4 >/dev/null 2>&1 && \
    make install

# boost
RUN curl -sSL http://sourceforge.net/projects/boost/files/boost/1.58.0/boost_1_58_0.tar.gz | tar -zx -C /opt/src && \
    cd /opt/src/boost_1_58_0/ && \
    ./bootstrap.sh --prefix=${PREFIX} && \
    ./b2 -j4 cxxflags='-fpermissive' install >/dev/null 2>&1

# google-glog
RUN curl -sSL https://github.com/google/glog/archive/v0.3.4.tar.gz | tar -zx -C /opt/src && \
    cd /opt/src/glog-0.3.4/ && \
    ./configure --prefix=${PREFIX} && \
    make >/dev/null 2>&1 && \
    make install

# gflags
RUN curl -sSL https://github.com/gflags/gflags/archive/v2.1.2.tar.gz | tar -zx -C /opt/src && \
    cd /opt/src/gflags-2.1.2/ && \
    mkdir build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=${PREFIX} -DBUILD_SHARED_LIBS=ON .. && \
    make >/dev/null 2>&1 && \
    make install

# hdf5
RUN curl -sSL https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-1.8.16/src/hdf5-1.8.16.tar.gz | tar -zx -C /opt/src && \
    cd /opt/src/hdf5-1.8.16/ && \
    ./configure --prefix=${PREFIX} && \
    make -j 4 >/dev/null 2>&1 && \
    make install

# leveldb
RUN curl -sSL https://github.com/google/leveldb/archive/v1.18.tar.gz | tar -zx -C /opt/src && \
    cd /opt/src/leveldb-1.18/ && \
    make >/dev/null 2>&1 && \
    cp -aR include/leveldb ${PREFIX}/include && \
    cp -a libleveldb.* ${PREFIX}/lib/

# lmdb
RUN curl -sSL https://github.com/LMDB/lmdb/archive/LMDB_0.9.17.tar.gz | tar -zx -C /opt/src/ && \
    cd /opt/src/lmdb-LMDB_0.9.17/libraries/liblmdb && \
    make >/dev/null 2>&1 && \
    make install prefix=${PREFIX}

# snappy
RUN curl -sSL https://github.com/google/snappy/releases/download/1.1.3/snappy-1.1.3.tar.gz | tar -xz -C /opt/src && \
    cd /opt/src/snappy-1.1.3/ && \
    ./configure --prefix=${PREFIX} && \
    make >/dev/null 2>&1 && \
    make install

# opencv
ADD opencv.patch /
RUN apt-get install -y -qq libpng12-dev libtiff5-dev libjpeg8-dev libeigen3-dev && \
    curl -sSL https://github.com/opencv/opencv/archive/2.4.9.tar.gz | tar -xz -C /opt/src && \
    cd /opt/src/opencv-2.4.9/ && patch -p0 < /opencv.patch && \
    mkdir build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=${PREFIX} -DCMAKE_CXX_FLAGS="-Wno-dev -Wno-deprecated-declarations -fpermissive" \
    -DWITH_CUBLAS=ON -DWITH_OPENMP=ON -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda .. && \
    make -j 4 >/dev/null 2>&1 && \
    make install

# r2016b
RUN curl -sSL https://unl.box.com/shared/static/jfo70fkei784jrquvflr5kel6ekyiofe.tgz | tar -zx -C / && ln -s /opt/matlab_r2016b /opt/matlab

ENV PYTHONPATH=/opt/caffe/python PATH=$PATH:/opt/matlab/bin MATLAB_DIR=/opt/matlab CPATH=/opt/intel/mkl/include:/opt/src/caffe-src/include:/usr/local/cuda/include

# Patch for broken matlab cmake config
ADD caffe_matlab.patch /
# Clone the Caffe repo
RUN cd /opt/src && git clone https://github.com/BVLC/caffe.git caffe-src && \
    cd caffe-src && patch -p0 </caffe_matlab.patch && \
    # Build Caffe core (for Python 3)
    mkdir build && cd build && \
    cmake -Dpython_version="3" -DBUILD_SHARED_LIBS=ON -DCUDA_ARCH_NAME='Manual' \
    -DCUDA_ARCH_BIN='sm_30 sm_35 sm_50 sm_60 sm_61 sm_62 sm_70 sm_75' -DBUILD_docs=OFF -DUSE_OPENMP=ON \
    -DBLAS="MKL" -DCMAKE_INSTALL_PREFIX=${PREFIX} -DBUILD_matlab=ON -DCMAKE_PREFIX_PATH=${PREFIX} .. && \
    make -j 4 all && \
    make install && \
    cp -R '../matlab/+caffe' /opt/caffe/matlab

FROM unlhcc/cuda-ubuntu:10.2

COPY --from=builder /opt/caffe /opt/caffe
ARG DEBIAN_FRONTEND=noninteractive
ADD caffe.conf /etc/ld.so.conf.d/
RUN ldconfig
ENV PYTHONPATH=/opt/caffe/python PATH=$PATH:/opt/caffe/bin:/opt/matlab/bin LD_LIBRARY_PATH=/opt/caffe/lib LIBRARY_PATH=/opt/caffe/lib CAFFE_ROOT=/opt/caffe MATLAB_ROOT=/opt/matlab

# Run time dependencies
RUN apt-get update && apt-get install -y -qq libpng12-0 libtiff5 libjpeg8 apt-utils apt-transport-https > /dev/null
# Install MKL from Intel repo
RUN wget -q https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB && \
    apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB && \
    echo deb https://apt.repos.intel.com/mkl all main > /etc/apt/sources.list.d/intel-mkl.list && \
    apt-get -qq update && \
    apt-get -y -qq install intel-mkl-64bit-2019.1-053 > /dev/null

# Install Python 3.7 to be more modern
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get -qq update && \
    apt-get install -qq -y python3.7 python3.7-dev python3-pip > /dev/null && \
    ln -s /usr/bin/python3.7 /usr/local/bin/python && \
    ln -s /usr/bin/python3.7 /usr/local/bin/python3 && \
    wget -q https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    pip install --no-cache-dir -U numpy

# Python packages
RUN cd /opt/caffe/python && \
    pip3 install --no-cache-dir -r requirements.txt && \
    # old dateutil package throws a syntax error
    pip3 install --no-cache-dir --upgrade python-dateutil scikit-learn
