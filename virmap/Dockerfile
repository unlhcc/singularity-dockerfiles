# Download base image Ubuntu
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Dockerfile is based on https://github.com/cmmr/virmap/blob/master/virmapInstall.pl

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends build-essential git \
    time bash wget make vim curl perl cpanminus apt-utils coreutils patch file tclx gnulib \
    zstd libzstd-dev liblz4-dev libsnappy-dev zlib1g-dev libbz2-dev libdb-dev \
    lbzip2 lftp parallel openjdk-8-jdk-headless pigz python3 python3-pip awscli nvme-cli libssl-dev python2

# Install pip2, needed for khmer
RUN cd /tmp && curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py && \
    python2 get-pip.py

# Install required perl packages
RUN export PERL_MM_USE_DEFAULT=1 && \
    cpan CPAN && \
    cpan App::cpanminus && \
    cpanm App::cpanoutdated && \
    cpan-outdated -p | cpanm && \
    cpanm Compress::Zstd && \
    cpanm REST::Client && \
    cpanm OpenSourceOrg::API && \
    cpanm POSIX::1003::Sysconf && \
    cpanm Sereal && \
    cpanm Text::Levenshtein::Damerau::XS && \
    cpanm Text::Levenshtein::XS && \
    cpanm Array::Shuffle && \
    cpanm Array::Split && \
    cpanm Sys::MemInfo && \
    cpanm XML::Hash::XS && \
    cpanm Cpanel::JSON::XS && \
    cpanm Statistics::Basic

# Install other software
RUN cd /tmp && wget https://www.cpan.org/src/5.0/perl-5.30.2.tar.gz -O perl-5.30.2.tar.gz && \
    tar zxvf perl-5.30.2.tar.gz && \
    cd perl-5.30.2 && \
    ./Configure -Dcc=gcc -Dusethreads -Duselargefiles -Dusemorebits -des && \
    make -j32 && \
    make install

ADD make_db.patch /tmp
ADD memory.patch /tmp
RUN cd /tmp && mkdir -p /usr/local/virmap/src && \
    git clone https://github.com/cmmr/virmap.git /usr/local/virmap/src/virmap && \
    cp /tmp/make_db.patch /usr/local/virmap/src/virmap && \
    cp /tmp/memory.patch /usr/local/virmap/src/virmap && \
    patch /usr/local/virmap/src/virmap/DatabaseConstructor/makeVirmapDb.pl -i /usr/local/virmap/src/virmap/make_db.patch && \
    patch /usr/local/virmap/src/virmap/Virmap.pl -i /usr/local/virmap/src/virmap/memory.patch && \
    ls /usr/local/virmap/src/virmap/DatabaseConstructor/*.pl | xargs -I {} ln -s {} /usr/local/bin/ && \
    ls /usr/local/virmap/src/virmap/*.pl | xargs -I {} ln -s {} /usr/local/bin/ && \
    wget http://korflab.ucdavis.edu/Unix_and_Perl/FAlite.pm -O /usr/local/lib/perl5/site_perl/5.30.2/FAlite.pm

RUN cd /tmp && wget https://github.com/bbuchfink/diamond/releases/download/v0.9.32/diamond-linux64.tar.gz -O diamond-linux64.tar.gz && \
    tar zxvf diamond-linux64.tar.gz -C /usr/local/bin/ && \
    tar zxvf /usr/local/virmap/src/virmap/Installer/BBMap_38.84.tar.gz -C /usr/local/virmap/src/ && \
    cd /usr/local/virmap/src/bbmap/jni && make -f makefile.linux && \
    cp /usr/local/virmap/src/bbmap/jni/libbbtoolsjni.so  /usr/lib/ && \
    ls /usr/local/virmap/src/bbmap/*.sh | xargs -I {} ln -s {} /usr/local/bin/ && \
    pip2 install wheel && \
    pip2 install khmer

RUN cd /tmp && wget https://github.com/torognes/vsearch/releases/download/v2.14.2/vsearch-2.14.2-linux-x86_64.tar.gz -O vsearch-2.14.2-linux-x86_64.tar.gz && \
    tar zxvf vsearch-2.14.2-linux-x86_64.tar.gz -C /usr/local/virmap/src/ && \
    ln -s /usr/local/virmap/src/vsearch-2.14.2-linux-x86_64/bin/vsearch /usr/local/bin/ && \
    wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.10.0/ncbi-blast-2.10.0+-x64-linux.tar.gz -O ncbi-blast-2.10.0+-x64-linux.tar.gz && \
    tar zxvf ncbi-blast-2.10.0+-x64-linux.tar.gz -C /usr/local/virmap/src/ && \
    ls /usr/local/virmap/src/ncbi-blast-2.10.0+/bin/* | xargs -I {} ln -s {} /usr/local/bin/

RUN cd /tmp && wget https://github.com/voutcn/megahit/releases/download/v1.1.4/megahit_v1.1.4_LINUX_CPUONLY_x86_64-bin.tar.gz -O megahit_v1.1.4_LINUX_CPUONLY_x86_64-bin.tar.gz && \
    tar zxvf megahit_v1.1.4_LINUX_CPUONLY_x86_64-bin.tar.gz -C /usr/local/virmap/src/ && \
    ls /usr/local/virmap/src/megahit_v1.1.4_LINUX_CPUONLY_x86_64-bin/megahit* | xargs -I {} ln -s {} /usr/local/bin/ && \
    wget https://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.10.6/setup-apt.sh -O setup-apt.sh && \
    chmod +x setup-apt.sh && ./setup-apt.sh

RUN cd /tmp && wget http://www.cpan.org/authors/id/J/JI/JIRO/RocksDB-0.05.tar.gz -O RocksDB-0.05.tar.gz && \
    tar zxvf RocksDB-0.05.tar.gz && \
    patch RocksDB-0.05/builder/MyBuilder.pm -i /usr/local/virmap/src/virmap/Installer/MyBuilder.pm.patch && \
    cd RocksDB-0.05/ && \
    export CXXFLAGS="-Wno-error=deprecated-copy -Wno-error=redundant-move -Wno-error=sign-compare -Wno-error=pessimizing-move" && \
    export PERL5LIB=/usr/share/perl5/:/usr/local/share/perl/5.30.0/:$PERL5LIB && \
    perl Build.PL && perl Build install

# Set variables
ENV PERL_MM_USE_DEFAULT=1 \
    PATH=/usr/local/bin:/usr/lib/jvm/java-8-openjdk-amd64/bin:/usr/local/ncbi/sra-tools/bin:$PATH \
    TMPDIR=/scratch/tmp \
    JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 \
    PERL5LIB=/usr/local/lib/x86_64-linux-gnu/perl/5.30.0/:/usr/local/share/perl/5.30.0/:/usr/share/perl5/:/usr/local/lib/perl5/site_perl/5.30.2/x86_64-linux-thread-multi-ld/:$PERL5LIB \
    LANG="en_US.UTF-8" \
    LC_ALL="C.UTF-8"
