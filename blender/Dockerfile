FROM centos:7.7.1908

RUN mkdir -p /opt/blender && \
    curl -sSL https://mirror.clarkson.edu/blender/release/Blender2.83/blender-2.83.1-linux64.tar.xz | tar -Jx -C /opt/blender --strip-components 1 && \
    yum install -y -q libX11 libXi mesa-libGL libXrender

ENV PATH=/opt/blender:$PATH
