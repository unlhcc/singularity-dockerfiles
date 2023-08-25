FROM rocker/tidyverse:4.3.1

RUN apt-get update && \
    apt-get -y -q install default-jdk tk8.6 lua5.3 lua-filesystem lua-posix lua-term lua-json ssh libbz2-dev libglpk-dev > /dev/null

RUN R CMD javareconf && \
    install2.r rJava > /dev/null 2>&1 && \
    # install workshop libraries
    install2.r sommer rMVP ggplot2 BiocManager > /dev/null 2>&1

# Install Miniconda package manger.
RUN wget -q -P /tmp https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash /tmp/Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda \
    && rm /tmp/Miniconda3-latest-Linux-x86_64.sh

# Install conda packages.
ENV PATH="/opt/conda/bin:$PATH"
RUN conda config --add channels conda-forge && \
    conda config --add channels bioconda && \
    conda install -y bcftools=1.17 vcftools=0.1.16 tassel=5.2 && \
    conda clean -yaq

# Workaround for different Ubuntu/EL lua install paths
RUN ln -s /usr/lib/x86_64-linux-gnu/lua /usr/lib64/lua

# Restore PATH so OOD can find rsession
ENV PATH=/usr/lib/rstudio-server/bin:$PATH
