FROM fedora:27

RUN dnf install -y -q gcc gcc-gfortran bzip2 libXt libgomp which && \
    curl --output /usr/local/bin/mark -L https://unl.box.com/shared/static/3vhqep2fu0wic1qhbpgq4lekyu9wrrim && \
    chmod +x /usr/local/bin/mark && \
    curl -O -L https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    sh Miniconda3-latest-Linux-x86_64.sh -b -p /opt/anaconda && \
    rm Miniconda3-latest-Linux-x86_64.sh && export PATH=/opt/anaconda/bin:$PATH && \
    conda config --add channels bioconda && conda config --add channels conda-forge && \
    conda install -q -y r=3.5.1 r-tidyverse r-matrixcalc r-coda r-mvtnorm r-expm r-msm libgfortran=3 && \
    Rscript -e "install.packages('RMark',repos='https://rweb.crmda.ku.edu/cran')" && \
    mkdir -p /work

ENV PATH=$PATH:/opt/anaconda/bin
