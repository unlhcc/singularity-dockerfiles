FROM ssthapa/freesurferosg:5.3

RUN rm -f /etc/yum.repos.d/*

ADD vault.repo /etc/yum.repos.d/vault.repo

RUN yum clean all && \
    yum install -y -q perl perl-* bc

# Matlab mount point/paths
RUN mkdir -p /opt/matlab
ENV MATLAB_ROOT /opt/matlab
ENV MATLAB_PREFDIR /tmp/matlab/prefs
ENV PATH /opt/matlab/bin:$PATH

# Fix typo in variable from source image
ENV FREESURFER_HOME /usr/local/freesurfer

# Use license from host
RUN ln -s /util/opt/freesurfer/5.3/license.txt /usr/local/freesurfer/license.txt
