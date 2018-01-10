FROM ubuntu:trusty

## Install the validator
RUN apt-get update && \
    apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_4.x | bash - && \
    apt-get remove -y curl && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN npm install -g bids-validator@0.19.2

# Update system
RUN apt-get -qq update && apt-get -qq install -y \
    unzip \
    xorg \
    octave \
    wget && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install MATLAB MCR
ENV MATLAB_VERSION R2016b
RUN mkdir /opt/mcr_install && \
    mkdir /opt/mcr && \
    wget --quiet -P /opt/mcr_install http://www.mathworks.com/supportfiles/downloads/${MATLAB_VERSION}/deployment_files/${MATLAB_VERSION}/installers/glnxa64/MCR_${MATLAB_VERSION}_glnxa64_installer.zip && \
    unzip -q /opt/mcr_install/MCR_${MATLAB_VERSION}_glnxa64_installer.zip -d /opt/mcr_install && \
    /opt/mcr_install/install -destinationFolder /opt/mcr -agreeToLicense yes -mode silent && \
    rm -rf /opt/mcr_install /tmp/*

# Configure environment
ENV MCR_VERSION v91
ENV LD_LIBRARY_PATH /opt/mcr/${MCR_VERSION}/runtime/glnxa64:/opt/mcr/${MCR_VERSION}/bin/glnxa64:/opt/mcr/${MCR_VERSION}/sys/os/glnxa64:/opt/mcr/${MCR_VERSION}/sys/opengl/lib/glnxa64
ENV MCR_INHIBIT_CTF_LOCK 1
ENV MCRPath /opt/mcr/${MCR_VERSION}

# Install DPARSFA Standalone (from OSF mirror due to connectivity issues)
RUN wget --quiet --no-check-certificate -c -O /opt/DPARSFA_run_StandAlone_Linux.zip "https://files.osf.io/v1/resources/q8g5z/providers/osfstorage/5a1a97366c613b026d5e6f79" && \
    unzip -q /opt/DPARSFA_run_StandAlone_Linux.zip -d /opt && \
    chmod +x  /opt/DPARSFA_run_StandAlone_Linux/run_DPARSFA_run.sh /opt/DPARSFA_run_StandAlone_Linux/DPARSFA_run && \
    rm -f /opt/DPARSFA_run_StandAlone_Linux.zip

# Configure DPARSF BIDS App entry point
RUN wget --no-check-certificate -O - https://github.com/BIDS-Apps/DPARSF/archive/v4.3.12.tar.gz | tar -C /tmp -zx && \
    chmod +x /tmp/DPARSF-4.3.12/run.sh && \
    cp  /tmp/DPARSF-4.3.12/run.sh /opt/DPARSFA_run_StandAlone_Linux && \
    cp  /tmp/DPARSF-4.3.12/Template_V4_CalculateInMNISpace_Warp_DARTEL_docker.mat /opt/DPARSFA_run_StandAlone_Linux && \
    cp  /tmp/DPARSF-4.3.12/y_Convert_BIDS2DPARSFA.m /opt/DPARSFA_run_StandAlone_Linux && \
    cp  /tmp/DPARSF-4.3.12/y_CopyDARTELTemplate.m /opt/DPARSFA_run_StandAlone_Linux && \
    cp  -R /tmp/DPARSF-4.3.12/Atlas /opt/DPARSFA_run_StandAlone_Linux && \
    cp /tmp/DPARSF-4.3.12/version /version && \
    rm -rf /tmp/DPARSF-4.3.12

ENV DPARSFPath /opt/DPARSFA_run_StandAlone_Linux

ENTRYPOINT ["/opt/DPARSFA_run_StandAlone_Linux/run.sh"]

# mount work
RUN mkdir -p /work
