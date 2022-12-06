FROM opengatecollaboration/gate:9.2-docker as builder

FROM unlhcc/xfce_el8_ood:4.16

COPY --from=builder /software /software

RUN yum install -y  make \
                    libX11-devel.x86_64 \
                    libXpm-devel.x86_64 \
                    libXft-devel.x86_64 \
                    libXext-devel.x86_64 \
                    libXmu-devel.x86_64 \
                    libxml2-devel.x86_64 \
                    binutils \
                    qt5-qtbase-devel.x86_64 \
                    git \
                    cmake \
                    wget \
                    mesa-libGLU-devel.x86_64 \
                    python3-devel \
                    which nano

#Prepare entrypoint
RUN \
 echo "source /software/geant4/install/bin/geant4.sh" >> /etc/mybashrc && \
 echo "source /software/root-cern/install/bin/thisroot.sh" >> /etc/mybashrc && \
 echo "export PATH=/software/gate/bin/:$PATH" >> /etc/mybashrc && \
 echo "#!/bin/bash" >> /runGate.sh && \
 echo "source /etc/mybashrc" >> /runGate.sh && \
 echo "cd /APP" >> /runGate.sh && \
 echo "Gate \$1" >> /runGate.sh && \
 chmod a+x /runGate.sh

WORKDIR /APP
ENTRYPOINT ["/runGate.sh"]

