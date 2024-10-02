FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y  python2 python2-dev x11vnc dbus-x11 vim nano geany mousepad ristretto less \
    firefox xdg-user-dirs rsync lua5.3 liblua5.3-dev lua-filesystem lua-json lua-lpeg lua-posix lua-term \
    gvfs-fuse wmctrl file openssl bc bind9-utils bzip2 dstat make gdb htop iotop iperf3 chromium-browser \
    gcc gfortran g++ ipmitool lsof ncdu net-tools pbzip2 pciutils psmisc libpng16-16 default-jdk build-essential \
    pv screen smartmontools strace sysstat tcpdump time tmux traceroute tree unzip valgrind zip libcanberra-gtk* \
    ncurses* freeglut3 autofs okular evince ttf-mscorefonts-installer curl tcl tcl-dev adwaita-icon-theme-full adwaita-qt gtk2-engines-pixbuf \
    vlc totem libtogl2 libfftw3-3 gedit grace xfce4 xfce4-terminal wget libgconf-2-4 locales apt-utils libgtk2.0-bin libgtk2.0-0 \
    libgtk2.0-dev libgtkgl2.0-dev libgtkglextmm-x11-1.2-dev libgtkglext1-dev libgtkmm-2.4-dev xfwm4 && \
    rm -rf /var/lib/apt/lists/* && \
    locale-gen en_US.UTF-8 && \
    locale

ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_CTYPE=en_US.UTF-8

# Download MEGA
RUN wget -q -O mega.deb "https://uofnelincoln.sharepoint.com/:u:/s/UNL-HollandComputingCenter/EZu8mxJJU4hLsUROUhUSpVUBmL1ge2TslaOmwDri-2MSAQ?e=8qvBIT&download=1" && \
    dpkg -i ./mega.deb && \
    rm -f *.deb

# TurboVNC 
RUN curl -sSL -O https://downloads.sourceforge.net/project/turbovnc/2.2.7/turbovnc_2.2.7_amd64.deb && \
    dpkg -i turbovnc*.deb && apt install -f

RUN wget -q -O /tmp/get-pip.py https://bootstrap.pypa.io/pip/2.7/get-pip.py && \
    python2 /tmp/get-pip.py && \
    pip2 install -q --no-cache-dir ts nose numpy==1.11 && \
    pip2 install -q --no-cache-dir websockify==0.9.0 && \
    ln -s /usr/local/bin/websockify /usr/bin

# Lmod
RUN curl -sSL https://github.com/TACC/Lmod/archive/refs/tags/8.5.12.tar.gz | tar -zx -C /tmp && \
    cd /tmp/Lmod-8.5.12 && ./configure --with-module-root-path=/util/opt/modulefiles --with-caseIndependentSorting=yes --with-settarg=no && \
    make && make install

# Workaround for different Ubuntu/EL lua install paths
RUN ln -s /usr/lib/x86_64-linux-gnu/lua /usr/lib64/lua

# Change the "web browser" launcher to firefox directly
RUN sed -i s/exo-web-browser/firefox/g /etc/xdg/xfce4/panel/default.xml

# Remove autostart items that cause issues/errors
RUN rm -f /etc/xdg/autostart/{xfce-polkit.desktop,xscreensaver.desktop}

# Add turbovnc to PATH
ENV PATH=${PATH}:/opt/TurboVNC/bin

# Allow both capitalizations for consistent menu config
RUN ln -s /usr/share/applications/thunar.desktop /usr/share/applications/Thunar.desktop

# Moichandising! Moichandising! Moichandising! Where the real money from the container is made!
ADD icons /usr/share/icons/hicolor
ADD images /usr/share/backgrounds

# Profile scripts so we get the same default module behavior
ADD profile.d /etc/profile.d

# Make bash the default shell as nature intended
RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

# Remove vte prompt madness
RUN rm -f /etc/profile.d/vte*

ENV LD_LIBRARY_PATH=/usr/lib/mega:$LD_LIBRARY_PATH \
    PATH=/usr/lib/mega/:$PATH
