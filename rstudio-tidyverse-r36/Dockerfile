FROM rocker/tidyverse:3.6.3

# Use `--allow-releaseinfo-change` to fix:
# Repository 'http://security.debian.org/debian-security buster/updates InRelease' changed its 'Suite' value from 'stable' to 'oldstable'
# Repository 'http://deb.debian.org/debian buster InRelease' changed its 'Suite' value from 'stable' to 'oldstable'
# Repository 'http://deb.debian.org/debian buster-updates InRelease' changed its 'Suite' value from 'stable-updates' to 'oldstable-updates' errors
RUN apt-get update --allow-releaseinfo-change && \
    apt-get -y -q install default-jdk libpcre3-dev liblzma-dev libbz2-dev libz-dev libicu-dev tk8.6 lua5.3 lua-filesystem lua-posix lua-term lua-json> /dev/null

RUN R CMD javareconf && \
    install2.r rJava > /dev/null 2>&1

RUN ln -s /bin/bash /usr/bin/bash

# Workaround for different Ubuntu/EL lua install paths
RUN mkdir -p /usr/lib64 && ln -s /usr/lib/x86_64-linux-gnu/lua /usr/lib64/lua
