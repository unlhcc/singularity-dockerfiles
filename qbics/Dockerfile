# Use Ubuntu base image
FROM ubuntu:20.04

# Install necessary dependencies
RUN apt-get update && \
  apt-get install -y wget unzip tar curl \
      libgfortran5 libgomp1 && \
  apt-get clean

# Download and extract Qbics tarball
ENV QBICS_VERSION=2.0
RUN mkdir -p /opt/qbics && cd /opt/qbics && \
    curl -o qbics.tar.gz \
        'https://uofnebraska.sharepoint.com/:u:/s/NU-HCC/IQAAjOQ3LgRvQ5xSyxYsqcjMASNHRosnm_Ayun6CgtCgcko?e=tdmQlu&download=1' \
         --location --cookie-jar /tmp/tmp && \
    tar -x --strip-components=1 -f *.tar.gz && rm *.tar.gz

# Add /opt/qbics to PATH
ENV PATH="/opt/qbics:${PATH}"
