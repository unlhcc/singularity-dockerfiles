# Download base image Centos 7
FROM centos:7

# Update Centos and install dependencies
RUN yum -q -y install yum-utils make wget xz-devel unzip epel-release gcc-gfortran gcc-c++ expat-devel \
    libXt-devel libcurl-devel vim less git zlib-devel bzip2 perl-core perl-base perl-devel perl-CPAN cpanspec cpanminus && \
    yum -q -y update && \    
    yum clean all

# Install mpicc
RUN yum -q -y install openmpi openmpi-devel && \
    ln -s /usr/lib64/openmpi/bin/mpicc /usr/bin/mpicc

# Install perl packages
RUN cpanm --notest App::cpanoutdated \
    Graph GD Bio::Perl \
    CGI CGI::Simple GraphViz XML::Parser::PerlSAX XML::SAX XML::SAX::Writer XML::Simple XML::Twig XML::Writer \
    Bio::FeatureIO Bio::TreeIO \
    File::Which File::Slurp \
    String::Escape Thread::Queue || true && rm -rf ~/.cpanm/work

# Install blast
RUN cd /tmp && wget -N ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.9.0+-1.x86_64.rpm && \
    yum -q -y install ncbi-blast-2.9.0+-1.x86_64.rpm --nogpgcheck && \
    rm ncbi-blast-2.9.0+-1.x86_64.rpm && cd /

# Install lyve-set
RUN wget https://github.com/lskatz/lyve-SET/archive/v1.1.4f.tar.gz && \
    tar xvf v1.1.4f.tar.gz && \
    rm v1.1.4f.tar.gz && \
    mv lyve-SET-1.1.4f lyve-SET && \
    cd lyve-SET && \
    make install && \
    make env && \
    cd ..

# Set scripts and perl paths
ENV PATH=/lyve-SET:/lyve-SET/scripts:$PATH
ENV PERL5LIB=$PERL5LIB:/lyve-SET/lib:$HOME/lib/perl5

# Mount /work and /common
RUN mkdir -p /work /common
