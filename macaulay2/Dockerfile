FROM rockylinux/rockylinux:9.4

# Install necessary plugins and resolve conflicts with curl and install essentials
RUN dnf -y -q update && \
    dnf install -y -q dnf-plugins-core wget gcc gcc-c++ make gmp-devel mpfr-devel ncurses-devel perl perl-CPAN

# Download the Macaulay2 RPM packages
RUN wget -q "https://macaulay2.com/Downloads/Common/Macaulay2-1.24.05-1.common.rpm" -O /tmp/Macaulay2-common.rpm && \
    dnf install -y /tmp/Macaulay2-common.rpm && \
    rm -f /tmp/Macaulay2-common.rpm

RUN wget -q "https://macaulay2.com/Downloads/GNU-Linux/Red%20Hat%20Enterprise,%20CentOS,%20Scientific%20Linux/Macaulay2-1.24.05-1.x86_64-Linux-rocky-9.4.rpm" -O /tmp/Macaulay2.rpm && \
    dnf install -y /tmp/Macaulay2.rpm && \
    rm -f /tmp/Macaulay2.rpm