FROM almalinux:8.5 as builder

ADD oneAPI.repo /etc/yum.repos.d

RUN dnf -y -q update

RUN dnf install -y -q intel-oneapi-mkl-devel intel-oneapi-mpi-devel intel-oneapi-tbb-devel \
    intel-oneapi-compiler-dpcpp-cpp-and-cpp-classic intel-oneapi-compiler-fortran cmake git gcc gcc-c++ \
    libtiff-devel libpng-devel ghostscript libXft-devel libX11-devel libjpeg-devel patch # fltk-devel

# RELION
ENV RELION_VERSION=3.1.3

RUN mkdir /src && curl -sSL https://github.com/3dem/relion/archive/refs/tags/${RELION_VERSION}.tar.gz | tar -zx -C /src

RUN pushd /src/relion-${RELION_VERSION} && mkdir build && pushd build && \
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

RUN curl -sSL "https://grigoriefflab.umassmed.edu/system/tdf?path=ctffind-${CTFFIND_VERSION}.tar.gz&file=1&type=node&id=26" | tar -zx -C /src

# Hack so we don't have to install fftw headers since we're using MKL
ADD ctffind_fftw.patch /src/ctffind-${CTFFIND_VERSION}

RUN pushd /src/ctffind-${CTFFIND_VERSION} && patch -p0 < ctffind_fftw.patch && \
    source  /opt/intel/oneapi/setvars.sh && \
    export CPATH=$CPATH:/opt/intel/oneapi/mkl/latest/include/fftw/ && \
    ./configure --prefix=/opt/relion --disable-debugmode --enable-mkl --enable-openmp && \
    make && make install

FROM unlhcc/xfce_el8_ood:4.16

COPY --from=builder /opt/relion /opt/relion

ADD oneAPI.repo /etc/yum.repos.d

RUN dnf install -y -q dnf-plugins-core

RUN dnf install -y -q intel-oneapi-runtime-libs libtiff libpng libjpeg ghostscript libXft libX11 wxBase3 # fltk

# RESMAP
RUN curl -sSL --output /opt/relion/bin/resmap "https://downloads.sourceforge.net/project/resmap/ResMap-1.1.4-linux64" && \
    chmod +x /opt/relion/bin/resmap

ENV PATH=/opt/relion/bin:${PATH} \
    RELION_CTFFIND_EXECUTABLE=/opt/relion/bin/ctffind \
    RELION_RESMAP_EXECUTABLE=/opt/relion/bin/resmap \
    RELION_SCRATCH_DIR=/tmp \
    RELION_SHELL=/bin/bash
