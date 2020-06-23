FROM centos:7.7.1908

RUN curl -sSL "https://faculty.math.illinois.edu/Macaulay2/Downloads/GNU-Linux/Red%20Hat%20Enterprise,%20CentOS,%20Scientific%20Linux/Macaulay2-7.repo" \
    > /etc/yum.repos.d/macaulay2.repo && \
    yum update -y -q && \
    yum install -y -q Macaulay2 && \
    mkdir /work /common
