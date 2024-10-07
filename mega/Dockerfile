FROM ubuntu:22.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt install -y -qq xfce4 xfce4-terminal firefox gcc lua5.3 liblua5.3-dev lua-term lua-posix lua-filesystem lua-json \
    tcl tcl-dev python2.7 build-essential libgtk2.0-0 libgconf-2-4 libcanberra-gtk* chromium-browser python2 python2-dev \
    freeglut3 rsync screen tree file wget zip unzip bzip2 ncdu htop iotop strace gdb curl > /dev/null

ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_CTYPE=en_US.UTF-8

# TurboVNC 
RUN curl -sSL -O https://sourceforge.net/projects/turbovnc/files/3.1/turbovnc_3.1_amd64.deb && \
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

# Download MEGA
RUN wget -q -O mega.deb "https://uofnelincoln.sharepoint.com/:u:/s/UNL-HollandComputingCenter/EZu8mxJJU4hLsUROUhUSpVUBmL1ge2TslaOmwDri-2MSAQ?e=8qvBIT&download=1" && \
    dpkg -i ./mega.deb && \
    rm -f *.deb

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

ENV LD_LIBRARY_PATH=/usr/lib/mega/:/usr/lib/x86_64-linux-gnu/:$LD_LIBRARY_PATH \
    LIBRARY_PATH=/usr/lib/mega/:/usr/lib/x86_64-linux-gnu/:$LIBRARY_PATH
