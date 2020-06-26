FROM ubuntu:16.04

ENV tag=Linux ANACONDA_PREFIX="/anaconda" MINICONDA_VER="4.6.14"

RUN apt-get update && \
    apt-get install -y -q curl bzip2

# install (Mini)conda
RUN curl -L -O https://repo.continuum.io/miniconda/Miniconda3-$MINICONDA_VER-$tag-x86_64.sh && \
    bash Miniconda3-$MINICONDA_VER-$tag-x86_64.sh -b -p $ANACONDA_PREFIX && \
    . ${ANACONDA_PREFIX}/etc/profile.d/conda.sh && \
    # set the channel order
    conda config --system --add channels bioconda && \
    conda config --system --add channels conda-forge && \
    conda config --system --add channels hcc && \
    conda install -y -q r-base=3.6 r-inla=20.03.17 r-tidyverse

ENV PATH=$PATH:$ANACONDA_PREFIX/bin
