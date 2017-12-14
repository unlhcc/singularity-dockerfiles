# use the publicly available ndmg image
FROM neurodata/ndmg

# to avoid libGL error
RUN apt-get install -y libgl1-mesa-glx libgl1-mesa-dri xserver-xorg-core

# mount work
RUN mkdir -p /work
