# Adapted from https://github.com/guanjue/S3V2_IDEAS_ESMP/blob/master/test_run_S3V2_in_Docker_container/Dockerfile
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends build-essential gfortran git time bash wget make vim curl

RUN cd /tmp && wget http://www.unafold.org/download/mfold-3.6.tar.gz && tar xvf mfold-3.6.tar.gz && \
    cd mfold-3.6 && \
    ./configure --prefix=/usr/local && \
    make -j 4 && \
    make install
