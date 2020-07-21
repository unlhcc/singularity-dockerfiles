FROM ubuntu:16.04

# Install needed libraries
RUN apt-get update && \
    apt-get install -y -q libgstreamer0.10-0 libgstreamer-plugins-base0.10-dev libxss-dev \
    libxmu-dev libxi-dev libmpich-dev wget libgl1-mesa-glx firefox libopenblas-base libnss3 > /dev/null && \
    apt-get clean

# iepx6zunmzug1wuhn6jl6i7dz97pmoc9.deb == oneD solver
# 27983cu5ce4az4fc6dykfyt5kur3nf93.deb == SimVascular
# ha287gny45qq6ao4se61j0prnznglgkg.deb == svsolver
# 7x0yxoy58jwwcwae3082h1pd1btux7pq.deb == svFSI
RUN wget -q https://unl.box.com/shared/static/27983cu5ce4az4fc6dykfyt5kur3nf93.deb && \
    wget -q https://unl.box.com/shared/static/iepx6zunmzug1wuhn6jl6i7dz97pmoc9.deb && \
    wget -q https://unl.box.com/shared/static/ha287gny45qq6ao4se61j0prnznglgkg.deb && \
    wget -q https://unl.box.com/shared/static/7x0yxoy58jwwcwae3082h1pd1btux7pq.deb && \
    apt install ./27983cu5ce4az4fc6dykfyt5kur3nf93.deb ./iepx6zunmzug1wuhn6jl6i7dz97pmoc9.deb \
    ./ha287gny45qq6ao4se61j0prnznglgkg.deb ./7x0yxoy58jwwcwae3082h1pd1btux7pq.deb && \
    rm -f 27983cu5ce4az4fc6dykfyt5kur3nf93.deb iepx6zunmzug1wuhn6jl6i7dz97pmoc9.deb \
    ha287gny45qq6ao4se61j0prnznglgkg.deb 7x0yxoy58jwwcwae3082h1pd1btux7pq.deb && \
    bash /usr/local/sv/simvascular/2020-06-29/setup-symlinks.sh && \
    bash /usr/local/sv/svsolver/2019-02-07/setup-symlinks.sh && \
    bash /usr/local/sv/svFSI/2020-02-03/setup-symlinks.sh && \
    ln -s /usr/local/sv/oneDSolver/2019-07-11/bin/OneDSolver /usr/local/bin/OneDSolver
