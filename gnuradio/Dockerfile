FROM fedora:26

RUN mkdir -p /work && \
    dnf -y groupinstall "Engineering and Scientific" "Development Tools" "C Development Tools and Libraries" && \
    dnf install -y fftw-devel cppunit-devel wxPython-devel boost-devel alsa-lib-devel numpy gsl-devel python-devel pygsl python-cheetah python-mako python-lxml PyOpenGL qt-devel PyQt4-devel qwt-devel qwtplot3d-qt4-devel libusbx-devel cmake python-docutils PyQwt PyQwt-devel gtk2-engines xmlrpc-c-"*" tkinter orc-devel python-sphinx SDL-devel swig  zeromq zeromq-devel python-requests gcc-c++ doxygen zeromq-ada-devel cppzmq-devel   php-zmq python-zmq czmq uwsgi-logger-zeromq comedilib comedilib-devel pygtk2 ncurses-"*" thrift-devel scipy git  && \
    cd /tmp && \
    git clone --recursive -b python-api https://github.com/EttusResearch/uhd.git && \
    cd uhd/host && mkdir build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr .. && \
    make -j 4 && make install && \
    cd /tmp && ldconfig && \
    git clone --branch v3.7.11 --recursive https://github.com/gnuradio/gnuradio.git && \
    cd gnuradio && mkdir build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr .. && \
    make -j 4 && make install && \
    ldconfig && rm -rf /tmp/uhd /tmp/gnuradio
