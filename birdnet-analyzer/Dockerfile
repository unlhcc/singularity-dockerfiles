# This image is modification of https://github.com/kahst/BirdNET-Analyzer/blob/v1.5.1/Dockerfile
# It does not support GPUs yet, https://github.com/kahst/BirdNET-Analyzer/issues/14
FROM ubuntu:22.04

# Use bash to support string substitution.
SHELL ["/bin/bash", "-c"]

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      software-properties-common \
      build-essential \
      cmake \
      git \
      tzdata \
      wget \
      zlib1g \
      zlib1g-dev \
      ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Install Miniconda package manager.
RUN wget -q -P /tmp https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash /tmp/Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda \
    && rm /tmp/Miniconda3-latest-Linux-x86_64.sh

# Install conda packages.
ENV PATH="/opt/conda/bin:$PATH"
RUN /opt/conda/bin/conda create -y -p /opt/birdnet -c hcc -c conda-forge \
      python=3.11 \
      pip \
    && /opt/conda/bin/conda clean -ya

WORKDIR /app
# RUN git clone https://github.com/kahst/BirdNET-Analyzer.git
ENV BIRDNET_VERSION=1.5.1
RUN wget -q -P ./birdnet https://github.com/kahst/BirdNET-Analyzer/archive/refs/tags/v${BIRDNET_VERSION}.tar.gz \
    && tar xvf ./birdnet/v${BIRDNET_VERSION}.tar.gz -C ./birdnet --strip-components 1 \
    && rm ./birdnet/v${BIRDNET_VERSION}.tar.gz

# Install pip packages.
RUN /opt/birdnet/bin/pip install -q --upgrade --no-cache-dir pip \
    && /opt/birdnet/bin/pip install -q --no-cache-dir -r /app/birdnet/requirements.txt

ENV PATH=/opt/birdnet/bin:/app/birdnet/birdnet_analyzer:$PATH \
    PYTHONPATH=/app/birdnet:/opt/birdnet/lib/python3.11/site-packages \
    LC_ALL=C.UTF-8

ENTRYPOINT [ "python3" ]
CMD [ "-m", "birdnet_analyzer.analyze" ]
