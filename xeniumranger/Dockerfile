# Use Centos base image
FROM almalinux:9.4

RUN yum install -q -y wget zip unzip bzip2 which epel-release

# Download Xenium Ranger
RUN mkdir -p /opt && cd /opt && \
    curl -o xeniumranger.tar.gz \
        'https://uofnelincoln.sharepoint.com/:u:/s/UNL-HollandComputingCenter/EcOxGnu3nbVGpoky1S6AcBIBBnjLi_OypecDKQVnpU0GQA?e=ZR72k7&download=1' \
        --location --cookie-jar /tmp/tmp && \
    tar -xvf  *.tar.gz && rm *.tar.gz

# Set environments from sourceme.bash file
ENV PATH /opt/xeniumranger-xenium3.0:/opt/xeniumranger-xenium3.0/external/anaconda/bin:/opt/xeniumranger-xenium3.0/external/anaconda/lib:/opt/xeniumranger-xenium3.0/external/cellranger/bin/tenkit:/opt/xeniumranger-xenium3.0/external/martian/bin:/opt/xeniumranger-xenium3.0/external/cellranger/lib/bin:/opt/xeniumranger-xenium3.0/lib/bin:$PATH
ENV PYTHONPATH /opt/xeniumranger-xenium3.0/lib/python:/opt/xeniumranger-xenium3.0/external/cellranger/lib/python:/opt/xeniumranger-xenium3.0/external/martian/adapters/python:/opt/xeniumranger-xenium3.0/external/com_github_10XDev_turing:/opt/xeniumranger-xenium3.0/external/com_github_10XDev_tenxnet:/opt/xeniumranger-xenium3.0/external/lib/python/turing/engine/martian/resource_consumption_models/regression_models_proto:$PYTHONPATH
ENV MROPATH /opt/xeniumranger-xenium3.0/mro:/opt/xeniumranger-xenium3.0/external/cellranger/mro:$MROPATH
ENV LANG="C" \
    LC_CTYPE="en_US.UTF-8" \
    HDF5_USE_FILE_LOCKING="FALSE" \
    PYTHONNOUSERSITE="1"
