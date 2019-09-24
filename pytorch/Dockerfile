# Start with our cuda-ubuntu image
FROM unlhcc/cuda-ubuntu:9.2

# Install both 2.7/3.5 version of Python and pip
RUN apt-get -qq update && apt-get -qq install -y software-properties-common && \
    apt-add-repository multiverse && apt-get -qq update && \
    apt-get install -qq -y libcupti-dev python-pip python-dev python3-dev python3-pip

# Install PyTorch (and friends) for both Python 2.7 and 3.5
RUN pip --no-cache-dir install 'torchvision==0.4.0' 'torch==1.2.0' 'numpy<=1.16.5' 'scipy<1.3.0' 'matplotlib<3.0' 'pandas<=0.24.2' 'scikit-learn<=0.20' 'scikit-image<0.15' typing 'networkx==2.0'
RUN pip3 --no-cache-dir install 'torchvision==0.4.0' 'torch==1.2.0' numpy scipy 'matplotlib<3.1' 'pandas<=0.24.2' scikit-learn scikit-image 'networkx==2.0'
