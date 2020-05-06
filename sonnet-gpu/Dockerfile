# Start with our CUDA image
FROM unlhcc/cuda-ubuntu:10.2

# Sonnet 2.0.0+ needs >=py36, so install Python 3.7
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get -qq update && \
    apt-get install -qq -y python3.7 python3.7-dev python3-pip > /dev/null && \
    ln -s /usr/bin/python3.7 /usr/local/bin/python

# Install pip and packages
RUN wget -q https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    pip -q --no-cache-dir install tensorflow-gpu==2.1.0 dm-sonnet==2.0.0 pandas scipy matplotlib scikit-learn scikit-image 'setuptools>=41.0.0' tensorflow-probability numpy

# install dependencies
RUN apt-get -qq update && apt-get -qq install -y libcurl4-openssl-dev zlib1g-dev cmake libjpeg-dev libpng12-dev libpng-dev > /dev/null
