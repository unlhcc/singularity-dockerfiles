# Start with Ubuntu base image
FROM ubuntu:16.04
ARG DEBIAN_FRONTEND=noninteractive
ENV DREAM3D_VERSION="6.5.138"

# Install wget, build-essential, apt-add-repository
RUN apt-get update && apt-get install -y -q \
  build-essential \
  wget curl \
  software-properties-common \
  python-software-properties libtbb2
# The new version requires libtbb.so.2

RUN add-apt-repository ppa:ubuntu-toolchain-r/test && \
  apt-get update && \
  apt-get install -q -y gcc-4.9 g++-4.9 xorg && \
  update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.9

# Download DREAM3D binary tarball
RUN  curl -sSL http://dream3d.bluequartz.net/binaries/DREAM3D-${DREAM3D_VERSION}-Linux-x86_64.tar.gz | tar -zx -C /opt && \
  ln -s /opt/DREAM3D-${DREAM3D_VERSION}-Linux-x86_64 /opt/DREAM3D && \
  ln -s /opt/DREAM3D/lib/*.plugin /opt/DREAM3D/Plugins/ && \
  ln -s /usr/lib/x86_64-linux-gnu/mesa/libGL.so.1 /opt/DREAM3D/lib

# Download the extra data file
RUN curl -sSL http://dream3d.bluequartz.net/binaries/DREAM3D_Data.tar.gz | tar -xz -C /opt/DREAM3D/Data

# Make the /work & /common mount points
RUN mkdir /work /common

# Add to path
ENV PATH=/opt/DREAM3D/Plugins:/opt/DREAM3D/bin:$PATH

ADD dream3d.conf /etc/ld.so.conf.d
RUN ldconfig -v
