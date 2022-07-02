FROM rocker/geospatial:3.6.3

RUN apt-get update --allow-releaseinfo-change && \
    apt-get -y -q install default-jdk libpcre3-dev liblzma-dev libbz2-dev libz-dev libicu-dev lua5.3 lua-filesystem lua-posix lua-term lua-json bsdutils > /dev/null

RUN R CMD javareconf && \
    install2.r rJava > /dev/null 2>&1

RUN ln -s /bin/bash /usr/bin/bash

# Workaround for different Ubuntu/EL lua install paths
RUN mkdir -p /usr/lib64 && ln -s /usr/lib/x86_64-linux-gnu/lua /usr/lib64/lua
RUN ln -s /usr/bin/logger /bin/logger
