# Use Ubuntu base image
FROM ubuntu:16.04

ARG DEBIAN_FRONTEND="noninteractive"
RUN apt-get update && apt-get install -y wget build-essential sudo
RUN cd /opt/ && wget https://github.com/dcouvin/CRISPRCasFinder/archive/release-4.2.20.tar.gz && \
tar -xvf release-4.2.20.tar.gz && \
rm release-4.2.20.tar.gz && \
ln -s CRISPRCasFinder-release-4.2.20 CRISPRCasFinder && \
cd CRISPRCasFinder && \
sed -i 's/sudo cpanm Bio::Tools::Run::Alignment::Muscle/sudo cpanm Bio::Tools::Run::Alignment::Muscle --force/g' installer_UBUNTU.sh && \
bash installer_UBUNTU.sh && \
export MACSY_HOME=/opt/CRISPRCasFinder/macsyfinder-1.0.5 && \
export PATH=/opt/CRISPRCasFinder/bin:$PATH:/opt/CRISPRCasFinder

ENV PATH=/opt/CRISPRCasFinder/bin:$PATH:/opt/CRISPRCasFinder
ENV MACSY_HOME=/opt/CRISPRCasFinder/macsyfinder-1.0.5

