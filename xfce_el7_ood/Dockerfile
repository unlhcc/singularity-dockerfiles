FROM centos:7.7.1908

ADD TurboVNC.repo /etc/yum.repos.d/TurboVNC.repo

# Update everything first
RUN yum -y clean all && yum -y -q update

# Install EPEL and fix groups
# Install libzstd first otherwise later packages complain
RUN yum install -y epel-release && \
    yum install -y libzstd && \
    yum -y groups mark convert

# Install XFCE
RUN yum -y -q groupinstall Xfce

# Install other needed packages
RUN yum -y -q install xorg-x11-fonts-Type1 xorg-x11-fonts-misc x11vnc dbus-x11 dbus-glib python2-pip turbovnc \
    vim nano geany more less https://www.itzgeek.com/msttcore-fonts-2.0-3.noarch.rpm wget mousepad ristretto \
    yum-utils firefox glib2 gtk2 dbus-glib xdg-user-dirs xkeyboard-config openssh-clients rsync \
    libX11 libXp libICE libSM libgudev1 libXcursor libnotify libXrandr libnotify libjpeg-turbo xfce4-icon-theme xorg-x11-xkb-utils \
    xorg-x11-server-utils xorg-x11-xauth gnu-free-mono-fonts gnu-free-sans-fonts gnu-free-serif-fonts dbus-x11 \
    https://www.itzgeek.com/msttcore-fonts-2.0-3.noarch.rpm xterm dejavu-fonts-common dejavu-sans-mono-fonts vte gnome-icon-theme \
    python-pip gcc python-devel turbovnc glx-utils numactl tcsh xorg-x11-fonts-ISO8859-1-75dpi xorg-x11-fonts-cyrillic \
    lua lua-devel lua-bitop lua-filesystem lua-json lua-lpeg lua-posix lua-term tcl libcgroup geany quota gtksourceview2 libzstd devilspie2 \
    wmctrl file mesa-libGLU openssl bc bind-utils bzip2 dstat gcc gcc-c++ gcc-gfortran gdb htop iotop iperf3 \
    ipmitool libXp lsof ncdu net-tools nmap-ncat openldap-clients pbzip2 pciutils perf psmisc \
    pv rsync screen smartmontools strace sysstat tcpdump time tmux traceroute tree unzip valgrind vim-enhanced wget zip \
    libcgroup-tools libpng12 hostname tcl-devel python3 libxcb* xcb-util* libncl

# Install numpy/websockify for TurboVNC
# Remove power manager to prevent sleep/suspend
RUN pip install -q --no-cache-dir ts nose numpy==1.11 && \
    pip install -q --no-cache-dir websockify==0.9.0 && \
    yum -y -q erase xfce4-power-manager && \
    # Clean
    yum clean all && \
    rm -rf /var/cache/yum/*

# Lmod
RUN curl -sSL https://github.com/TACC/Lmod/archive/refs/tags/8.5.12.tar.gz | tar -zx -C /tmp && \
    pushd /tmp/Lmod-8.5.12 && ./configure --with-module-root-path=/util/opt/modulefiles --with-caseIndependentSorting=yes --with-settarg=no && \
    make && make install

# Change the "web browser" launcher to firefox directly
RUN sed -i s/exo-web-browser/firefox/g /etc/xdg/xfce4/panel/default.xml

# Remove autostart items that cause issues/errors
RUN rm -f /etc/xdg/autostart/{xfce-polkit.desktop,xscreensaver.desktop}

# Moichandising! Moichandising! Moichandising! Where the real money from the container is made!
ADD icons /usr/share/icons/hicolor
ADD images /usr/share/backgrounds

ENV PATH=${PATH}:/opt/TurboVNC/bin/

# Profile scripts so we get the same default module behavior
ADD profile.d /etc/profile.d
RUN mkdir -p /home /work /common /util
