FROM rocker/geospatial:4.0.5

RUN apt-get update && \
    apt-get -y -q install default-jdk lua5.3 lua-filesystem lua-posix lua-term lua-json > /dev/null

RUN R CMD javareconf && \
    install2.r rJava > /dev/null 2>&1

# Workaround for different Ubuntu/EL lua install paths
RUN ln -s /usr/lib/x86_64-linux-gnu/lua /usr/lib64/lua
