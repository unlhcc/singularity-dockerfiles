# Use Centos base image
FROM centos:7
 
# Copy FImpute binary 
RUN yum install -y wget zip unzip epel-release
RUN wget http://www.aps.uoguelph.ca/~msargol/fimpute/FImpute_Linux.zip && \
    unzip  FImpute_Linux.zip && \
    cp FImpute_Linux/FImpute /bin/ && \
    mkdir -p /fimpute && \
    cp -R FImpute_Linux/*  /fimpute/ && \
    sed -i 's/example_data/\/fimpute\/example_data/g' /fimpute/*.ctr && \
    chmod u+w /bin /fimpute && \
    rm -rf FImpute_* && \
    yum clean all

# Mount work
RUN mkdir -p /work
