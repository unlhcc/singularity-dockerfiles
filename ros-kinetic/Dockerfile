# Start with base image
FROM ros:kinetic-ros-core-xenial

# Install ros packages
RUN apt-get -q update && apt-get -qq install -y libxt6 curl \
    ros-kinetic-ros-base=1.3.2-0* \
    && rm -rf /var/lib/apt/lists/*

# Install Miniconda
ENV CONDA_DIR=/opt/conda \
    PATH=/opt/conda/bin:$PATH
RUN echo "Downloading Miniconda installer ..." \
    && miniconda_installer=/tmp/miniconda.sh \
    && curl -sSL -o $miniconda_installer https://repo.continuum.io/miniconda/Miniconda3-4.3.31-Linux-x86_64.sh \
    && /bin/bash $miniconda_installer -b -p $CONDA_DIR \
    && rm -f $miniconda_installer
 
# Env setup
ADD environment /environment
ADD docker_environment /docker_environment

# Mount work
RUN mkdir -p /work
