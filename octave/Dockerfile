FROM centos:6.9

RUN mkdir /work
RUN yum install -y wget epel-release
RUN wget http://people.centos.org/tru/devtools-2/devtools-2.repo -O /etc/yum.repos.d/devtools-2.repo
RUN yum install -y bison flex less tetex atlas-devel ncurses-devel zlib-devel hdf5-devel texinfo qhull-devel \
    readline-devel glibc-devel fftw-devel gperf ghostscript curl-devel pcre-devel texinfo-tex arpack-devel \
    libX11-devel suitesparse-devel glpk-devel gnuplot44 desktop-file-utils GraphicsMagick-c++-devel fltk-devel \
    ftgl-devel qrupdate-devel texlive-dvips bzip2-devel java-1.8.0-openjdk-devel  \
    devtoolset-2-gcc devtoolset-2-binutils devtoolset-2-gcc-gfortran devtoolset-2-gcc-c++

RUN alternatives --install /usr/bin/gnuplot gnuplot /usr/bin/gnuplot-wx44 60
RUN curl -L https://ftp.gnu.org/gnu/octave/octave-4.2.1.tar.gz | tar -C /tmp -zx
RUN source /opt/rh/devtoolset-2/enable && cd /tmp/octave-4.2.1 && \
    ./configure --prefix=/usr/local --with-blas="-L/usr/lib64/atlas -lf77blas -latlas" --with-lapack="-L/usr/lib64/atlas -llapack" && \
    make -j 4 && make install && rm -rf /tmp/octave-4.2.1

RUN chmod u+w /bin /lib /lib64 /usr/bin /usr/sbin /usr/lib /usr/lib64 && \
    rm -rf /tmp/octave-4.2.1 && yum clean all && \
    echo "source /opt/rh/devtoolset-2/enable" >> /etc/profile.d/gcc48.sh
