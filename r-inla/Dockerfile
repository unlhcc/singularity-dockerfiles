FROM ubuntu:16.04

ENV tag=Linux ANACONDA_PREFIX="/anaconda" MINICONDA_VER="4.6.14"

RUN apt-get update && \
    apt-get install -y -q curl bzip2 binutils file

# install (Mini)conda
RUN curl -L -O https://repo.continuum.io/miniconda/Miniconda3-$MINICONDA_VER-$tag-x86_64.sh && \
    bash Miniconda3-$MINICONDA_VER-$tag-x86_64.sh -b -p $ANACONDA_PREFIX && \
    rm -f Miniconda3-$MINICONDA_VER-$tag-x86_64.sh && \
    . ${ANACONDA_PREFIX}/etc/profile.d/conda.sh && \
    # set the channel order
    conda config --system --add channels bioconda && \
    conda config --system --add channels conda-forge && \
    conda config --system --add channels hcc && \
    conda install -y -q r-base=3.6 r-inla=20.03.17 r-tidyverse r-rcpparmadillo r-alphasimr r-tictoc \
    bioconductor-snpstats r-mcmcpack && \
    # remove system libraries that should never be shipped with a binary
    rm -f ${ANACONDA_PREFIX}/lib/R/library/INLA/bin/linux/64bit/libR.so && \
    rm -f ${ANACONDA_PREFIX}/lib/R/library/INLA/bin/linux/64bit/libgfortran.so.4 && \
    rm -f ${ANACONDA_PREFIX}/lib/R/library/INLA/bin/linux/64bit/libc.so.6 && \
    rm -f ${ANACONDA_PREFIX}/lib/R/library/INLA/bin/linux/64bit/libm.so.6 && \
    rm -f ${ANACONDA_PREFIX}/lib/R/library/INLA/bin/linux/64bit/librt.so.1 && \
    rm -f ${ANACONDA_PREFIX}/lib/R/library/INLA/bin/linux/64bit/libz.so.1 && \
    rm -f ${ANACONDA_PREFIX}/lib/R/library/INLA/bin/linux/64bit/libdl.so.2 && \
    rm -f ${ANACONDA_PREFIX}/lib/R/library/INLA/bin/linux/64bit/libpthread.so.0 && \
    rm -f ${ANACONDA_PREFIX}/lib/R/library/INLA/bin/linux/64bit/libstdc++.so.6

ENV PATH=$PATH:$ANACONDA_PREFIX/bin LD_LIBRARY_PATH=$ANACONDA_PREFIX/lib:$ANACONDA_PREFIX/lib/R/library/INLA/bin/linux/64bit
