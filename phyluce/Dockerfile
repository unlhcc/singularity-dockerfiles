## This image is modification of https://github.com/faircloth-lab/phyluce/blob/main/docker/Dockerfile

FROM ubuntu:20.04

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

ENV PHYLUCE_VERSION 1.7.3

# add a user and a group for phyluce
RUN groupadd -g 999 phyluce && \
    useradd -r -u 999 -g phyluce phyluce

# update yum
RUN apt-get update -q && \
    apt-get install -q -y \
        bzip2 \
        ca-certificates \
        git \
        libglib2.0-0 \
        libsm6 \
        libxext6 \
        libxrender1 \
        wget \
    && apt-get clean

# download conda - code from https://github.com/ContinuumIO/docker-images/blob/master/miniconda3/debian/Dockerfile
RUN wget --quiet -O miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    mkdir -p /opt && \
    bash miniconda.sh -b -p /opt/conda && \
    rm miniconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy

# set conda REPOS
RUN /opt/conda/bin/conda config --add channels defaults
RUN /opt/conda/bin/conda config --add channels bioconda
RUN /opt/conda/bin/conda config --add channels conda-forge

# update conda
RUN /opt/conda/bin/conda update conda

# get gatk, setup, and cleanup
RUN wget --quiet https://raw.githubusercontent.com/faircloth-lab/phyluce/main/distrib/phyluce-${PHYLUCE_VERSION}-py36-Linux-conda.yml
RUN /opt/conda/bin/conda env create -n phyluce --file phyluce-${PHYLUCE_VERSION}-py36-Linux-conda.yml

# cleanup
RUN /opt/conda/bin/conda clean --all --yes

# setup working dir in /data
RUN mkdir -p /data
RUN chown phyluce:phyluce /data
WORKDIR /data

# activate conda environment
RUN echo "source activate phyluce" > ~/.bashrc
ENV PATH /opt/conda/envs/phyluce/bin:/opt/conda/bin:$PATH

# switch to phyluce user
USER phyluce
