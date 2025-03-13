# Use Ubuntu base image
FROM ubuntu:20.04

# Install necessary dependencies
RUN apt-get update && \
  apt-get install -y wget unzip tar && \
  apt-get clean

# Download and extract Qbics tarball
RUN wget https://qbics.info/upload/qbics-0.3-linux-cpu.tar.gz && \
  mkdir -p /opt/qbics && \
  tar -xzvf qbics-0.3-linux-cpu.tar.gz -C /opt/qbics && \
  chmod +x /opt/qbics/qbics-linux-cpu && \
  rm -rf qbics-0.3-linux-cpu.tar.gz

# Add /opt/qbics to PATH
ENV PATH="/opt/qbics:${PATH}"
