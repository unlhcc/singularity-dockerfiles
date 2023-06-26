FROM unlhcc/xfce_ubuntu20_ood:4.14

ARG DEBIAN_FRONTEND=noninteractive

# Install needed libraries
RUN apt-get update && \
    apt-get install -y -q apt-utils && \
    apt-get install -y -q curl openjdk-8-jre wget make g++ fuse libfuse2 kmod libgtk-3-0 > /dev/null && \
    apt-get clean

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt -y install nodejs && \
    curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version 1.22.4

# Set needed paths
RUN PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH" && \
    JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64

# link JRE server libraries
# https://wiki.xnat.org/xnat-tools/xnat-desktop-client-dxm/installing-the-xnat-desktop-client
RUN mkdir -p /opt/java/linux-x64/jre/lib/amd64 && \
    ln -s /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/server /opt/java/linux-x64/jre/lib/amd64/server

# Download image
RUN cd /opt && \
    wget https://www.bitbucket.org/xnatdev/xnat-desktop-client/downloads/XNAT-Desktop-Client-3.2.4.AppImage && \
    chmod +x XNAT-Desktop-Client-3.2.4.AppImage && \
    ln -s XNAT-Desktop-Client-3.2.4.AppImage XNAT-Desktop-Client.AppImage

ENV PATH=${PATH}:/opt/
