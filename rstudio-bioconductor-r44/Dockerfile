FROM bioconductor/bioconductor_docker:RELEASE_3_19

RUN apt-get -q update && \
    apt-get -y -q install lua5.3 lua-filesystem lua-posix lua-term lua-json ssh > /dev/null

# Workaround for different Ubuntu/EL lua install paths
RUN ln -s /usr/lib/x86_64-linux-gnu/lua /usr/lib64/lua

# Restore PATH so OOD can find rsession
ENV PATH=/usr/lib/rstudio-server/bin:$PATH
