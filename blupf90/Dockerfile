FROM centos:7

RUN yum install -q -y wget && \
    wget -q -P /usr/local/bin -e robots=off -r -np -nd -R "index.html*" http://nce.ads.uga.edu/html/projects/programs/Linux/64bit/ && \
    chmod +x /usr/local/bin/* && \
    mkdir -p /work
