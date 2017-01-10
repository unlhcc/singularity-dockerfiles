# Start with Ubuntu base image
FROM ubuntu:14.04

# Install wget, build-essential, apt-add-repository
RUN apt-get update && apt-get install -y \
  build-essential \
  wget \
  software-properties-common \
  python-software-properties 

RUN add-apt-repository ppa:ubuntu-toolchain-r/test && \
  apt-get update && \
  apt-get install -y gcc-4.9 g++-4.9 && \
  update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 60 --slave /usr/bin/g++ g++ /usr/bin/g++-4.9

# Install X11 and deps
RUN apt-get install -y xorg

# Change to the /tmp directory
RUN cd /tmp && \
# Download DREAM3D binary tarball
  wget http://dream3d.bluequartz.net/binaries/DREAM3D-6.3.29-Linux-x86_64.tar.gz -o /dev/null && \
  tar -zxvf DREAM3D-6.3.29-Linux-x86_64.tar.gz -C /opt && \
  ln -s /opt/DREAM3D-6.3.29-Linux-x86_64 /opt/DREAM3D

# Download the extra data file
RUN wget http://dream3d.bluequartz.net/Data/Data_v6.zip -o /dev/null && \
# File is actually a .tar.gz, misnamed with .zip
  mv Data_v6.zip Data_v6.tar.gz && \
  tar -zxvf Data_v6.tar.gz -C /opt/DREAM3D/Data && \
# Clean up
  rm -f DREAM3D-6.3.29-Linux-x86_64.tar.gz Data_v6.tar.gz

# Make the /work mount point
RUN mkdir /work

# Add to path
ENV PATH=/opt/DREAM3D/Plugins:/opt/DREAM3D/bin:$PATH \
  LD_LIBRARY_PATH=/opt/DREAM3D/lib:$LD_LIBRARY_PATH

ADD environment /environment
ADD docker_environment /docker_environment
