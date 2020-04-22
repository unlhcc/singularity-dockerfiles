FROM centos:7

RUN yum install -y epel-release && \
    yum groupinstall -y 'MATE Desktop' && \
    yum install -y python2-pip && \
    pip install ts && \
    yum install -y https://yum.osc.edu/ondemand/1.6/compute/el7Server/x86_64/python-websockify-0.8.0-1.el7.noarch.rpm && \
    yum install -y https://yum.osc.edu/ondemand/latest/compute/el7Server/x86_64/turbovnc-2.2.3-1.el7.x86_64.rpm && \
    yum remove -y tigervnc-server python2-pip mate-power-manager && \
    yum clean all && \
    rm -rf /var/cache/yum/*

ENV PATH ${PATH}:/opt/TurboVNC/bin/

# mount directories
RUN mkdir -p /home /work /common /util
