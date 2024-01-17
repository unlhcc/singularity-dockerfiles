# Use Ubuntu base image
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends build-essential git wget curl patch ca-certificates

# Install miniconda
RUN cd /tmp/ && wget --no-check-certificate https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    sh Miniconda3-latest-Linux-x86_64.sh -b -p /opt/anaconda && \
    rm Miniconda3-latest-Linux-x86_64.sh && export PATH=/opt/anaconda/bin:$PATH && \
    conda config --add channels defaults && conda config --add channels bioconda && \
    conda config --add channels conda-forge && conda config --add channels hcc

# Create conda env
ENV PATH="/opt/anaconda/bin:$PATH"
RUN /opt/anaconda/bin/conda create -y -p /opt/atacgraph \
    python=3.6 deeptools=3.3 bedtools samtools idr macs2 numpy scipy 'pandas<1.0' \
    'pysam>0.14' matplotlib-base matplotlib-venn pybedtools scikit-learn openssl=1.0 r-base=3.5 && \
    /opt/anaconda/bin/conda clean -ya

# Download atacgraph
WORKDIR /app
# Add patch to convert Python 2 to Python 3 and update paths
ADD python.patches /tmp
ENV ATACGRAPH_COMMIT=63526bc39c30dcfe9c408ce8dd6022f27b58b77d
RUN wget -q -P ./atacgraph https://github.com/RitataLU/ATACgraph/archive/${ATACGRAPH_COMMIT}.tar.gz && \
    tar xvf ./atacgraph/${ATACGRAPH_COMMIT}.tar.gz -C ./atacgraph --strip-components 1 && \
    rm ./atacgraph/${ATACGRAPH_COMMIT}.tar.gz && \
    cd /app/atacgraph && patch -p0 < /tmp/python.patches && \
    rm /tmp/python.patches
RUN chmod +x /app/atacgraph/script/*

# Add path
ENV PATH=/app/atacgraph/script/:/opt/atacgraph/bin/:$PATH
