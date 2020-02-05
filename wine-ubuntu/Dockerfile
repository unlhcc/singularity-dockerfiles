# Start with Ubuntu base image
FROM ubuntu:16.04

ARG DEBIAN_FRONTEND="noninteractive"
WORKDIR /
ENV WINEPREFIX=/wineprefix64
ENV WINEDEBUG=-all,err-all

RUN apt-get -y -qq update && apt-get -y -qq install patch wget software-properties-common apt-transport-https

RUN dpkg --add-architecture i386 && \
    wget -nc https://dl.winehq.org/wine-builds/winehq.key && \
    apt-key add winehq.key && \
    apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ xenial main' && \
    apt update && \
    apt -y -qq install --install-recommends winehq-stable && \
    wine winecfg && sleep 10

# Force using /tmp for TEMP and TMP variables.
# Yes, that is as insane as it looks
RUN sed -i s#C:\\\\\\\\users\\\\\\\\root\\\\\\\\Temp#Z:\\\\\\\\tmp#g /wineprefix64/user.reg

ADD mywine /usr/bin/mywine
RUN chmod +x /usr/bin/mywine
