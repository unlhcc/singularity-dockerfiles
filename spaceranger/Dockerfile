# Use AlmaLinux base image
FROM almalinux:8

RUN yum install -q -y wget zip unzip bzip2 which epel-release

# Download Space Ranger
RUN mkdir -p /spaceranger && cd /spaceranger && \
    curl -o spaceranger.tar.gz \
        'https://uofnebraska.sharepoint.com/:u:/s/NU-HCC/IQBUhmriWd82RYsPOh8443MfARyh2OdZxwBEDE1VXIQXFEQ?e=feLKzi&download=1' \
         --location --cookie-jar /tmp/tmp && \
    tar -x --strip-components=1 -f *.tar.gz && rm *.tar.gz

# make sure token is defined if you use it
ARG token

RUN cd /tmp && \
    curl -fsSL -o Miniconda3.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash Miniconda3.sh -b -p /opt/anaconda && \
    rm -f Miniconda3.sh && \
    /opt/anaconda/bin/conda config --system --add channels defaults && \
    /opt/anaconda/bin/conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main && \
    /opt/anaconda/bin/conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r && \
    /opt/anaconda/bin/conda config --system --add channels bioconda && \
    /opt/anaconda/bin/conda config --system --add channels conda-forge && \
    /opt/anaconda/bin/conda config --system --add channels hcc && \
    /opt/anaconda/bin/conda config --system --add channels "https://conda.anaconda.org/t/${token}/hcc" && \
    /opt/anaconda/bin/conda create -y -n spaceranger bcl2fastq2=2.20.0.422 lz4 star boost=1.67.0 libboost=1.67.0 && \
    /opt/anaconda/bin/conda clean -a -y && \
    rm -rf /opt/anaconda/pkgs/*

# Set environment from source.bash
ENV PATH="/opt/anaconda/envs/spaceranger/bin:${PATH}"

ENV PATH="/spaceranger/bin:${PATH}"
ENV PATH="/spaceranger/bin/tenkit:${PATH}"
ENV PATH="/spaceranger/external/anaconda/bin:${PATH}"
ENV PATH="/spaceranger/external/martian/bin:${PATH}"
ENV PATH="/spaceranger/lib/bin:${PATH}"

ENV PYTHONPATH="/spaceranger/external/martian/adapters/python:${PYTHONPATH}"
ENV PYTHONPATH="/spaceranger/lib/python:${PYTHONPATH}"

ENV MROPATH="/spaceranger/mro:${MROPATH}"

# Mount work/common
RUN mkdir -p /work /common
