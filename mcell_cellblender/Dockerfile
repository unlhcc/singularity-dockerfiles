FROM ubuntu:20.04

# Installation instructions, https://mcell.org/mcell4_documentation/installation.html

## TZDATA environment variables
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ America/Chicago
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN apt-get update && \
    apt-get install -y libxi6 libgconf-2-4 libxxf86vm-dev libxfixes-dev \
        libglu1-mesa-dev wget libfontconfig1 libxrender1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download Linux (Debian 9 & 10, Ubuntu 18.04 & 20.04) tarball
# https://mcell.org/download.html
RUN mkdir -p /opt/mcell_cellblender && \
    wget --no-check-certificate -O /opt/mcell_cellblender.tar.gz https://mcell.org/downloads/Blender-2.93-CellBlender-4.0.6-Debian-GNU-Linux-9-20220708.tar.gz && \
    tar -xvf /opt/mcell_cellblender.tar.gz --strip-components=1 -C /opt/mcell_cellblender && \
    rm /opt/mcell_cellblender.tar.gz

# Set variables, https://mcell.org/mcell4_documentation/installation.html#id3
ENV CELLBLENDER_BASE_PATH=/opt/mcell_cellblender/2.93/
ENV MCELL_PATH=${CELLBLENDER_BASE_PATH}/scripts/addons/cellblender/extensions/mcell/
ENV PATH=${PATH}:${CELLBLENDER_BASE_PATH}/python/bin/:${CELLBLENDER_BASE_PATH}/scripts/addons/cellblender/extensions/mcell/:/opt/mcell_cellblender/

WORKDIR /opt/mcell_cellblender
