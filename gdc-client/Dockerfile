FROM ubuntu:14.04

# download and extract binary
RUN apt-get update && apt-get install -y curl unzip && \
  curl -L -o /tmp/gdc-client.zip https://github.com/NCI-GDC/gdc-client/releases/download/1.4.0/gdc-client_v1.4.0_Ubuntu_x64.zip && \
  unzip -d /usr/local/bin /tmp/gdc-client.zip

# mount work
RUN mkdir -p /work /home

# Add the top-level package directory to the PATH
ENV PATH=/usr/local/bin:$PATH
