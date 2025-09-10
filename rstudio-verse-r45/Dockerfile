FROM rocker/verse:4.5.1

RUN apt-get -q update && \
    apt-get -y -q install default-jdk tk8.6 lua5.3 lua-filesystem lua-posix lua-term lua-json ssh > /dev/null

RUN R CMD javareconf && \
    install2.r rJava > /dev/null 2>&1

# Workaround for different Ubuntu/EL lua install paths
RUN ln -s /usr/lib/x86_64-linux-gnu/lua /usr/lib64/lua

# Restore PATH so OOD can find rsession
ENV PATH=/usr/lib/rstudio-server/bin:$PATH
