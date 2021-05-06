FROM rocker/rstudio:3.6.3

RUN apt-get -q update && \
    apt-get -y -q install default-jdk libpcre3-dev liblzma-dev libbz2-dev libz-dev libicu-dev > /dev/null

RUN R CMD javareconf && \
    install2.r rJava > /dev/null 2>&1
