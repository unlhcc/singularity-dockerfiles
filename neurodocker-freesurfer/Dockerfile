# Generated by Neurodocker v0.3.1.
#
# Thank you for using Neurodocker. If you discover any issues
# or ways to improve this software, please submit an issue or
# pull request on our GitHub repository:
#     https://github.com/kaczmarj/neurodocker
#
# Timestamp: 2017-10-26 13:53:01

FROM ubuntu:16.04

ARG DEBIAN_FRONTEND=noninteractive

#----------------------------------------------------------
# Install common dependencies and create default entrypoint
#----------------------------------------------------------
ENV LANG="en_US.UTF-8" \
    LC_ALL="C.UTF-8" \
    ND_ENTRYPOINT="/neurodocker/startup.sh"
RUN apt-get update -qq && apt-get install -yq --no-install-recommends  \
    	apt-utils bzip2 ca-certificates curl locales unzip build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && localedef --force --inputfile=en_US --charmap=UTF-8 C.UTF-8 \
    && chmod 777 /opt && chmod a+s /opt \
    && mkdir -p /neurodocker \
    && if [ ! -f "$ND_ENTRYPOINT" ]; then \
         echo '#!/usr/bin/env bash' >> $ND_ENTRYPOINT \
         && echo 'set +x' >> $ND_ENTRYPOINT \
         && echo 'source $FREESURFER_HOME/SetUpFreeSurfer.sh' >>  $ND_ENTRYPOINT \
         && echo 'if [ -z "$*" ]; then /usr/bin/env bash; else $*; fi' >> $ND_ENTRYPOINT; \
       fi \
    && chmod -R 777 /neurodocker && chmod a+s /neurodocker
ENTRYPOINT ["/neurodocker/startup.sh"]

RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends git \
                                                     vim \
                                                     mercurial \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#--------------------------
# Install FreeSurfer v6.0.0
#--------------------------
# Install version minimized for recon-all
# See https://github.com/freesurfer/freesurfer/issues/70
RUN apt-get update -qq && apt-get install -yq --no-install-recommends bc libgomp1 libxmu6 libxt6 tcsh perl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && echo "Downloading minimized FreeSurfer ..." \
    && curl -sSL https://dl.dropbox.com/s/nnzcfttc41qvt31/recon-all-freesurfer6-3.min.tgz | tar xz -C /opt
ENV FREESURFER_HOME=/opt/freesurfer

# Create new user: neuro
#RUN useradd --no-user-group --create-home --shell /bin/bash neuro
#USER neuro
RUN mkdir -p /work && touch /opt/freesurfer/license.txt

#------------------
# Install Miniconda
#------------------
ENV CONDA_DIR=/opt/conda \
    PATH=/opt/conda/bin:$PATH
RUN echo "Downloading Miniconda installer ..." \
    && miniconda_installer=/tmp/miniconda.sh \
    && curl -sSL -o $miniconda_installer https://repo.continuum.io/miniconda/Miniconda3-4.3.31-Linux-x86_64.sh \
    && /bin/bash $miniconda_installer -b -p $CONDA_DIR \
    && rm -f $miniconda_installer \
    && conda config --system --prepend channels conda-forge \
    && conda config --system --set auto_update_conda false \
    && conda config --system --set show_channel_urls true \
    && conda update -y -q --all && sync \
    && conda clean -tipsy && sync

#------------------
# Install AFNI
#------------------
ENV PATH="/opt/afni-latest:/opt/anaconda/bin:$PATH" \
    AFNI_PLUGINPATH="/opt/afni-latest"
RUN apt-get update -qq \
    && apt-get install -y -q --no-install-recommends \
           ed \
           gsl-bin \
           libglib2.0-0 \
           libglu1-mesa-dev \
           libglw1-mesa \
           libgomp1 \
           libjpeg62 \
           libxm4 \
           netpbm \
           tcsh \
           xfonts-base \
           xvfb \
           wget \
           software-properties-common \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    # download libxp, old links are broken
    && add-apt-repository --yes ppa:zeehio/libxp && apt-get update -qq && apt-get install -y -q libxp6 \
    # download libpng, old links are broken
    && wget -O /tmp/toinstall.deb http://archive.ubuntu.com/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.50-1ubuntu2.14.04.3_amd64.deb \
    && dpkg -i /tmp/toinstall.deb \
    && rm /tmp/toinstall.deb \
    && apt-get install -f \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && gsl2_path="$(find / -name 'libgsl.so.19' || printf '')" \
    && if [ -n "$gsl2_path" ]; then \
         ln -sfv "$gsl2_path" "$(dirname $gsl2_path)/libgsl.so.0"; \
    fi \
    && ldconfig \
    && echo "Downloading AFNI ..." \
    && mkdir -p /opt/afni-latest \
    && curl -fsSL --retry 5 https://afni.nimh.nih.gov/pub/dist/tgz/linux_openmp_64.tgz \
    | tar -xz -C /opt/afni-latest --strip-components 1

#-------------------------
# Create conda environment
#-------------------------
RUN conda create -y -q --name neuro -c hcc -c conda-forge python=3.6.2 \
                                                          numpy \
                                                          pandas \
                                                          reprozip \ 
    && sync && conda clean -tipsy && sync \
    && /bin/bash -c "source activate neuro \
      && pip install -q --no-cache-dir nipype" \
    && sync

RUN conda create -y -q --name afni -c hcc -c conda-forge matplotlib \
    r=4.0 r-corrplot scikit-learn scikit-plot r-metafor r-rmpi \
    r-afex r-phia r-snow r-nlme r-lme4 r-paran r-psych r-brms r-tidyverse scipy numpy pandas

ENV PATH=/opt/conda/envs/neuro/bin:/opt/conda/envs/afni/bin:/opt/freesurfer/bin:$PATH

#--------------------------------------
# Save container specifications to JSON
#--------------------------------------
RUN echo '{ \
    \n  "pkg_manager": "apt", \
    \n  "check_urls": true, \
    \n  "instructions": [ \
    \n    [ \
    \n      "base", \
    \n      "ubuntu:16.04" \
    \n    ], \
    \n    [ \
    \n      "install", \
    \n      [ \
    \n        "git", \
    \n        "vim", \
    \n        "mercurial" \
    \n      ] \
    \n    ], \
    \n    [ \
    \n      "freesurfer", \
    \n      { \
    \n        "version": "6.0.0", \
    \n        "min": true \
    \n      } \
    \n    ], \
    \n    [ \
    \n      "user", \
    \n      "neuro" \
    \n    ], \
    \n    [ \
    \n      "miniconda", \
    \n      { \
    \n        "env_name": "neuro", \
    \n        "conda_opts": "--channel conda-forge", \
    \n        "conda_install": "python=3.6.2 numpy pandas reprozip", \
    \n        "pip_install": "nipype", \
    \n        "add_to_path": true \
    \n      } \
    \n    ] \
    \n  ], \
    \n  "generation_timestamp": "2017-10-26 13:53:01", \
    \n  "neurodocker_version": "0.3.1" \
    \n}' > /neurodocker/neurodocker_specs.json
