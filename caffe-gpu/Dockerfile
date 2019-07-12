# Start with our CUDA Ubuntu image
FROM unlhcc/cuda-ubuntu:9.2
ARG DEBIAN_FRONTEND=noninteractive

# Install 3.x version of Python devel and pip
RUN apt-get -qq update && apt-get install -qq -y software-properties-common > /dev/null && \
apt-add-repository multiverse && apt-get update -qq && \
apt-get install -qq -y libcupti-dev python3-dev python3-pip python3-numpy > /dev/null && \
apt-get install -qq -y apt-transport-https git cmake libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler libgflags-dev libgoogle-glog-dev liblmdb-dev > /dev/null && \
apt-get install -qq -y --no-install-recommends libboost-all-dev > /dev/null

# Install MKL from Intel repo
RUN wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB && \
apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB && \
echo deb https://apt.repos.intel.com/mkl all main > /etc/apt/sources.list.d/intel-mkl.list && \
apt-get -qq update && \
apt-get -y -qq install intel-mkl-64bit-2019.1-053 > /dev/null

# Setup Environment for Caffe
ENV PYTHONPATH=/opt/caffe/python PATH=$PATH:/opt/caffe/bin LD_LIBRARY_PATH=/opt/caffe/lib LIBRARY_PATH=/opt/caffe/lib

# Clone the Caffe repo
RUN cd /opt && git clone https://github.com/BVLC/caffe.git caffe-src && \
# Build Caffe core (for Python 3)
cd caffe-src && mkdir build && cd build && \
cmake -Dpython_version="3" -DBUILD_SHARED_LIBS=ON -DCUDA_ARCH_NAME='All' -DBUILD_docs=OFF -DBLAS="MKL" -DCMAKE_INSTALL_PREFIX="/opt/caffe" .. && \
make -j 4 all && \
make install && \
# Install python deps
cd /opt/caffe/python && \
pip3 install 'matplotlib<3.1' && \
pip3 install -r requirements.txt && \
# old dateutil package throws a syntax error
pip3 install --upgrade python-dateutil && \
rm -rf /opt/caffe-src
