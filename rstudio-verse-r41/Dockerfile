FROM rocker/verse:4.1.2

RUN apt-get update && \
    apt-get -y -q install default-jdk tk8.6 > /dev/null

RUN R CMD javareconf && \
    install2.r rJava > /dev/null 2>&1
