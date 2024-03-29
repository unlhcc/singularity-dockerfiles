# Copyright 2021 DeepMind Technologies Limited
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This image is modification of https://raw.githubusercontent.com/uvarc/rivanna-docker/master/alphafold/2.0.0/Dockerfile

ARG CUDA=11.1
FROM nvidia/cuda:${CUDA}.1-cudnn8-devel-ubuntu18.04 AS build
ARG CUDA

# Use bash to support string substitution.
SHELL ["/bin/bash", "-c"]

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      build-essential \
      cmake \
      cuda-command-line-tools-${CUDA/./-} \
      git \
      hmmer \
      kalign \
      tzdata \
      wget \
    && rm -rf /var/lib/apt/lists/*

# Compile HHsuite from source.
RUN git clone --branch v3.3.0 https://github.com/soedinglab/hh-suite.git /tmp/hh-suite
WORKDIR /tmp/hh-suite/build
RUN cmake -DHAVE_AVX2=1 -DCMAKE_INSTALL_PREFIX=/opt/hhsuite .. \
    && make -j 4 && make install \
    && ln -s /opt/hhsuite/bin/* /usr/bin \
    && rm -rf /tmp/hh-suite

# Install Miniconda package manager.
RUN wget -q -P /tmp https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash /tmp/Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda \
    && rm /tmp/Miniconda3-latest-Linux-x86_64.sh

# Install conda packages.
ENV PATH="/opt/conda/bin:$PATH"
RUN /opt/conda/bin/conda create -y -p /opt/alphafoldenv -c conda-forge \
      python=3.8 \
      openmm=7.5.1 \
      cudatoolkit==${CUDA}.1 \
      pdbfixer \
      pip \
    && /opt/conda/bin/conda clean -ya

WORKDIR /app
# RUN git clone https://github.com/deepmind/alphafold.git
ENV ALPHAFOLD_VERSION=2.3.2
RUN wget -q -P ./alphafold https://github.com/deepmind/alphafold/archive/refs/tags/v${ALPHAFOLD_VERSION}.tar.gz \
    && tar xvf ./alphafold/v${ALPHAFOLD_VERSION}.tar.gz -C ./alphafold --strip-components 1 \
    && rm ./alphafold/v${ALPHAFOLD_VERSION}.tar.gz
RUN wget -q -P /app/alphafold/alphafold/common/ \
  https://git.scicore.unibas.ch/schwede/openstructure/-/raw/7102c63615b64735c4941278d92b554ec94415f8/modules/mol/alg/src/stereo_chemical_props.txt

# Install pip packages.
RUN /opt/alphafoldenv/bin/pip install -q --upgrade --no-cache-dir pip \
    && sed -i 's/^tensorflow.*$/tensorflow==2.9.0/' /app/alphafold/requirements.txt \
    && /opt/alphafoldenv/bin/pip install -q --no-cache-dir -r /app/alphafold/requirements.txt \
    && /opt/alphafoldenv/bin/pip install -q --upgrade --no-cache-dir jax==0.3.25 jaxlib==0.3.25+cuda11.cudnn805 -f \
       https://storage.googleapis.com/jax-releases/jax_cuda_releases.html

# Apply OpenMM patch.
# Per https://github.com/google-deepmind/alphafold/issues/404 patch is not needed anymore
# for next releases and higher openmm version
WORKDIR /opt/alphafoldenv/lib/python3.8/site-packages
RUN patch -p0 < /app/alphafold/docker/openmm.patch

FROM nvidia/cuda:${CUDA}.1-cudnn8-devel-ubuntu18.04
ARG CUDA

SHELL ["/bin/bash", "-c"]

# add cudnn and cusolver
RUN apt-get update && apt-get install -y --no-install-recommends \
      libcusolver-11-1 \
      cuda-command-line-tools-${CUDA/./-} \
      hmmer \
      kalign \
    && rm -rf /var/lib/apt/lists/*

COPY --from=build /app /app
COPY --from=build /opt/alphafoldenv /opt/alphafoldenv
COPY --from=build /opt/hhsuite /opt/hhsuite

# hhsuite executable path hardcoded as /usr/bin in run_alphafold.py
RUN ln -s /opt/hhsuite/bin/* /usr/bin

# We need to run `ldconfig` first to ensure GPUs are visible, due to some quirk
# with Debian. See https://github.com/NVIDIA/nvidia-docker/issues/1399 for
# details.
# ENTRYPOINT does not support easily running multiple commands, so instead we
# write a shell script to wrap them up.

WORKDIR /app/alphafold
RUN echo $'#!/bin/bash\n\
ldconfig\n\
python /app/alphafold/run_alphafold.py "$@"' > /app/run_alphafold.sh \
  && chmod +x /app/run_alphafold.sh

ENV PATH=/opt/alphafoldenv/bin:/usr/local/cuda-11.1/bin:$PATH \
    PYTHONPATH=/opt/alphafoldnev/lib/python3.8/site-packages \
    LD_LIBRARY_PATH=/usr/local/cuda-11.1/targets/x86_64-linux/lib/:$LD_LIBRARY_PATH \
    LC_ALL=C.UTF-8

# This image is modification of https://raw.githubusercontent.com/uvarc/rivanna-docker/master/alphafold/2.0.0/Dockerfile
LABEL maintainer=hcc-support@unl.edu \
      homepage=https://github.com/deepmind/alphafold \
      description="Open source code for AlphaFold" \
      gpu=true \
      moduleclass=bio

ENTRYPOINT ["/app/run_alphafold.sh"]
