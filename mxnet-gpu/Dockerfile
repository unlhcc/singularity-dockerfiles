# Start with our cuda-ubuntu image
FROM unlhcc/cuda-ubuntu:9.2

# Install both 2.7/3.5 version of Python and pip
RUN apt-get -qq update && apt-get -qq install -y software-properties-common
RUN apt-add-repository multiverse && apt-get -qq update
RUN apt-get -qq install -y python-pip python-dev python3-dev python3-pip

# Install GPU-enabled mxnet and friends
RUN pip --no-cache-dir install opencv-python 'numpy<1.17.0' 'mxnet-cu92==1.5.0' 'pandas<0.25' 'scipy<1.3.0' 'matplotlib<3.0' 'scikit-learn<=0.20' 'scikit-image<0.15' 'networkx==2.2'
RUN pip3 --no-cache-dir install opencv-python numpy 'mxnet-cu92==1.5.0' 'pandas<0.25' scipy 'matplotlib<3.1' scikit-learn scikit-image opencv-python
