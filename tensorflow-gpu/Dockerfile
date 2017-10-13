# Start with our CUDA Ubuntu image
FROM unlhcc/cuda-ubuntu

# Install both 2.7/3.5 version of Python and pip
RUN apt-get update && apt-get install -y software-properties-common 
RUN apt-add-repository multiverse && apt-get update
RUN apt-get install -y libcupti-dev python-pip python-dev python3-dev python3-pip

# Download cuDNN from Box since it requires a CUDA developer account
RUN cd /tmp && wget https://unl.box.com/shared/static/y92g0umhpcre3qr2siiqi56aos9k7yk1.tgz
RUN cd /tmp && tar -zxvf y92g0umhpcre3qr2siiqi56aos9k7yk1.tgz && mv cuda/lib64/* /usr/local/cuda/lib64 && mv cuda/include/* /usr/local/cuda/include

# Install TensorFlow (and friends) for both Python 2.7 and 3.5
RUN pip install tensorflow-gpu==1.3.0 numpy scipy matplotlib pandas scikit-learn scikit-image
RUN pip3 install tensorflow-gpu==1.3.0 numpy scipy matplotlib pandas scikit-learn scikit-image

# Env setup
ADD environment /environment
ADD docker_environment /docker_environment
ADD cuda.conf /etc/ld.so.conf.d
RUN ldconfig -v
