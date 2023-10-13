FROM bioconductor/bioconductor_docker:RELEASE_3_17

RUN apt-get update && \
    apt-get -y -q install default-jdk tk8.6 lua5.3 lua-filesystem lua-posix lua-term lua-json ssh libbz2-dev libglpk-dev > /dev/null

RUN R CMD javareconf && \
    install2.r rJava > /dev/null 2>&1

# Install Bioconductor packages
RUN R -q -s -e 'BiocManager::install(c("Biostrings","phyloseq","dada2","microbiome","ALDEx2","DESeq2","ANCOMBC","mixOmics"))'

# install workshop libraries
RUN install2.r tidyverse vegan corncob eheatmap rstaticx picante ggtern Ternary kableExtra VennDiagram \
    data.table ggsci energy ade4 grid gridExtra ggpubr DT janitor magick devtools ccmm reticulate castor

# Install Miniconda package manger.
RUN wget -q -P /tmp https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh \
    && bash /tmp/Miniforge3-Linux-x86_64.sh -b -p /opt/conda \
    && rm /tmp/Miniforge3-Linux-x86_64.sh

# Install conda packages.
ENV PATH="/opt/conda/bin:$PATH"
RUN conda config --add channels bioconda && \
    conda config --set changeps1 False && \
    conda install -y fasttree=2.1.11 mafft=7.520 biom-format>=2.1.10 epa-ng=0.3.8 gappa=0.8.0 \
    glpk>=4.65 h5py>=2.10.0 "hmmer>=3.1b2,<=3.2.1" joblib>=1.0.1 numpy>=1.19.5 pandas>=1.1.5 \
    "python>=3.5,<3.9" pytest>=4.4.1 pytest-cov>=2.6.1 scipy>=1.2.1 sepp=4.3.10 wget && \
    conda clean -yaq

# Install picrust2
RUN curl -sSL https://github.com/picrust/picrust2/archive/v2.5.2.tar.gz | tar -zx -C /tmp && \
    cd /tmp/picrust2-2.5.2 && \
    pip install . && \
    cp -R picrust2/default_files /opt/conda/lib/python3.8/site-packages/picrust2 && \
    rm -rf /tmp/picrust2-2.5.2

# Workaround for different Ubuntu/EL lua install paths
RUN ln -s /usr/lib/x86_64-linux-gnu/lua /usr/lib64/lua

# Restore PATH so OOD can find rsession
ENV PATH=/usr/lib/rstudio-server/bin:$PATH
