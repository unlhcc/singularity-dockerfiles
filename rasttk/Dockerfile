FROM ubuntu:12.04

ARG DEBIAN_FRONTEND="noninteractive"
RUN apt-get -qq -y update && \
    apt-get -qq -y install wget make ca-certificates cpanminus && \
    cpanm Object::Tiny::RW && \
    wget -q https://github.com/TheSEED/RASTtk-Distribution/releases/download/v1.3.0/rasttk-v1.3.0.deb && \
    dpkg --force-depends -i rasttk-v1.3.0.deb && \
    apt-get -qq -y install -f && \
    sed -i 's|/home/olson/KB/runtime/|/usr/share/rasttk/runtime/|' /usr/share/rasttk/deployment/bin/* && \
    sed -i 's|//|/|' /usr/share/rasttk/deployment/bin/* && \
    sed -i  's|/home/olson/KB-2016-0116/ubuntu-1/rasttk-v1.3.0||g' /usr/share/rasttk/deployment/bin/*
