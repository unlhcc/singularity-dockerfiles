# Start with our cuda-ubuntu image
FROM unlhcc/cuda-ubuntu:10.2

# Install both 3.5 version of Python and pip (PyTorch has dropped 2.X support)
RUN apt-get -qq update && apt-get -qq install -y software-properties-common && \
    apt-add-repository multiverse && apt-get -qq update && \
    apt-get install -qq -y libcupti-dev python3-dev python3-pip

# Install PyTorch (and friends) for both Python 3.5
RUN pip3 --no-cache-dir install 'torch==1.5.0' 'torchvision==0.6.0' numpy scipy 'matplotlib<3.1' 'pandas<=0.24.2' scikit-learn 'scikit-image<0.16' 'networkx==2.0'
