# Build APSim Classic
# Adapted from https://github.com/APSIMInitiative/APSIMClassic/tree/master/Release/Containers/Docker.ubuntu.latest

FROM ubuntu:16.04

# Download and configure the build environment
RUN apt-get update && apt-get -y -q install g++ gfortran libxml2-dev tcl8.5 tcl8.5-dev tcllib subversion p7zip p7zip-full git wget \
    apt-transport-https ca-certificates software-properties-common dirmngr > /dev/null 2>&1

RUN gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-key E084DAB9; \
	gpg -a --export E084DAB9 | apt-key add -; \
	gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-key A6A19B38D3D831EF; \
	gpg -a --export A6A19B38D3D831EF | apt-key add -; \
        gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-key 51716619E084DAB9; \
        gpg -a --export 51716619E084DAB9 | apt-key add -

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
RUN echo "deb http://download.mono-project.com/repo/debian  wheezy/snapshots/4.8.1 main" > /etc/apt/sources.list.d/mono.list
RUN add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu xenial/'

RUN apt-get update && apt-get -y -q install \
	mono-devel \
	mono-vbnc \
	mono-runtime \
	r-base \
	r-base-dev \
	r-recommended > /dev/null 2>&1

RUN Rscript -e "install.packages(c(\"Rcpp\",\"RInside\", \"XML\"), repos =\"https://rweb.crmda.ku.edu/cran/\")"

ADD apsim.patch /usr/local/src
ADD BuildApsim.sh usr/local/bin
RUN chmod +x usr/local/bin/BuildApsim.sh
RUN BuildApsim.sh 62e0f2e 7 9
