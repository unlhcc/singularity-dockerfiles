FROM centos:centos7

COPY build-mitsuba.sh /tmp
RUN yum install -y -q epel-release && \
    yum install -y -q scons \
                      unzip \
                      boost-devel \
                      eigen3-devel \
                      fftw-devel \
                      gcc-c++ \
                      glew-devel \
                      libGLEWmx \
                      libjpeg-devel \
                      libpng-devel \
                      mesa-libGL-devel \
                      mesa-libGLU-devel \
                      OpenEXR-devel \
                      xerces-c-devel && \
    yum clean all -q && \
    /tmp/build-mitsuba.sh && \
    mkdir -p /work /common
