FROM unlhcc/openswr:centos6 as swr

USER root

RUN rm -f /etc/yum.repos.d/*
ADD vault.repo /etc/yum.repos.d/vault.repo
ADD epel.repo /etc/yum.repos.d/epel.repo
ADD RPM-GPG-KEY-EPEL-6 /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6

ENV PATH=/opt/llvm/7.0.0/bin:${PATH}

RUN mkdir -p /build && \
    curl -sSL https://github.com/mesa3d/mesa/archive/mesa-19.2.8.tar.gz | tar -zx -C /build && \
    pushd /build/mesa-mesa-19.2.8 && mkdir build && \
    meson --buildtype=release \
        -Dglx=gallium-xlib \
        -Dvulkan-drivers= \
        -Ddri-drivers= \
        -Dgallium-drivers=swrast,swr \
        -Dplatforms=x11 \
        -Dgallium-omx=disabled \
        -Dprefix=$MESA_INSTALL_DIR \
        -Dosmesa=gallium \
        build > /dev/null && \
    ninja -C build > /dev/null && \
    meson install -C build

FROM centos:6 as builder

RUN rm -f /etc/yum.repos.d/*
ADD vault.repo /etc/yum.repos.d/vault.repo

RUN yum install -q -y epel-release && \
  yum install -q -y yum-utils sudo gcc gcc-c++ gcc-gfortran intltool libtool \
  glib2-devel gtk2-devel pkgconfig  dbus-glib-devel  libX11-devel libICE-devel \
  libSM-devel libgudev1-devel  libXcursor-devel libnotify-devel libXrandr-devel \
  libnotify-devel libjpeg-turbo-devel libexif-devel xorg-x11-server-utils xorg-x11-xauth \
  gnu-free-mono-fonts gnu-free-sans-fonts gnu-free-serif-fonts dbus-x11 https://www.itzgeek.com/msttcore-fonts-2.0-3.noarch.rpm \
  dejavu-fonts-common dejavu-sans-mono-fonts vte-devel gnome-icon-theme xfce4-icon-theme gtksourceview2-devel && \
  echo '/usr/local/lib' >> /etc/ld.so.conf.d/local.conf && ldconfig

ENV PYTHONWARNINGS=ignore PREFIX=/usr/local PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

# Download XFCE4 source
RUN mkdir -p /build && \
  curl -sSL https://download.gnome.org/sources/libwnck/2.30/libwnck-2.30.7.tar.bz2 | tar -jx -C /build && \
  curl -sSL https://archive.xfce.org/xfce/4.10/fat_tarballs/xfce-4.10.tar.bz2 | tar -jx -C /build --to-command="tar -jx -C /build" --ignore-command-error > /dev/null 2>&1 && \
  curl -sSL https://git.xfce.org/apps/xfce4-terminal/snapshot/xfce4-terminal-terminal-0.4.8.tar.gz | tar -zx -C /build && \
  curl -sSL https://git.xfce.org/apps/mousepad/snapshot/mousepad-0.3.0.tar.gz | tar -zx -C /build && \
  curl -sSL https://archive.xfce.org/src/apps/ristretto/0.8/ristretto-0.8.2.tar.bz2 | tar -jx -C /build

# Build XFCE4
RUN pushd /build/libwnck-2.30.7 && \
    ./configure --prefix=$PREFIX --disable-nls >> build.log && make >> build.log && make install >> build.log

RUN pushd /build/xfce4-dev-tools-4.10.0 && \
    ./configure --prefix=$PREFIX >> build.log && make >> build.log && make install >> build.log

RUN pushd /build/gtk-xfce-engine-3.0.0 && \
    ./configure --prefix=$PREFIX --disable-nls >> build.log && make >> build.log && make install >> build.log

RUN pushd /build/libxfce4util-4.10.0 && \
    ./configure --prefix=$PREFIX --disable-nls >> build.log && make >> build.log && make install >> build.log

RUN pushd /build/xfconf-4.10.0 && \
    ./configure --prefix=$PREFIX --disable-nls --disable-perl-bindings >> build.log && make >> build.log && make install >> build.log

RUN pushd /build/libxfce4ui-4.10.0 && \
    ./configure --prefix=$PREFIX --disable-nls --with-x >> build.log && make >> build.log && make install >> build.log

RUN pushd /build/garcon-0.2.0 && \
    ./configure --prefix=$PREFIX >> build.log && make >> build.log && make install >> build.log

RUN pushd /build/exo-0.8.0 && \
    ./configure --prefix=$PREFIX --disable-nls --with-x >> build.log && make >> build.log && make install >> build.log

RUN pushd /build/Thunar-1.4.0 && \
    ./configure --prefix=$PREFIX --enable-exif >> build.log && make >> build.log && make install >> build.log

RUN pushd /build/xfce4-panel-4.10.0 && \
    ./configure --prefix=$PREFIX --with-x >> build.log && make >> build.log && make install >> build.log

RUN pushd /build/xfce4-settings-4.10.0 && \
    ./configure --prefix=$PREFIX --disable-nls --with-x >> build.log && make >> build.log && make install >> build.log

RUN pushd /build/xfce4-session-4.10.0 && \
    ./configure --prefix=$PREFIX --disable-nls --with-x >> build.log && make >> build.log && make install >> build.log

RUN pushd /build/xfdesktop-4.10.0 && \
    ./configure --prefix=$PREFIX --disable-nls --with-x --disable-desktop-icons >> build.log && make >> build.log && make install >> build.log

RUN pushd /build/xfwm4-4.10.0 && \
    ./configure --prefix=$PREFIX --disable-nls --with-x >> build.log && make >> build.log && make install >> build.log

RUN pushd /build/xfce4-appfinder-4.10.0 && \
    ./configure --prefix=$PREFIX --disable-nls >> build.log && make >> build.log && make install >> build.log

RUN pushd /build/tumbler-0.1.25 && \
    ./configure --prefix=$PREFIX --disable-nls >> build.log && make >> build.log && make install >> build.log

RUN pushd /build/thunar-volman-0.8.0 && \
    ./configure --prefix=$PREFIX --disable-nls >> build.log && make >> build.log && make install >> build.log

RUN pushd /build/xfce4-terminal-terminal-0.4.8 && \
    ./autogen.sh >> build.log && make >> build.log && make install >> build.log

RUN pushd /build/mousepad-0.3.0 && \
    ./autogen.sh >> build.log && ./configure --prefix=$PREFIX --disable-nls --enable-maintainer-mode >> build.log && make >> build.log && make install >> build.log

RUN pushd /build/ristretto-0.8.2 && \
    ./configure --prefix=$PREFIX --disable-nls >> build.log && make >> build.log && make install >> build.log

# Add symlinks to match EL7/EL8 images
RUN ln -s /usr/local/share/applications/Terminal.desktop /usr/local/share/applications/xfce4-terminal.desktop && \
    ln -s /usr/local/share/xfce4/helpers/Terminal.desktop /usr/local/share/xfce4/helpers/xfce4-terminal.desktop


FROM centos:6

COPY --from=swr /opt/mesa /opt/mesa
COPY --from=swr /opt/llvm /opt/llvm
COPY --from=builder /usr/local /usr/local

RUN rm -f /etc/yum.repos.d/*
ADD vault.repo /etc/yum.repos.d/vault.repo
ADD crane-6-ofed.repo /etc/yum.repos.d/crane-6-ofed.repo

ENV PYTHONWARNINGS=ignore PATH=${PATH}:/opt/TurboVNC/bin/ LD_LIBRARY_PATH=/opt/mesa/lib64:/opt/llvm/7.0.0/lib:${LD_LIBRARY_PATH} GALLIUM_DRIVER=swr

RUN curl -sSL https://virtualgl.org/pmwiki/uploads/Downloads/VirtualGL.repo > /etc/yum.repos.d/VirtualGL.repo && \
  curl -sSL https://turbovnc.org/pmwiki/uploads/Downloads/TurboVNC.repo > /etc/yum.repos.d/TurboVNC.repo && \
  yum install -y -q epel-release && \
  yum install -y -q yum-utils firefox glib2 gtk2 dbus-glib xdg-user-dirs xkeyboard-config openssh-clients rsync \
  libX11 libXp libICE libSM libgudev1 libXcursor libnotify libXrandr libnotify libjpeg-turbo libexif xfce4-icon-theme xorg-x11-xkb-utils \
  libXScrnSaver wmctrl xorg-x11-server-utils xorg-x11-xauth gnu-free-mono-fonts gnu-free-sans-fonts gnu-free-serif-fonts dbus-x11 \
  https://www.itzgeek.com/msttcore-fonts-2.0-3.noarch.rpm xterm dejavu-fonts-common dejavu-sans-mono-fonts vte gnome-icon-theme \
  gcc turbovnc VirtualGL glx-utils more numactl tcsh xorg-x11-fonts-ISO8859-1-75dpi xorg-x11-fonts-cyrillic \
  lua lua-devel lua-bitop lua-filesystem lua-json lua-lpeg lua-posix lua-term tcl tcl-devel vim nano libcgroup geany quota gtksourceview2 lustre-client

RUN curl -sSL https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh > /tmp/mambaforge.sh && \
    chmod +x /tmp/mambaforge.sh && /tmp/mambaforge.sh -p /opt/conda -b > /dev/null && \
    source /opt/conda/etc/profile.d/conda.sh && \
    mamba install -y -q websockify > /dev/null && \
    ln -s /opt/conda/bin/websockify /usr/bin/websockify

ENV PATH=/opt/conda/bin:${PATH}

RUN echo '/usr/local/lib' >> /etc/ld.so.conf.d/local.conf && ldconfig && \
  fc-cache -f -v && \
  sed -i s/\"IconThemeName\"\ type=\"empty\"/\"IconThemeName\"\ type=\"string\"\ value=\"Rodent\"/g /usr/local/etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml && \
  # Clean
  yum clean all && \
  rm -rf /var/cache/yum/* && \
  rm -f /usr/local/etc/xdg/autostart/xscreensaver.desktop && \
  sed -i s#exo-open\ --launch\ WebBrowser\ %u#'/usr/local/bin/firefox\ about:blank'#g /usr/local/share/applications/exo-web-browser.desktop

# Lmod
RUN curl -sSL https://github.com/TACC/Lmod/archive/refs/tags/8.5.12.tar.gz | tar -zx -C /tmp && \
    pushd /tmp/Lmod-8.5.12 && ./configure --with-module-root-path=/util/opt/modulefiles --with-caseIndependentSorting=yes --with-settarg=no && \
    make && make install

# Profile scripts so we get the same default module behavior
ADD profile.d /etc/profile.d

# Icons and backgrounds
ADD icons /usr/share/icons/hicolor
ADD images /usr/share/backgrounds

ENV GALLIUM_DRIVER="llvmpipe"

# mount directories
RUN mkdir -p /home /work /common /util
