# Start with our CUDA Ubuntu image
FROM unlhcc/cuda-ubuntu

# Install both 2.7/3.5 version of Python and pip
RUN apt-get update && apt-get install -y software-properties-common
RUN apt-add-repository multiverse && apt-get update
RUN apt-get install -y libcupti-dev python-pip python-dev python3-dev python3-pip

# Download cuDNN from Box since it requires a CUDA developer account
RUN cd /tmp && wget https://unl.box.com/shared/static/y92g0umhpcre3qr2siiqi56aos9k7yk1.tgz
RUN cd /tmp && tar -zxvf y92g0umhpcre3qr2siiqi56aos9k7yk1.tgz && mv cuda/lib64/* /usr/local/cuda/lib64 && mv cuda/include/* /usr/local/cuda/include

# Setup Environment for Caffe
ENV PYTHONPATH /opt/caffe/python
# Add caffe binaries to path
ENV PATH $PATH:/opt/caffe/.build_release/tools
# Get dependencies
RUN apt-get update && apt-get install -y \
bc \
cmake \
curl \
#gcc-4.6 \
#g++-4.6 \
#gcc-4.6-multilib \
#g++-4.6-multilib \
gfortran \
git \
libprotobuf-dev \
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
protobuf-compiler \
python-dev \
python-pip \
python-yaml \
python-numpy \
unzip \
wget \
libhdf5-dev \
python-tables

# Allow it to find CUDA libs
RUN echo "/usr/local/cuda/lib64" > /etc/ld.so.conf.d/cuda.conf && ldconfig

# Clone the Caffe repo
RUN cd /opt && git clone https://github.com/BVLC/caffe.git

# Glog
RUN cd /opt && wget https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/google-glog/glog-0.3.3.tar.gz && \
tar zxvf glog-0.3.3.tar.gz && \
cd /opt/glog-0.3.3 && \
./configure && \
make && \
make install

RUN ldconfig

# Gflags
RUN cd /opt && \
wget https://github.com/schuhschuh/gflags/archive/master.zip && \
unzip master.zip && \
cd /opt/gflags-master && \
mkdir build && \
cd /opt/gflags-master/build && \
export CXXFLAGS="-fPIC" && \
cmake .. && \
make VERBOSE=1 && \
make && \
make install

# Set hdf5 library correctly
RUN cd /usr/lib/x86_64-linux-gnu && \
ln -s libhdf5_serial.so.10.1.0 libhdf5.so && \
ln -s libhdf5_serial_hl.so.10.0.2 libhdf5_hl.so

# Build Caffe core
RUN cd /opt/caffe && \
cp Makefile.config.example Makefile.config && \
\
find . -type f -exec sed -i -e 's^"hdf5.h"^"hdf5/serial/hdf5.h"^g' -e 's^"hdf5_hl.h"^"hdf5/serial/hdf5_hl.h"^g' '{}' \; && \
echo "CXX := /usr/bin/g++" >> Makefile.config && \
sed -i 's/CXX :=/CXX ?=/' Makefile && \
make all -j8

# Run ldconfig again (not sure if needed)
RUN ldconfig

# Install python deps
RUN easy_install pillow
RUN cd /opt/caffe/python ; \
for req in $(cat requirements.txt); do pip install $req; done

# Build Caffe python bindings
RUN cd /opt/caffe && make py

# add to path
ENV PATH=/opt/caffe/build/tools:$PATH

# mount work
RUN mkdir -p /work
