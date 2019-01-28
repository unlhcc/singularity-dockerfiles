FROM ubuntu:12.04

WORKDIR /build
ADD SURPI_setup.sh .
RUN apt-get update -qq && \
    apt-get install -qq curl wget sudo && \
    bash ./SURPI_setup.sh && \
    mkdir -p /work && \
    rm -rf /build

ENV JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/jre
ENV EC2_HOME=/usr/local/ec2/ec2-api-tools-1.6.13.0
ENV PATH=$PATH:/usr/local/bin/surpi
