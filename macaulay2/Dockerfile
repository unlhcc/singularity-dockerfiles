FROM fedora:26
RUN dnf install Macaulay2.x86_64 -y && ln -s /usr/lib64/atlas/libsatlas.so.3 /usr/lib64/libsatlas.so.3
RUN mkdir /work && ldconfig
