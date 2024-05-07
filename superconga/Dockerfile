# This image is modification of https://gitlab.com/superconga/superconga/-/blob/develop/containers/superconga_cuda_latest.def

ARG CUDA=12.1
FROM nvidia/cuda:${CUDA}.1-devel-ubuntu20.04

# Use bash to support string substitution.
SHELL ["/bin/bash", "-c"]

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      build-essential tzdata wget cmake-curses-gui ninja-build \
      curl g++ gcc gfortran git-all libblas-dev libboost-all-dev \
      libfontconfig1-dev libfreeimage-dev libglfw3-dev libhdf5-dev \
      libjsoncpp-dev liblapack-dev ninja-build pkg-config python3-pip \
      python3-tk texlive-base texlive-latex-extra cm-super dvipng \
      && apt remove cmake -y \
      && pip install cmake --upgrade \
    && rm -rf /var/lib/apt/lists/*

# Download SuperConga
ENV SUPERCONGA_VERSION=1.1.0
RUN mkdir -p /app && cd /app \
    && wget -q -P ./superconga https://gitlab.com/superconga/superconga/-/archive/v${SUPERCONGA_VERSION}/superconga-v${SUPERCONGA_VERSION}.tar.gz \
    && tar xvf ./superconga/superconga-v${SUPERCONGA_VERSION}.tar.gz -C ./superconga --strip-components 1 \
    && rm ./superconga/superconga-v${SUPERCONGA_VERSION}.tar.gz

# Install pip packages.
RUN pip3 install -q --no-cache-dir -r /app/superconga/requirements.txt \
    && update-alternatives --install /usr/bin/python python /usr/bin/python3 3

WORKDIR /app/superconga
# Copy directory and files generated on GPU p100 node with
# python /app/superconga/superconga.py setup --no-visualize --type Release
# python /app/superconga/superconga.py compile --type Release
ADD ./build /app/superconga/build/
ADD configure.h /app/superconga/include/conga/configure.h

# Set variables
ENV PATH=/app/superconga:/usr/local/cuda/bin:$PATH \
    CPATH="/usr/local/cuda/include:$CPATH" \
    LD_LIBRARY_PATH="/usr/local/cuda/lib64/:$LD_LIBRARY_PATH" \
    CUDA_HOME="/usr/local/cuda" \
    LC_ALL=C
