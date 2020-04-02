# Use Centos base image
FROM i386/centos:7

# IRF is compiled for 32-bit system
# Copy IRF binary 
RUN yum install -y wget zip unzip epel-release
RUN wget https://unl.box.com/shared/static/8elwthrxxgpls6xu1agoj89y6jh0upvw.gz && \
    tar xvf 8elwthrxxgpls6xu1agoj89y6jh0upvw.gz && \
    rm 8elwthrxxgpls6xu1agoj89y6jh0upvw.gz && \
    cp irf307.linux.exe /bin/ && \
    chmod +x /bin/irf307.linux.exe && \
    yum clean all && \
    rm -rf /var/cache/yum

# Mount work
RUN mkdir -p /work
