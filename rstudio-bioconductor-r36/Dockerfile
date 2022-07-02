FROM bioconductor/bioconductor_docker:RELEASE_3_10

RUN apt-get -q update && \
    apt-get -y -q install lua5.3 lua-filesystem lua-posix lua-term lua-json bsdutils > /dev/null

# Workaround for different Ubuntu/EL lua install paths
RUN mkdir -p /usr/lib64 && ln -s /usr/lib/x86_64-linux-gnu/lua /usr/lib64/lua
RUN ln -s /usr/bin/logger /bin/logger
