FROM ubuntu:16.04
# Install ASAP
RUN apt-get -qq update && \
    apt-get -qq -y install curl software-properties-common && \
    curl -s -L -O https://github.com/computationalpathologygroup/ASAP/releases/download/1.9/ASAP-1.9-Linux-Ubuntu1604.deb && \
    apt install -q -y ./ASAP-1.9-Linux-Ubuntu1604.deb
# Install Python 3.6
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get -qq update && \
    apt-get install -qq -y python3.6 python3.6-dev python3-pip > /dev/null && \
    ln -s /usr/bin/python3.6 /usr/local/bin/python
# Python packages
RUN python -q -m pip install --upgrade pip && \
  pip -q --no-cache-dir install numpy==1.18.5 setuptools==41.0.0 pandas matplotlib scikit-learn scikit-image seaborn statsmodels spacy keras --upgrade tensorflow
ENV PYTHONPATH=/opt/ASAP/bin PATH=/opt/ASAP/bin:$PATH
