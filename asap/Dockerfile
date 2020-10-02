FROM ubuntu:16.04
ARG DEBIAN_FRONTEND=noninteractive
# Install ASAP
RUN apt-get -qq update && \
    apt-get -qq -y install apt-utils curl software-properties-common && \
    curl -s -L -O https://github.com/computationalpathologygroup/ASAP/releases/download/1.9/ASAP-1.9-Linux-Ubuntu1604.deb && \
    apt install -q -y ./ASAP-1.9-Linux-Ubuntu1604.deb
ENV PYTHONPATH=/opt/ASAP/bin PATH=/opt/ASAP/bin:$PATH
# Install Python 3.6
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get -qq update && \
    apt-get install -qq -y python3.6 python3.6-dev python3-pip > /dev/null && \
    ln -s /usr/bin/python3.6 /usr/local/bin/python && \
    ln -s /usr/bin/python3.6 /usr/local/bin/python3
# Python packages
RUN python -q -m pip install --upgrade pip && \
  pip -q --no-cache-dir install numpy==1.18.5 setuptools==41.0.0 pandas matplotlib scikit-learn scikit-image seaborn statsmodels spacy keras --upgrade tensorflow PyOpenGL
# OpenCV 3.2
RUN curl -s -L https://github.com/opencv/opencv/archive/3.2.0.tar.gz | tar -xz -C /tmp && cd /tmp/opencv-3.2.0 && \
    apt-get install -qq -y build-essential cmake zlib1g-dev libjpeg-dev libwebp-dev libpng-dev libtiff5-dev libjasper-dev libopenexr-dev libgdal-dev && \
    mkdir build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr -DBUILD_PERF_TESTS=OFF -DBUILD_TESTS=OFF -DBUILD_DOCS=OFF .. && \
    make -j 4 && make install && rm -rf /tmp/opencv-3.2.0
