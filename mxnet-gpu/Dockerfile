# Start with our CUDA image
FROM unlhcc/cuda-ubuntu:10.2

# Install Python 3.7
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get -qq update && \
    apt-get install -qq -y python3.7 python3.7-dev > /dev/null && \
    ln -s /usr/bin/python3.7 /usr/local/bin/python

# Install pip and MXNet plus usual packages
RUN wget -q https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    pip -q --no-cache-dir install pandas pandas-datareader h5py nbconvert scipy matplotlib scikit-learn scikit-image numpy mxnet-cu102mkl==1.6.0
