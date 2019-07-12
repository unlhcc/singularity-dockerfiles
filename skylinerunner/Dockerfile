FROM proteowizard/pwiz-skyline-i-agree-to-the-vendor-licenses:3.0.19158-354ed2f35

ENV WINEDEBUG=-all,err-all

WORKDIR /
ADD user.reg.patch /
RUN apt-get -y -qq update && apt-get -y -qq install patch && \
    apt-get -y -qq clean && \
    patch -p0 < user.reg.patch && \
    rm -f user.reg.patch
