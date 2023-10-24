FROM almalinux:8.6 as builder

ADD oneAPI.repo /etc/yum.repos.d

RUN dnf -y -q update

RUN dnf install -y -q intel-oneapi-mkl-devel intel-oneapi-mpi-devel intel-oneapi-tbb-devel \
    intel-oneapi-compiler-dpcpp-cpp-and-cpp-classic intel-oneapi-compiler-fortran cmake git gcc gcc-c++ \
    libtiff-devel libpng-devel ghostscript libXft-devel libX11-devel libjpeg-devel patch procps-ng # fltk-devel

# Hush icc/icpc deprecation warnings
RUN echo '-diag-disable=10441' >> /opt/intel/oneapi/compiler/latest/linux/bin/intel64/icc.cfg && \
    echo '-diag-disable=10441' >> /opt/intel/oneapi/compiler/latest/linux/bin/intel64/icpc.cfg

# RELION
ENV RELION_VERSION=4.0.1

RUN mkdir /src && curl -sSL https://github.com/3dem/relion/archive/refs/tags/${RELION_VERSION}.tar.gz | tar -zx -C /src

ADD 001-tbb-altcpu.patch /src/relion-${RELION_VERSION}

RUN pushd /src/relion-${RELION_VERSION} && patch -p0 -i 001-tbb-altcpu.patch && \
    mkdir build && pushd build && \
    source /opt/intel/oneapi/setvars.sh && \
    cmake -DCMAKE_INSTALL_PREFIX=/opt/relion -DMKLFFT=ON -DCMAKE_C_COMPILER=icc \
    -DCMAKE_CXX_COMPILER=icpc -DMPI_C_COMPILER=mpiicc -DMPI_CXX_COMPILER=mpiicpc \
    -DCMAKE_C_FLAGS="-O3 -ip -g -xAVX -axCORE-AVX2,COMMON-AVX512 -restrict " \
    -DCMAKE_CXX_FLAGS="-O3 -ip -g -xAVX -axCORE-AVX2,COMMON-AVX512 -restrict " \
    -DBUILD_SHARED_LIBS=ON -DALTCPU=ON -DGUI=ON -DCUDA=OFF .. -DFORCE_OWN_FLTK=ON && \
    make -j 8 && \
    make install

# CTFFIND
ENV CTFFIND_VERSION=4.1.14

RUN dnf -y -q install epel-release && \
    dnf -y -q install wxBase3-devel wxGTK3-devel

# This is not stable link, use the SharePoint download we have instead
# RUN curl -sSL "https://grigoriefflab.umassmed.edu/system/tdf?path=ctffind-${CTFFIND_VERSION}.tar.gz&file=1&type=node&id=26" | tar -zx -C /src
RUN curl -sSL --cookie-jar /tmp  "https://uofnelincoln.sharepoint.com/:u:/s/UNL-HollandComputingCenter/Ee0eoKkI-JZHh9x2i2hx4hUBRK_vedGu42OeuEK6IlAR9A?download=1" | tar -zx -C /src

# Hack so we don't have to install fftw headers since we're using MKL
ADD ctffind_fftw.patch /src/ctffind-${CTFFIND_VERSION}

RUN pushd /src/ctffind-${CTFFIND_VERSION} && patch -p0 < ctffind_fftw.patch && \
    source  /opt/intel/oneapi/setvars.sh && \
    export CPATH=$CPATH:/opt/intel/oneapi/mkl/latest/include/fftw/ && \
    ./configure --prefix=/opt/relion --disable-debugmode --enable-mkl --enable-openmp --with-wx-config=`which wx-config` && \
    make && make install

FROM unlhcc/xfce_el8_ood:4.16

COPY --from=builder /opt/relion /opt/relion

ADD oneAPI.repo /etc/yum.repos.d

RUN dnf install -y -q dnf-plugins-core

RUN dnf install -y -q intel-oneapi-runtime-libs libtiff libpng libjpeg ghostscript libXft libX11 wxBase3 texlive-latex # fltk

# RESMAP
RUN curl -sSL --output /opt/relion/bin/resmap "https://downloads.sourceforge.net/project/resmap/ResMap-1.1.4-linux64" && \
    chmod +x /opt/relion/bin/resmap

# TikZiT
RUN curl -sSL https://github.com/tikzit/tikzit/releases/download/v2.1.6/tikzit-linux.tar.gz | tar -zx -C /opt && \
    cp /opt/tikzit/share/applications/tikzit.desktop /usr/share/applications && \
    rsync -a /opt/tikzit/share/icons/hicolor/ /usr/share/icons/hicolor && \
    rsync -a /opt/tikzit/share/icons/hicolor/ /usr/share/icons/Adwaita && \
    gtk-update-icon-cache /usr/share/icons/hicolor && \
    gtk-update-icon-cache /usr/share/icons/Adwaita

# Topaz
ENV TOPAZ_VERSION=0.2.5
ENV TOPAZ_ENV=topaz-${TOPAZ_VERSION}

RUN wget -O ~/miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \
     rm ~/miniconda.sh && \
     /opt/conda/bin/conda create -y --name ${TOPAZ_ENV} python=3.6 numpy pandas scikit-learn && \
     /opt/conda/bin/conda install -n ${TOPAZ_ENV} -c hcc -c conda-forge -c bioconda -c pytorch -c tbepler \
         pytorch=*=*cpu* torchvision=*=*cpu* topaz=0.2.5 && \
     /opt/conda/bin/conda clean -ya 

ENV PATH=/opt/relion/bin:/opt/tikzit/bin:/opt/conda/bin/:/opt/conda/envs/${TOPAZ_ENV}/bin/:${PATH} \
    RELION_CTFFIND_EXECUTABLE=/opt/relion/bin/ctffind \
    RELION_RESMAP_EXECUTABLE=/opt/relion/bin/resmap \
    RELION_SCRATCH_DIR=/tmp \
    RELION_SHELL=/bin/bash \
    topaz_path=/opt/conda/envs/topaz-0.2.5/bin
