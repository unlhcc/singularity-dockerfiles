FROM rocker/tidyverse:4.5.1

RUN apt-get update && \
    apt-get -y -q install default-jdk tk8.6 lua5.3 lua-filesystem lua-posix lua-term lua-json ssh libglpk-dev > /dev/null

RUN R CMD javareconf && \
    install2.r rJava && \
    # Workshop Libraries
    install2.r here janitor gt gtsummary bibliometrix > /dev/null 2>&1

# Workaround for different Ubuntu/EL lua install paths
RUN ln -s /usr/lib/x86_64-linux-gnu/lua /usr/lib64/lua

# Restore PATH so OOD can find rsession
ENV PATH=/usr/lib/rstudio-server/bin:$PATH
