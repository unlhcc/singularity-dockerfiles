# Start with our cuda-ubuntu image
FROM unlhcc/cuda-ubuntu:10.2


# Install Python 3.7 to be more modern
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get -qq update && \
    apt-get install -qq -y python3.7 python3.7-dev python3-pip > /dev/null && \
    ln -s /usr/bin/python3.7 /usr/local/bin/python && \
    ln -s /usr/bin/python3.7 /usr/local/bin/python3


# Install pip and PyTorch and friends
RUN wget -q https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    pip -q --no-cache-dir install 'torch==1.5.0' 'torchvision==0.6.0' numpy scipy \
    'matplotlib<3.1' 'pandas<=0.24.2' scikit-learn 'scikit-image<0.16' 'networkx==2.0'
