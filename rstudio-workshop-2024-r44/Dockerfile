FROM rocker/tidyverse:4.4.0

RUN apt-get update && \
    apt-get -y -q install default-jdk tk8.6 lua5.3 lua-filesystem lua-posix lua-term lua-json ssh libbz2-dev libglpk-dev > /dev/null

RUN R CMD javareconf && \
    install2.r rJava > /dev/null 2>&1 && \
    # install workshop libraries
    install2.r tidyverse gridExtra ggplot2 gdal matrix stringr grDevices vegan tidyr dplyr remotes devtools R.utils Seurat BiocManager > /dev/null 2>&1

# Install Bioconductor packages
RUN R -q -s -e 'BiocManager::install("BiocGenerics")' && \
    R -q -s -e 'BiocManager::install("DelayedArray")' && \
    R -q -s -e 'BiocManager::install("DelayedMatrixStats")' && \
    R -q -s -e 'BiocManager::install("limma")' && \
    R -q -s -e 'BiocManager::install("lme4")' && \
    R -q -s -e 'BiocManager::install("S4Vectors")' && \
    R -q -s -e 'BiocManager::install("SingleCellExperiment")' && \
    R -q -s -e 'BiocManager::install("SummarizedExperiment")' && \
    R -q -s -e 'BiocManager::install("batchelor")' && \
    R -q -s -e 'BiocManager::install("HDF5Array")' && \
    R -q -s -e 'BiocManager::install("terra")' && \
    R -q -s -e 'BiocManager::install("ggrastr")' && \
    R -q -s -e 'devtools::install_github("cole-trapnell-lab/monocle3")' && \
    R -q -s -e 'remotes::install_github("satijalab/seurat-wrappers")'

# Workaround for different Ubuntu/EL lua install paths
RUN ln -s /usr/lib/x86_64-linux-gnu/lua /usr/lib64/lua

# Restore PATH so OOD can find rsession
ENV PATH=/usr/lib/rstudio-server/bin:$PATH
