# Start with our cuda-ubuntu image
FROM unlhcc/cuda-ubuntu:9.2

# Install both 2.7/3.5 version of Python and pip
RUN apt-get update && apt-get install -y software-properties-common && \
    apt-add-repository multiverse && apt-get update && \
    apt-get install -y libcupti-dev python-pip python-dev python3-dev python3-pip && \
    # Install PyTorch (and friends) for both Python 2.7 and 3.5
    pip install torch==1.0.0 torchvision numpy scipy 'matplotlib<3.0' pandas scikit-learn scikit-image && \
    pip3 install torch==1.0.0 torchvision numpy scipy matplotlib pandas scikit-learn scikit-image
