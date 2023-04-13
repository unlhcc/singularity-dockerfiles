FROM rocker/tidyverse:4.2.1

RUN apt-get update && \
    apt-get -y -q install default-jdk tk8.6 lua5.3 lua-filesystem lua-posix lua-term lua-json ssh libbz2-dev libglpk-dev > /dev/null

RUN R CMD javareconf && \
    install2.r rJava > /dev/null 2>&1 && \
    # install workshop libraries
    install2.r tidyverse gridExtra stringr pheatmap grDevices vegan knitr readr tidyr dplyr rstatix BiocManager > /dev/null 2>&1

# Install Bioconductor packages
RUN R -q -s -e 'BiocManager::install("rhdf5")' && \
    R -q -s -e 'BiocManager::install("dada2")' && \
    R -q -s -e 'BiocManager::install("phyloseq")' && \
    R -q -s -e 'BiocManager::install("DESeq2")' && \
    R -q -s -e 'BiocManager::install("Biostrings")'

# Workaround for different Ubuntu/EL lua install paths
RUN ln -s /usr/lib/x86_64-linux-gnu/lua /usr/lib64/lua

# Restore PATH so OOD can find rsession
ENV PATH=/usr/lib/rstudio-server/bin:$PATH
