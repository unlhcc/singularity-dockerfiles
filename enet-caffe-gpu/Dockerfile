# Start with our CUDA Ubuntu image
FROM unlhcc/cuda-ubuntu:9.2

# Install both 2.7/3.5 version of Python and pip
RUN apt-get -qq update && apt-get install -qq -y software-properties-common > /dev/null
RUN apt-add-repository multiverse && apt-get update -qq
RUN apt-get install -qq -y libcupti-dev python-pip python-dev python3-dev python3-pip > /dev/null

# Download cuDNN, cudnn-8.0-linux-x64-v5.1, from Box since it requires a CUDA developer account
RUN cd /tmp && wget -q https://unl.box.com/shared/static/4sdb6lv5kzieu25akrvmuuy0s3p1jetc.tgz
RUN cd /tmp && tar -zxvf 4sdb6lv5kzieu25akrvmuuy0s3p1jetc.tgz && mv cuda/lib64/* /usr/local/cuda/lib64 && mv cuda/include/* /usr/local/cuda/include

# Get dependencies
RUN apt-get -qq update && apt-get install -qq -y \
bc \
cmake \
curl \
#gcc-4.6 \
#g++-4.6 \
#gcc-4.6-multilib \
#g++-4.6-multilib \
gfortran \
git \
libleveldb-dev \
libsnappy-dev \
libopencv-dev \
libboost-all-dev \
libhdf5-serial-dev \
liblmdb-dev \
libjpeg62 \
libfreeimage-dev \
libatlas-base-dev \
pkgconf \
python-dev \
python-pip \
python-yaml \
python-numpy \
unzip \
wget \
libhdf5-dev \
libgflags-dev \
libgoogle-glog-dev \
liblmdb-dev \
doxygen \
python-tables > /dev/null

# Allow it to find CUDA libs
RUN echo "/usr/local/cuda/lib64" > /etc/ld.so.conf.d/cuda.conf && ldconfig

# Set hdf5 library correctly
RUN cd /usr/lib/x86_64-linux-gnu && \
ln -s libhdf5_serial.so.10.1.0 libhdf5.so && \
ln -s libhdf5_serial_hl.so.10.0.2 libhdf5_hl.so && \
ldconfig

# Clone the ENet repo
RUN cd /opt && git clone --recursive https://github.com/TimoSaemann/ENet.git

# Install dependencies for ENet
RUN pip install --upgrade pip \
        'scikit-image<0.15' \
        'numpy<1.17.0' \
        google \
        opencv-python \
        configargparse \
        'scipy<1.3.0' \
        'networkx==2.2' \
        'matplotlib<3.0'
RUN apt-get -qq -y remove --purge libprotobuf-dev && \
apt-get -qq -y install libprotobuf-dev protobuf-compiler python-protobuf && \
ldconfig

# Build ENet
RUN cd /opt/ENet/caffe-enet && \
mkdir build && cd build && \
cmake -DUSE_CUDNN=1 \
    -DCUDA_ARCH_NAME="Manual" \
    -DCUDA_ARCH_BIN="30 35 50 60 61" \
    -DCUDA_ARCH_PTX="30 35 50 60 61"  .. && \
find . -type f -exec sed -i -e 's^"hdf5.h"^"hdf5/serial/hdf5.h"^g' -e 's^"hdf5_hl.h"^"hdf5/serial/hdf5_hl.h"^g' '{}' \; && \
sed -i 's/CXX :=/CXX ?=/' Makefile && \
make all -j8 && \
make pycaffe && \
# set permissions to python and help scripts
chmod a+xwr /opt/ENet/caffe-enet/python/*.py && \
chmod a+xwr /opt/ENet/caffe-enet/build/tools/* && \
chmod a+xwr /opt/ENet/scripts/*.py

# Run ldconfig again (not sure if needed)
RUN ldconfig

# add to path
ENV PATH /opt/ENet/caffe-enet/python:/opt/ENet/caffe-enet/build/tools:/opt/ENet/scripts:$PATH
ENV PYTHONPATH /opt/ENet/caffe-enet/python/

# mount work
RUN mkdir -p /work

# Add custom environment files
ADD environment /environment
ADD docker_environment /docker_environment
