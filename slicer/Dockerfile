# Use Centos base image
FROM centos:7
 
# Update and install dependencies
RUN yum -q -y update && \
    yum -q -y install wget zip unzip epel-release libXext libSM libXrender mesa-libGL mesa-libGLU libXtst libXt.x86_64 rh-python37 && \
    yum clean all

# Download Slicer binary distribution
RUN wget https://download.slicer.org/bitstream/1023242 && \
    tar xvf 1023242 && \
    mkdir -p /home/slicer && \
    cp -R Slicer-4.10.2-linux-amd64/* /home/slicer/ && \
    chmod u+w /home/slicer && \
    rm -rf Slicer-_* 1023242

# Set environment from source.bash
ENV PATH /home/slicer/:/home/slicer/bin:$PATH

# Mount work
RUN mkdir -p /work
