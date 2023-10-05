FROM codercom/code-server:4.17.1-bullseye

USER root
RUN apt-get update && \
    apt-get install -y default-jdk tk8.6 lua5.3 lua-filesystem lua-posix lua-term lua-json ssh

# Workaround for different Ubuntu/EL lua install paths
RUN mkdir -p /usr/lib64 && ln -s /usr/lib/x86_64-linux-gnu/lua /usr/lib64/lua
RUN ln -s /usr/bin/logger /bin/logger

ADD profile.d /etc/profile.d
COPY profile /etc/profile
