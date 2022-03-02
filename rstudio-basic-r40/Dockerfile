FROM rocker/rstudio:4.0.5

RUN apt-get -q update && \
    apt-get -y -q install default-jdk tk8.6 > /dev/null

RUN R CMD javareconf && \
    install2.r rJava > /dev/null 2>&1
