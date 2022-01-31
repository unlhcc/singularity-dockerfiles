# Adapted from https://github.com/guanjue/S3V2_IDEAS_ESMP/blob/master/test_run_S3V2_in_Docker_container/Dockerfile
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends build-essential r-base r-cran-randomforest python3.6 python3-pip python3-setuptools python3-dev git time bash wget make bedtools vim curl

RUN pip3 install numpy
RUN pip3 install scipy
RUN pip3 install multiprocess
RUN ln -s /usr/bin/python3 /usr/bin/python

RUN Rscript -e "install.packages('data.table')"
RUN Rscript -e "install.packages('doParallel')"
RUN Rscript -e "install.packages('foreach')"

RUN cd /tmp && curl -sSL ftp://ftp.gnu.org/gnu/gsl/gsl-2.2.1.tar.gz | tar -xz && \
    cd gsl-2.2.1 && \
    ./configure --prefix=/usr/local && \
    make -j 4 && \
    make install && \
    ldconfig

WORKDIR /app
RUN git clone https://github.com/guanjue/S3V2_IDEAS_ESMP.git
RUN chmod +x /app/S3V2_IDEAS_ESMP/bin/*.py && \
    sed -i '1i #!/usr/bin/env python' /app/S3V2_IDEAS_ESMP/bin/*.py

ENV PATH=/app/S3V2_IDEAS_ESMP/bin:$PATH
