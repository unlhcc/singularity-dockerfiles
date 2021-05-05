FROM rocker/verse:4.0.5

RUN apt-get update && \
    apt-get -y -q install default-jdk > /dev/null

RUN R CMD javareconf && \
    install2.r rJava > /dev/null 2>&1
