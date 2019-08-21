# Use Centos base image
FROM centos:7
 
# Copy ORFfinder binary 
RUN yum install -y wget zip unzip epel-release
RUN wget ftp://ftp.ncbi.nlm.nih.gov/genomes/TOOLS/ORFfinder/linux-i64/ORFfinder.gz  && \
    gunzip ORFfinder.gz && \
    cp ORFfinder /bin/ && \
    chmod +x /bin/ORFfinder && \
    rm ORFfinder && \
    yum clean all

# Add path
ENV PATH=/bin:$PATH

# Mount work and common
RUN mkdir -p /work /common
