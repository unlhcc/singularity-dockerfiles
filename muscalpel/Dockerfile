FROM ubuntu:14.04
MAINTAINER Alex Marginean "alexandru.marginean.13@ucl.ac.uk"

ADD sources.list /etc/apt/sources.list
#install the requirements for muScalpel
RUN apt-get update && apt-get install -y git wget gcc-4.8 g++-4.8 gfortran-4.8 autoconf automake libtool flex bison vim cflow make check pkg-config libglib2.0-dev libgcrypt20 vlc sox

RUN apt-get update && apt-get install -y automake1.11 autoconf2.64 autopoint lcov pidgin gettext gtk2hs-buildtools libgcrypt11-dev zlib1g-dev
RUN apt-get update && apt-get build-dep -y pidgin
RUN apt-get build-dep -y vlc
RUN apt-get build-dep -y x264

RUN cp /usr/bin/gcc-4.8 /usr/bin/gcc>/dev/null || :
RUN cp /usr/bin/g++-4.8 /usr/bin/g++>/dev/null || :
RUN cp /usr/bin/gfortran-4.8 /usr/bin/gfortran>/dev/null || :

RUN mkdir -p /work /home /output
# Download the software and untar in /usr/local
RUN cd /tmp && wget https://unl.box.com/shared/static/54bdf1ri76w601b1st7gnlx7z6omngcn.tgz -o /dev/null && \
  tar -C /usr/local -zxf 54bdf1ri76w601b1st7gnlx7z6omngcn.tgz && \
  rm /tmp/54bdf1ri76w601b1st7gnlx7z6omngcn.tgz

# Add the top-level package directory to the PATH
ENV PATH=/usr/local/SharedFolder/AllScripts:$PATH
