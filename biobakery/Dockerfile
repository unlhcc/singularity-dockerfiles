# use the publicly available biobakery image
FROM biobakery/workflows

# USER root
# WORKDIR root

# mount work/common
RUN mkdir -p /work /common

# downgrade kneaddata till they fix their scripts
RUN pip3 --no-cache-dir install kneaddata==0.7.6
