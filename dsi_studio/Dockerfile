FROM dsistudio/dsistudio:chen-2022-04-18

RUN apt-get update && \
    apt install -y -qq xfce4 xfce4-terminal firefox gcc lua5.3 liblua5.3-dev lua-term lua-posix lua-filesystem lua-json tcl tcl-dev python2.7 \
    freeglut3 rsync screen tree file wget zip unzip bzip2 ncdu htop iotop strace gdb > /dev/null

RUN ln -s /bin/python2.7 /bin/python2 && \
    curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py && \
    python2 get-pip.py && \
    pip2 install -q --no-cache-dir ts nose numpy==1.11 websockify==0.9.0 && \
    ln -s /usr/local/bin/websockify /usr/bin

# TurboVNC 
RUN curl -sSL -O https://downloads.sourceforge.net/project/turbovnc/2.2.7/turbovnc_2.2.7_amd64.deb && \
    dpkg -i turbovnc*.deb && apt install -f

# Lmod
RUN curl -sSL https://github.com/TACC/Lmod/archive/refs/tags/8.5.12.tar.gz | tar -zx -C /tmp && \
    cd /tmp/Lmod-8.5.12 && ./configure --with-module-root-path=/util/opt/modulefiles --with-caseIndependentSorting=yes --with-settarg=no && \
    make && make install

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
RUN mkdir -p /home /work /common /util
