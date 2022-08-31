FROM unlhcc/xfce_ubuntu20_ood:4.14

ARG DEBIAN_FRONTEND=noninteractive

# Install needed libraries
RUN apt-get update && \
    apt-get install -y -q apt-utils && \
    apt-get install -y -q libgstreamer1.0-0 libgstreamer-plugins-base1.0-0 libxss-dev libgomp1 libegl1 libvtk7.1p \
    libxmu-dev libxi-dev openmpi-bin wget libgl1-mesa-glx firefox libopenblas-base libnss3 wget > /dev/null && \
    apt-get clean

RUN wget -q -O sv.deb "https://uofnelincoln.sharepoint.com/:u:/s/UNL-HollandComputingCenter/EQBcU96GOrJPha-P49RKWr8BE0-alTCwyiBUBNmvafMV5Q?e=gKq5NZ&download=1" && \
    wget -q -O pplugin.deb "https://uofnelincoln.sharepoint.com/:u:/s/UNL-HollandComputingCenter/Efa55PVNx91LtMXyH06zXzYBtZ-Qs1XOUF0hsq-9QyxyPw?e=iztnU3&download=1" && \
    wget -q -O svsolv.deb "https://uofnelincoln.sharepoint.com/:u:/s/UNL-HollandComputingCenter/EaHMathz2-NOrpRpmeC5J2cBPRCqtFqLOspvJ-OdlJRqKQ?e=68Ucjp&download=1" && \
    wget -q -O svfsi.deb "https://uofnelincoln.sharepoint.com/:u:/s/UNL-HollandComputingCenter/EfyuEOmHwPhAiUWVsc6y6CgBV1w-UnItBVDXlZu2sbg6Kg?e=uRLukg&download=1" && \
    wget -q -O sv1d.deb "https://uofnelincoln.sharepoint.com/:u:/s/UNL-HollandComputingCenter/EYroFCgu5ypPmd7qWSRnUGQBHj339UTtcuJIeY_R88gUqg?e=RSe2xL&download=1" && \
    apt install ./sv.deb ./pplugin.deb ./svsolv.deb ./svfsi.deb ./sv1d.deb && \
    rm -f *.deb && \
    bash /usr/local/sv/simvascular/2022-07-20/setup-symlinks.sh && \
    bash /usr/local/sv/svsolver/2022-07-22/setup-symlinks.sh && \
    bash /usr/local/sv/svFSI/2022-07-22/setup-symlinks.sh && \
    ln -s /usr/local/sv/oneDSolver/2022-07-22/bin/OneDSolver /usr/local/bin/OneDSolver
