FROM openswr/openswr:centos7.7 as openswr

USER root

RUN mkdir -p /build && \
    curl -sSL https://github.com/mesa3d/mesa/archive/mesa-20.1.1.tar.gz | tar -zx -C /build && \
    pushd /build/mesa-mesa-20.1.1 && mkdir build && \
    meson --buildtype=release \
        -Dglx=gallium-xlib \
        -Dvulkan-drivers= \
        -Ddri-drivers= \
        -Dgallium-drivers=swrast,swr \
        -Dplatforms=x11 \
        -Dgallium-omx=disabled \
        -Dprefix=$MESA_INSTALL_DIR \
        -Dosmesa=gallium \
        build && \
    ninja -C build && \
    meson install -C build


FROM centos:7.7.1908

COPY --from=openswr /opt/mesa /opt/mesa
COPY --from=openswr /opt/llvm /opt/llvm

ADD TurboVNC.repo /etc/yum.repos.d/TurboVNC.repo
ADD CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo
ADD epel.repo /etc/yum.repos.d/epel.repo
ADD RPM-GPG-KEY-EPEL-7 /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7

RUN yum -y -q --disableplugin=fastestmirror update && \
    yum -y -q --disableplugin=fastestmirror groupinstall Xfce && \
    yum -y -q --disableplugin=fastestmirror install xorg-x11-fonts-Type1 xorg-x11-fonts-misc x11vnc dbus-x11 dbus-glib python2-pip turbovnc \
    vim nano geany more less https://www.itzgeek.com/msttcore-fonts-2.0-3.noarch.rpm firefox wget mousepad && \
    pip install -q --no-cache-dir ts nose numpy==1.11 && \
    pip install -q --no-cache-dir websockify && \
    # Install Lmod dependencies
    yum -y -q --disableplugin=fastestmirror install lua lua-bitop lua-filesystem lua-json lua-lpeg lua-posix lua-term tcl && \
    yum -y -q --disableplugin=fastestmirror erase xfce4-power-manager && \
    # Clean
    yum clean all && \
    rm -rf /var/cache/yum/*

# Change the "web browser" launcher to firefox directly
RUN sed -i s/exo-web-browser/firefox/g /etc/xdg/xfce4/panel/default.xml

# Remove autostart items that cause issues/errors
RUN rm -f /etc/xdg/autostart/{xfce-polkit.desktop,xscreensaver.desktop}

ENV PATH=${PATH}:/opt/TurboVNC/bin/ LD_LIBRARY_PATH=/opt/mesa/lib64:/opt/llvm/8.0.1/lib:${LD_LIBRARY_PATH}

RUN mkdir -p /home /work /common /util
