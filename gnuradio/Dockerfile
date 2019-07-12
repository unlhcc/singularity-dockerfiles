FROM fedora:26

RUN mkdir -p /work && \
    dnf -q -y groupinstall "Engineering and Scientific" "Development Tools" "C Development Tools and Libraries" && \
    dnf install -q -y fftw-devel cppunit-devel wxPython-devel boost-devel alsa-lib-devel numpy gsl-devel python-devel pygsl python-cheetah python-mako python-lxml PyOpenGL qt-devel PyQt4-devel qwt-devel qwtplot3d-qt4-devel libusbx-devel cmake python-docutils PyQwt PyQwt-devel gtk2-engines xmlrpc-c-"*" tkinter orc-devel python-sphinx SDL-devel swig  zeromq zeromq-devel python-requests gcc-c++ doxygen zeromq-ada-devel cppzmq-devel   php-zmq python-zmq czmq uwsgi-logger-zeromq comedilib comedilib-devel pygtk2 ncurses-"*" thrift-devel scipy git

RUN cd /tmp && \
    git clone --recursive -b v3.14.1.0 https://github.com/EttusResearch/uhd.git && \
    cd uhd/host && mkdir build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr .. && \
    make -j 4 && make install && \
    cd /tmp && ldconfig && \
    git clone --branch v3.7.13.5 --recursive https://github.com/gnuradio/gnuradio.git && \
    cd gnuradio && mkdir build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr .. && \
    make -j 4 && make install && \
    ldconfig && rm -rf /tmp/uhd /tmp/gnuradio
