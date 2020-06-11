FROM centos:7

RUN curl -sSL https://turbovnc.org/pmwiki/uploads/Downloads/TurboVNC.repo > /etc/yum.repos.d/TurboVNC.repo && \
    yum update -y && yum install -y -q epel-release wget && \
    yum -y -q groupinstall Xfce && \
    yum -y -q install xorg-x11-fonts-Type1 xorg-x11-fonts-misc x11vnc dbus-x11 dbus-glib python2-pip turbovnc \
    vim nano geany more less https://www.itzgeek.com/msttcore-fonts-2.0-3.noarch.rpm && \
    pip install -q --no-cache-dir ts nose numpy==1.11 && \
    pip install -q --no-cache-dir websockify && \
    # Install Lmod dependencies
    yum install -y -q lua lua-bitop lua-filesystem lua-json lua-lpeg lua-posix lua-term tcl && \
    # Clean
    yum clean all && \
    rm -rf /var/cache/yum/*

ENV PATH ${PATH}:/opt/TurboVNC/bin/

RUN mkdir -p /home /work /common /util
