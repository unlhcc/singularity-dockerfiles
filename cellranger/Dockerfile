# Use Centos base image
FROM centos:7

RUN yum install -y wget zip unzip bzip2 which epel-release

# Download Cell Ranger
RUN mkdir -p /cellranger && cd /cellranger && \
    wget https://unl.box.com/shared/static/e8q5qu177y6nzqn0r7iztfarbe724b7p.tar && \
	tar -xv --strip-components=1 -f *.tar && rm *.tar
	
# Create conda environment for bcl2fastq2
RUN cd /tmp && curl -O -L https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    sh Miniconda3-latest-Linux-x86_64.sh -b -p /opt/anaconda && \
    rm Miniconda3-latest-Linux-x86_64.sh && export PATH=/opt/anaconda/bin:$PATH && \
    conda create -q -y -n cellranger -c hcc -c conda-forge -c bioconda -c defaults bcl2fastq2=2.20.0.422 lz4 star

# Set environment from source.bash
ENV PATH /opt/anaconda/envs/cellranger/bin:$PATH
ENV PATH /cellranger/cellranger-cs/3.0.2/bin:/cellranger/cellranger-cs/3.0.2/tenkit/bin:$PATH
ENV PATH /cellranger/cellranger-cs/3.0.2/tenkit/lib/bin:/cellranger/cellranger-cs/3.0.2/lib/bin:$PATH
ENV PATH /cellranger/miniconda-cr-cs/4.3.21-miniconda-cr-cs-c10/bin:$PATH
ENV MROPATH /cellranger/cellranger-cs/3.0.2/mro:/cellranger/cellranger-cs/3.0.2/tenkit/mro:$MROPATH
ENV PYTHONPATH /cellranger/cellranger-cs/3.0.2/lib/python:/cellranger/cellranger-cs/3.0.2/tenkit/lib/python:/cellranger/martian-cs/v3.2.0/adapters/python:$PYTHONPATH
ENV PYTHONUSERBASE /cellranger/cellranger-cs/3.0.2/lib

# Mount work
RUN mkdir -p /work