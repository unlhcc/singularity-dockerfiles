# Use Centos base image
FROM centos:7
 
# Copy ORFfinder binary 
RUN yum install -y bzip2 epel-release git wget
RUN cd /opt/ && git clone https://github.com/biofuture/Ublastx_stageone.git && \
    chmod -R 777 /opt/Ublastx_stageone && chmod a+s /opt/Ublastx_stageone && \
    # USEARCH is private package
    cd /tmp && wget https://unl.box.com/shared/static/tos8rnd9neuxt9as3ushb44pe7q7fezb.667_i86linux32 && \
    cp tos8rnd9neuxt9as3ushb44pe7q7fezb.667_i86linux32 /opt/Ublastx_stageone/bin/usearch && \
    rm tos8rnd9neuxt9as3ushb44pe7q7fezb.667_i86linux32 && chmod +x /opt/Ublastx_stageone/bin/usearch && \
    # R is needed
    cd /tmp/ && curl -O -L https://repo.anaconda.com/miniconda/Miniconda3-4.6.14-Linux-x86_64.sh && \
    sh Miniconda3-4.6.14-Linux-x86_64.sh -b -p /opt/anaconda && \
    rm Miniconda3-4.6.14-Linux-x86_64.sh && export PATH=/opt/anaconda/bin:$PATH && \
    conda config --add channels defaults && conda config --add channels bioconda && \
    conda config --add channels conda-forge && conda config --add channels hcc  && \
    conda install -q -y r-base && \
    ln -s /opt/anaconda/bin/R /opt/Ublastx_stageone/bin/ && \
    ln -s /opt/anaconda/bin/Rscript /opt/Ublastx_stageone/bin/ && \
    yum clean all

# Add path
ENV PATH=/opt/Ublastx_stageone/:/opt/Ublastx_stageone/bin/:$PATH

# Mount work and common
RUN mkdir -p /work /common
