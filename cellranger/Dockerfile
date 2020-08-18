# Use Centos base image
FROM centos:7

RUN yum install -q -y wget zip unzip bzip2 which epel-release

# Download Cell Ranger
RUN mkdir -p /cellranger && cd /cellranger && \
    wget https://unl.box.com/shared/static/20wblwk9b2b699wyefc1avcm56j9jedd.tar -o /dev/null && \
	tar -x --strip-components=1 -f *.tar && rm *.tar

# Add token for private channel
ARG token

# Create conda environment for bcl2fastq2
RUN cd /tmp && curl -O -L https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    sh Miniconda3-latest-Linux-x86_64.sh -b -p /opt/anaconda > /dev/null 2>&1 && \
    rm Miniconda3-latest-Linux-x86_64.sh && export PATH=/opt/anaconda/bin:$PATH && \
    conda config --system --add channels defaults && conda config --system --add channels bioconda && \
    conda config --system --add channels conda-forge && conda config --system --add channels hcc && \
    conda config --system --add channels https://conda.anaconda.org/t/${token}/hcc && \
    conda create -q -y -n cellranger bcl2fastq2=2.20.0.422 lz4 star

# Set environment from source.bash
ENV PATH /opt/anaconda/envs/cellranger/bin:$PATH
ENV PATH /cellranger/bin:/cellranger/bin/tenkit:$PATH
ENV PATH /cellranger/external/anaconda/bin:/cellranger/external/martian/bin:/cellranger/lib/bin:$PATH
ENV PYTHONPATH /cellranger/lib/python:/cellranger/external/martian/adapters/python:$PYTHONPATH
ENV MROPATH /cellranger/mro:$MROPATH

# Mount work/common
RUN mkdir -p /work /common
