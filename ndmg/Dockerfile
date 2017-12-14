# use the publicly available ndmg image
FROM neurodata/ndmg

# to avoid libGL error
#RUN apt-get install -y libgl1-mesa-glx

ENV LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu/mesa:$LD_LIBRARY_PATH

ADD environment /environment
ADD docker_environment /docker_environment

# mount work
RUN mkdir -p /work
