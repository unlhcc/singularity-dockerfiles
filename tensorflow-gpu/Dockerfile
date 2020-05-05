# Start with our CUDA image
FROM unlhcc/cuda-ubuntu:10.2

# Install wget and build-essential
RUN apt-get -qq update && apt-get -qq install -y \
  build-essential \
  wget vim  module-init-tools

# Install both 2.7/3.5 version of Python and pip
RUN apt-get -qq update && apt-get -qq install -y software-properties-common && \
  apt-add-repository multiverse && apt-get -qq update && \
  apt-get -qq install -y libcupti-dev python-pip python-dev python3-dev python3-pip

# Install TensorFlow (and friends) for both Python 2.7 and 3.5
# TensorFlow 2.0.0 requires pip > 19.0
RUN python2 -m pip install --upgrade pip && \
  pip --no-cache-dir install 'tensorflow-gpu==2.1.0' 'numpy<2.0,>=1.16.0''six>=1.10.0' pandas 'scipy==1.2.2' matplotlib scikit-learn scikit-image 'setuptools>=41.0.0' && \
  python3 -m pip install --upgrade pip && \
  pip3 --no-cache-dir install 'tensorflow-gpu==2.1.0' 'numpy<2.0,>=1.16.0' 'six>=1.10.0' pandas scipy matplotlib scikit-learn scikit-image 'setuptools>=41.0.0'
