FROM centos:6.10

RUN rm -f /etc/yum.repos.d/*

ADD vault.repo /etc/yum.repos.d/vault.repo

# Needed packages
RUN yum clean all && yum install -y -q epel-release
RUN yum install -y -q perl bc libgomp tar tcsh libpng bzip2 zlib libXScrnSaver # qt qt-x11 vtk-qt
RUN yum groupinstall -y -q "X Window System"
RUN yum clean all

# Matlab mount point/paths
RUN mkdir -p /opt/matlab
ENV MATLAB_ROOT /opt/matlab
ENV MATLAB_PREFDIR /tmp/matlab/prefs
ENV PATH /opt/matlab/bin:$PATH

# Download Freesurfer
RUN curl -sSL https://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/6.0.1/freesurfer-Linux-centos6_x86_64-stable-pub-v6.0.1.tar.gz | tar -zx -C /usr/local

# Needed variables
ENV FREESURFER_HOME=/usr/local/freesurfer \
FIX_VERTEX_AREA="" FMRI_ANALYSIS_DIR=/usr/local/freesurfer/6.0/fsfast \
FREESURFER=/usr/local/freesurfer \
FSFAST_HOME=/usr/local/freesurfer/fsfast \
FSF_OUTPUT_FORMAT=nii.gz \
FS_OVERRIDE=0 \
FUNCTIONALS_DIR=/usr/local/freesurfer/sessions \
LOCAL_DIR=/usr/local/freesurfer/local \
MINC_BIN_DIR=/usr/local/freesurfer/mni/bin \
MINC_LIB_DIR=/usr/local/freesurfer/mni/lib \
MNI_DATAPATH=/usr/local/freesurfer/mni/data \
MNI_DIR=/usr/local/freesurfer/mni \
MNI_PERL5LIB=/usr/local/freesurfer/mni/share/perl5 \
PERL5LIB=/usr/local/freesurfer/mni/share/perl5 \
SUBJECTS_DIR=/usr/local/freesurfer/subjects

ENV PATH=/usr/local/freesurfer/bin:/usr/local/freesurfer/mni/bin:/usr/local/freesurfer/tktools:/usr/local/freesurfer/fsfast/bin:$PATH

# Use license from host
RUN ln -s /util/opt/freesurfer/6.0/license.txt /usr/local/freesurfer/license.txt
