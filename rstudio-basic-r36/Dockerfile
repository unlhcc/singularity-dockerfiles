FROM rocker/rstudio:3.6.3

RUN apt-get -q update && \
    apt-get -y -q install default-jdk > /dev/null

RUN R CMD javareconf && \
    install2.r rJava > /dev/null 2>&1
