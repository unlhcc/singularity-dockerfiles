# Use Centos base image
FROM almalinux:9.4

RUN yum install -q -y wget zip unzip bzip2 which epel-release

# Download Xenium Ranger
RUN mkdir -p /opt && cd /opt && \
    curl -o xeniumranger.tar.gz \
        'https://uofnebraska.sharepoint.com/:u:/s/NU-HCC/IQAFRxn5kRmFToZKk9fgOJqFAdie9DeOFsZ5ljWjds43uJM?e=vP1Vdz&download=1' \
        --location --cookie-jar /tmp/tmp && \
    tar -xvf  *.tar.gz && rm *.tar.gz

# Set environments from sourceme.bash file
ENV PATH /opt/xeniumranger-xenium4.0:/opt/xeniumranger-xenium4.0/external/anaconda/bin:/opt/xeniumranger-xenium4.0/external/anaconda/lib:/opt/xeniumranger-xenium4.0/external/cellranger/bin/tenkit:/opt/xeniumranger-xenium4.0/external/martian/bin:/opt/xeniumranger-xenium4.0/external/cellranger/lib/bin:/opt/xeniumranger-xenium4.0/lib/bin:$PATH
ENV PYTHONPATH /opt/xeniumranger-xenium4.0/lib/python:/opt/xeniumranger-xenium4.0/external/cellranger/lib/python:/opt/xeniumranger-xenium4.0/external/martian/adapters/python:/opt/xeniumranger-xenium4.0/external/com_github_10XDev_turing_models:/opt/xeniumranger-xenium4.0/external/com_github_10XDev_turing_refdata:/opt/xeniumranger-xenium4.0/external/com_github_10XDev_tenxnet:$PYTHONPATH
ENV MROPATH /opt/xeniumranger-xenium4.0/mro:/opt/xeniumranger-xenium4.0/external/cellranger/mro:$MROPATH
ENV LANG="C" \
    LC_CTYPE="en_US.UTF-8" \
    HDF5_USE_FILE_LOCKING="FALSE" \
    PYTHONNOUSERSITE="1"
