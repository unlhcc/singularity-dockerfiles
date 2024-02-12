FROM centos:7

RUN yum install -y -q gdb

ENV BCL_CONVERT_VERSION 4.2.7
RUN rpm -i https://s3.amazonaws.com/webdata.illumina.com/downloads/software/bcl-convert/bcl-convert-${BCL_CONVERT_VERSION}-2.el7.x86_64.rpm && \
    yum clean all && \
    rm -rf /var/cache/yum

ENV PATH /usr/bin/:$PATH
