FROM almalinux:8.8

RUN dnf -y -q update && \
  dnf install -y -q epel-release && \
  dnf install -y -q 'dnf-command(config-manager)' && \
  dnf config-manager --set-enabled powertools && \
  dnf install -y -q python2 python3 && \
  alternatives --set python /usr/bin/python3

ENV LROSE_VERSION 20230814
RUN dnf -y -q install https://github.com/NCAR/lrose-core/releases/download/lrose-core-${LROSE_VERSION}/lrose-core-${LROSE_VERSION}-almalinux_8.x86_64.rpm

ENV PATH /usr/local/lrose/bin:$PATH
ENV LD_LIBRARY_PATH /usr/local/lrose/lib:$LD_LIBRARY_PATH
