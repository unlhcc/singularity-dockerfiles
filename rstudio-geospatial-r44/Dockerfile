FROM rocker/geospatial:4.4.1

RUN apt-get update && \
    apt-get -y install lua5.3 lua-filesystem lua-posix lua-term lua-json ssh > /dev/null

# Workaround for different Ubuntu/EL lua install paths
RUN ln -s /usr/lib/x86_64-linux-gnu/lua /usr/lib64/lua

# Restore PATH so OOD can find rsession
ENV PATH=/usr/lib/rstudio-server/bin:$PATH
