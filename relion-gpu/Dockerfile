FROM almalinux:8.6 as builder

ADD oneAPI.repo /etc/yum.repos.d

RUN dnf -y -q update

RUN dnf -y -q --enablerepo=extras install epel-release && \
    dnf -y -q install yum-utils && \
    dnf config-manager --add-repo http://developer.download.nvidia.com/compute/cuda/repos/rhel8/x86_64/cuda-rhel8.repo && \
    dnf --enablerepo=epel -y -q install cuda-11-4

RUN dnf install -y -q intel-oneapi-mkl-devel  \
    cmake git gcc gcc-c++ openmpi-devel \
    libtiff-devel libpng-devel ghostscript libXft-devel libX11-devel libjpeg-devel patch procps-ng  # fltk-devel

# RELION
ENV RELION_VERSION=4.0.1

RUN mkdir /src && curl -sSL https://github.com/3dem/relion/archive/refs/tags/${RELION_VERSION}.tar.gz | tar -zx -C /src

RUN pushd /src/relion-${RELION_VERSION} && \
    mkdir build && pushd build && \
    source /opt/intel/oneapi/mkl/latest/env/vars.sh && \
    source /etc/profile.d/modules.sh && \
    module load mpi/openmpi-x86_64 && \
    cmake -DCMAKE_INSTALL_PREFIX=/opt/relion -DMKLFFT=ON  \
    -DDoublePrec_ACC=OFF -DCUDA_ARCH=35 \
    -DBUILD_SHARED_LIBS=ON -DALTCPU=OFF -DGUI=ON -DCUDA=ON  -DFORCE_OWN_FLTK=ON .. && \
    make -j 8 && \
    make install

# CTFFIND
ENV CTFFIND_VERSION=4.1.14

RUN dnf -y -q install epel-release && \
    dnf -y -q install wxBase3-devel wxGTK3-devel

# This is not stable link, use the SharePoint download we have instead
# RUN curl -sSL "https://grigoriefflab.umassmed.edu/system/tdf?path=ctffind-${CTFFIND_VERSION}.tar.gz&file=1&type=node&id=26" | tar -zx -C /src
RUN curl -sSL --cookie-jar /tmp  "https://uofnelincoln.sharepoint.com/:u:/s/UNL-HollandComputingCenter/Ee0eoKkI-JZHh9x2i2hx4hUBRK_vedGu42OeuEK6IlAR9A?download=1"  | tar -zx -C /src 

# Hack so we don't have to install fftw headers since we're using MKL
ADD 002-ctffind_fftw.patch /src/ctffind-${CTFFIND_VERSION}
# GPU version gives Segmentation Fault
# https://grigoriefflab.umassmed.edu/comment/1696#comment-1696 fixes that
ADD bool_void.patch /src/ctffind-${CTFFIND_VERSION}

RUN pushd /src/ctffind-${CTFFIND_VERSION} && \
    patch -p0 < 002-ctffind_fftw.patch && \
    patch -p0 < bool_void.patch && \
    source /opt/intel/oneapi/mkl/latest/env/vars.sh && \
    export CPATH=$CPATH:/opt/intel/oneapi/mkl/latest/include/fftw/ && \
    ./configure --prefix=/opt/relion --disable-debugmode --enable-mkl --enable-openmp --with-wx-config=`which wx-config` --with-cuda=`which cuda` && \
    make && make install

FROM unlhcc/xfce_el8_ood:4.16

COPY --from=builder /opt/relion /opt/relion

ADD oneAPI.repo /etc/yum.repos.d

RUN dnf install -y -q dnf-plugins-core

RUN dnf install -y -q intel-oneapi-runtime-libs libtiff libpng libjpeg ghostscript libXft libX11 wxBase3 texlive-latex # fltk

RUN cp /etc/profile.d/modules.sh /etc/profile.d/hcc-modules.sh && \
    cp /etc/profile.d/modules.csh /etc/profile.d/hcc-modules.csh
RUN dnf install -y -q --disablerepo=epel openmpi && \
    rm -f /etc/profile.d/modules.{sh,csh}

RUN dnf config-manager --add-repo http://developer.download.nvidia.com/compute/cuda/repos/rhel8/x86_64/cuda-rhel8.repo && \
    dnf --enablerepo=epel -y -q install cuda-libraries-11-4 cuda-nvtx-11-4-11.4.120-1

# MOTIONCOR2 (GPU)
RUN curl -sSL --output /tmp/mc.zip "https://drive.google.com/uc?export=download&id=1-r_FTgLFqLe3i7h8oCz9d5Zhl7mMcni9" && \
    unzip -j -qq -c /tmp/mc.zip MotionCor2_1.5.0/MotionCor2_1.5.0_Cuda114_05-31-2022  > /opt/relion/bin/motioncor2 && \
    chmod +x /opt/relion/bin/motioncor2 && rm -f /tmp/mc.zip

# RESMAP
RUN curl -sSL --output /opt/relion/bin/resmap "https://downloads.sourceforge.net/project/resmap/ResMap-1.1.4-linux64" && \
    chmod +x /opt/relion/bin/resmap

# TikZiT
RUN curl -sSL https://github.com/tikzit/tikzit/releases/download/v2.1.6/tikzit-linux.tar.gz | tar -zx -C /opt && \
    cp /opt/tikzit/share/applications/tikzit.desktop /usr/share/applications && \
    rsync -a /opt/tikzit/share/icons/hicolor/ /usr/share/icons/hicolor

# Topaz (GPU)
ENV TOPAZ_VERSION=0.2.5
ENV TOPAZ_ENV=topaz-${TOPAZ_VERSION}

RUN wget -O ~/miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \
     rm ~/miniconda.sh && \
     /opt/conda/bin/conda create -y --name ${TOPAZ_ENV} python=3.6 numpy pandas scikit-learn && \
     /opt/conda/bin/conda install -n ${TOPAZ_ENV} -c hcc -c conda-forge -c bioconda -c pytorch -c tbepler \
         pytorch=*=*cuda11* torchvision=*=*cu11* topaz=0.2.5 && \
     /opt/conda/bin/conda clean -ya 

ENV PATH=/usr/lib64/openmpi/bin:/opt/relion/bin:/opt/tikzit/bin:/opt/conda/bin/:/opt/conda/envs/${TOPAZ_ENV}/bin/:${PATH} \
    LD_LIBRARY_PATH=/usr/lib64/openmpi/lib:$LD_LIBRARY_PATH \
    RELION_MOTIONCOR2_EXECUTABLE=/opt/relion/bin/motioncor2 \
    RELION_CTFFIND_EXECUTABLE=/opt/relion/bin/ctffind \
    RELION_RESMAP_EXECUTABLE=/opt/relion/bin/resmap \
    RELION_SCRATCH_DIR=/tmp \
    RELION_SHELL=/bin/bash \
    topaz_path=/opt/conda/envs/topaz-0.2.5/bin
