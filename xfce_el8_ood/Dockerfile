FROM centos:8.3.2011

ADD TurboVNC.repo /etc/yum.repos.d/TurboVNC.repo
ADD VirtualGL.repo /etc/yum.repos.d/VirtualGL.repo

RUN yum install -y -q epel-release dnf-plugins-core

RUN yum config-manager --set-enabled powertools

RUN yum -y -q update

RUN yum -y -q groupinstall Xfce

RUN yum -y -q install xorg-x11-fonts-Type1 xorg-x11-fonts-misc x11vnc dbus-x11 dbus-glib python2-pip turbovnc \
    vim nano geany less https://www.itzgeek.com/msttcore-fonts-2.0-3.noarch.rpm wget mousepad ristretto \
    yum-utils firefox glib2 gtk2 dbus-glib xdg-user-dirs xkeyboard-config openssh-clients rsync \
    libX11 libXp libICE libSM libgudev1 libXcursor libnotify libXrandr libnotify libjpeg-turbo xorg-x11-xkb-utils \
    xorg-x11-server-utils xorg-x11-xauth gnu-free-mono-fonts gnu-free-sans-fonts gnu-free-serif-fonts dbus-x11 \
    https://www.itzgeek.com/msttcore-fonts-2.0-3.noarch.rpm xterm dejavu-fonts-common dejavu-sans-mono-fonts gnome-themes-standard \
    python2-pip gcc python2-devel turbovnc VirtualGL glx-utils numactl tcsh xorg-x11-fonts-ISO8859-1-75dpi xorg-x11-fonts-cyrillic \
    lua lua-filesystem lua-json lua-lpeg lua-posix lua-term tcl libcgroup geany quota gtksourceview3 glibc-langpack-en \
    gvfs gvfs-smb gvfs-fuse wmctrl Lmod file

RUN yum -y -q --enablerepo=epel-playground install gigolo && \
    pip2 install -q --no-cache-dir ts nose numpy==1.11 && \
    pip2 install -q --no-cache-dir websockify && \
    yum -y -q erase xfce4-power-manager && \
    # Clean
    yum clean all && \
    rm -rf /var/cache/yum/*

# Change the "web browser" launcher to firefox directly
RUN sed -i s/exo-web-browser/firefox/g /etc/xdg/xfce4/panel/default.xml

# Remove autostart items that cause issues/errors
RUN rm -f /etc/xdg/autostart/{xfce-polkit.desktop,xscreensaver.desktop}

# Remove screensaver. If it locks there's no way to unlock.
RUN yum -y -q erase --noautoremove xfce4-screensaver

# Add turbovnc to PATH
ENV PATH=${PATH}:/opt/TurboVNC/bin

# Allow both capitalizations for consistent menu config
RUN ln -s /usr/share/applications/thunar.desktop /usr/share/applications/Thunar.desktop

# Moichandising! Moichandising! Moichandising! Where the real money from the container is made!
ADD icons /usr/share/icons/hicolor
ADD images /usr/share/backgrounds

RUN mkdir -p /home /work /common /util
