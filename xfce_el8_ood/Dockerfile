FROM centos:8.3.2011

ADD TurboVNC.repo /etc/yum.repos.d/TurboVNC.repo
ADD VirtualGL.repo /etc/yum.repos.d/VirtualGL.repo

RUN dnf install -y -q epel-release dnf-plugins-core

RUN dnf config-manager --set-enabled powertools

RUN dnf -y -q update

RUN dnf -y -q groupinstall Xfce

RUN dnf -y -q install xorg-x11-fonts-Type1 xorg-x11-fonts-misc x11vnc dbus-x11 dbus-glib python2-pip turbovnc \
    vim nano geany less https://www.itzgeek.com/msttcore-fonts-2.0-3.noarch.rpm wget mousepad ristretto \
    yum-utils firefox glib2 gtk2 dbus-glib xdg-user-dirs xkeyboard-config openssh-clients rsync \
    libX11 libXp libICE libSM libgudev1 libXcursor libnotify libXrandr libnotify libjpeg-turbo xorg-x11-xkb-utils \
    xorg-x11-server-utils xorg-x11-xauth gnu-free-mono-fonts gnu-free-sans-fonts gnu-free-serif-fonts dbus-x11 \
    https://www.itzgeek.com/msttcore-fonts-2.0-3.noarch.rpm xterm dejavu-fonts-common dejavu-sans-mono-fonts gnome-themes-standard \
    python2-pip gcc python2-devel turbovnc VirtualGL glx-utils numactl tcsh xorg-x11-fonts-ISO8859-1-75dpi xorg-x11-fonts-cyrillic \
    lua lua-devel lua-filesystem lua-json lua-lpeg lua-posix lua-term tcl libcgroup geany quota gtksourceview3 glibc-langpack-en \
    gvfs gvfs-smb gvfs-fuse wmctrl file openssl bc bind-utils bzip2 dstat make gcc gcc-c++ gcc-gfortran gdb htop iotop iperf3 \
    ipmitool libXp lsof ncdu net-tools nmap-ncat openldap-clients pbzip2 pciutils perf psmisc \
    pv rsync screen smartmontools strace sysstat tcpdump time tmux traceroute tree unzip valgrind vim-enhanced wget zip \
    libcgroup-tools libpng12 libpng15 hostname tcl-devel libxcb* xcb-util* libnsl mesa-libOSMesa-devel mesa-libGL-devel

RUN ln -s /usr/bin/python3 /usr/bin/python

RUN dnf -y -q --enablerepo=epel-playground install gigolo && \
    pip2 install -q --no-cache-dir ts nose numpy==1.11 && \
    pip2 install -q --no-cache-dir websockify==0.9.0 && \
    dnf -y -q erase xfce4-power-manager && \
    # Clean
    dnf clean all && \
    rm -rf /var/cache/dnf/*

# Lmod
RUN curl -sSL https://github.com/TACC/Lmod/archive/refs/tags/8.5.12.tar.gz | tar -zx -C /tmp && \
    pushd /tmp/Lmod-8.5.12 && ./configure --with-module-root-path=/util/opt/modulefiles --with-caseIndependentSorting=yes --with-settarg=no && \
    make && make install

# Change the "web browser" launcher to firefox directly
RUN sed -i s/exo-web-browser/firefox/g /etc/xdg/xfce4/panel/default.xml

# Remove autostart items that cause issues/errors
RUN rm -f /etc/xdg/autostart/{xfce-polkit.desktop,xscreensaver.desktop}

# Remove screensaver. If it locks there's no way to unlock.
RUN dnf -y -q erase --noautoremove xfce4-screensaver

# Add turbovnc to PATH
ENV PATH=${PATH}:/opt/TurboVNC/bin

# Allow both capitalizations for consistent menu config
RUN ln -s /usr/share/applications/thunar.desktop /usr/share/applications/Thunar.desktop

# Moichandising! Moichandising! Moichandising! Where the real money from the container is made!
ADD icons /usr/share/icons/hicolor
ADD images /usr/share/backgrounds

# Profile scripts so we get the same default module behavior
ADD profile.d /etc/profile.d
RUN mkdir -p /home /work /common /util
