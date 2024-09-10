FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y -q locales apt-utils && rm -rf /var/lib/apt/lists/* && \
        locale-gen en_US.UTF-8 && \
        locale

ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_CTYPE=en_US.UTF-8

RUN yes | unminimize

RUN apt-get install -y -q software-properties-common apt-transport-https wget

RUN apt-get install -y -q xfce4 xfce4-terminal

RUN apt-get install -y  python2 python2-dev x11vnc dbus-x11 vim nano geany mousepad ristretto less \
    firefox xdg-user-dirs rsync lua5.3 liblua5.3-dev lua-filesystem lua-json lua-lpeg lua-posix lua-term \
    gvfs-fuse wmctrl file openssl bc bind9-utils bzip2 dstat make gdb htop iotop iperf3 \
    gcc gfortran g++ ipmitool lsof ncdu net-tools pbzip2 pciutils psmisc libpng16-16 default-jdk \
    pv screen smartmontools strace sysstat tcpdump time tmux traceroute tree unzip valgrind zip \
    ncurses* freeglut3 autofs okular evince ttf-mscorefonts-installer curl tcl tcl-dev adwaita-icon-theme-full adwaita-qt \
    vlc totem libtogl2 libfftw3-3 gedit grace

# More recent libreoffice
RUN apt-add-repository -y  ppa:libreoffice && \
    apt-get update && \
    apt-get install -y libreoffice

RUN wget -q -O /tmp/turbovnc_2.2.7_amd64.deb https://downloads.sourceforge.net/project/turbovnc/2.2.7/turbovnc_2.2.7_amd64.deb && \
    dpkg -i /tmp/turbovnc_2.2.7_amd64.deb && \
    wget -q -O /tmp/multiarch-support_2.27-3ubuntu1.6_amd64.deb http://archive.ubuntu.com/ubuntu/pool/main/g/glibc/multiarch-support_2.27-3ubuntu1.6_amd64.deb && \
    wget -q -O /tmp/libxp6_1.0.2-2_amd64.deb https://archive.debian.org/debian/pool/main/libx/libxp/libxp6_1.0.2-2_amd64.deb && \
    apt install -y -q /tmp/multiarch-support_2.27-3ubuntu1.6_amd64.deb /tmp/libxp6_1.0.2-2_amd64.deb

ADD opera-browser.gpg /usr/share/keyrings/opera-browser.gpg
ADD opera-archive.list /etc/apt/sources.list.d/opera-archive.list

RUN apt-get update && \
    apt-get install -y opera-stable

# Opera wrapper to disable sandbox
RUN mv /usr/bin/opera /usr/bin/opera.bin
ADD opera-wrapper.sh /usr/bin/opera

RUN fc-cache -vr

RUN wget -q -O /tmp/get-pip.py https://bootstrap.pypa.io/pip/2.7/get-pip.py && \
    python2 /tmp/get-pip.py && \
    pip2 install -q --no-cache-dir ts nose numpy==1.11 && \
    pip2 install -q --no-cache-dir websockify==0.9.0 && \
    ln -s /usr/local/bin/websockify /usr/bin

# Change the "web browser" launcher to firefox directly
RUN sed -i s/exo-web-browser/firefox/g /etc/xdg/xfce4/panel/default.xml

# Remove autostart items that cause issues/errors
RUN rm -f /etc/xdg/autostart/{xfce-polkit.desktop,xscreensaver.desktop}

# Lmod
RUN curl -sSL https://downloads.sourceforge.net/project/lmod/Lmod-8.7.tar.bz2 | tar -jx -C /tmp && \
    cd /tmp/Lmod-8.7 && ./configure --with-module-root-path=/util/opt/modulefiles --with-caseIndependentSorting=yes --with-settarg=no && \
    make && make install

# Workaround for different Ubuntu/EL lua install paths
RUN ln -s /usr/lib/x86_64-linux-gnu/lua /usr/lib64/lua

# Change the "web browser" launcher to firefox directly
RUN sed -i s/exo-web-browser/firefox/g /etc/xdg/xfce4/panel/default.xml

# Add turbovnc to PATH
ENV PATH=${PATH}:/opt/TurboVNC/bin

# Allow both capitalizations for consistent menu config
RUN ln -s /usr/share/applications/thunar.desktop /usr/share/applications/Thunar.desktop

# Moichandising! Moichandising! Moichandising! Where the real money from the container is made!
ADD icons /usr/share/icons/hicolor
ADD images /usr/share/backgrounds
ADD xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml /etc/xdg/xfce4/xfconf/xfce-perchannel-xml
ADD xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml /etc/xdg/xfce4/xfconf/xfce-perchannel-xml

# Profile scripts so we get the same default module behavior
ADD profile.d /etc/profile.d
RUN mkdir -p /home /work /common /util

# Make bash the default shell as nature intended
RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

# Remove vte prompt madness
RUN rm -f /etc/profile.d/vte*
