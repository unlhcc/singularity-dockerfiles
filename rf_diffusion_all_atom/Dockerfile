ARG CUDA=11.8
FROM nvidia/cuda:${CUDA}.0-cudnn8-devel-ubuntu22.04
ARG CUDA

# Use bash to support string substitution.
SHELL ["/bin/bash", "-c"]

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      build-essential \
      cmake \
      cuda-command-line-tools-${CUDA/./-} \
      git \
      tzdata \
      wget \
      git \
    && rm -rf /var/lib/apt/lists/*

# Install Miniconda package manager.
RUN wget -q -P /tmp https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash /tmp/Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda \
    && rm /tmp/Miniconda3-latest-Linux-x86_64.sh
ENV PATH="/opt/conda/bin:$PATH"

# Install conda packages.
COPY rf_se3_diffusion.yml .
RUN conda env create -f rf_se3_diffusion.yml
ENV PATH "/opt/conda/envs/RFDiffusionAA/bin:$PATH"
RUN echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc
RUN echo "conda activate RFDiffusionAA" >> ~/.bashrc

# Clone repo and install Python packages
ENV RF_DIFFUSION_AA_COMMIT=f913a19e16f30858ce7a724fe028475b1871319c
RUN cd /opt && git clone  https://github.com/baker-laboratory/rf_diffusion_all_atom.git && \
    cd rf_diffusion_all_atom && git reset --hard ${RF_DIFFUSION_AA_COMMIT} && \
    git submodule init && git submodule update && \
    chmod +x *.py && \
    pip install rf2aa/SE3Transformer

# Add patch to fix cache dir
ADD diffusion_cache.patch /opt/rf_diffusion_all_atom/
RUN cd /opt/rf_diffusion_all_atom/ && \
    patch diffusion.py -i diffusion_cache.patch

# Model weights location env
ENV RFDiffusionAA_WEIGHTS /work/HCC/BCRF/app_specific/rf_diffusion_all_atom/2024.03.13/RFDiffusionAA_paper_weights.pt

WORKDIR /opt/rf_diffusion_all_atom/

ENV PATH /opt/rf_diffusion_all_atom/:$PATH
