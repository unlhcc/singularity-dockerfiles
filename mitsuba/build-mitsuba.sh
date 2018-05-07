#!/bin/bash

MITSUBA_VER=af602c6fd98a
MITSUBA_DEST=/usr/local/mitsuba

cd /tmp

# Download
curl -sS -O https://www.mitsuba-renderer.org/repos/mitsuba/archive/${MITSUBA_VER}.zip

# Extract
unzip -q ${MITSUBA_VER}.zip
rm ${MITSUBA_VER}.zip
mv mitsuba-${MITSUBA_VER} mitsuba
cd mitsuba

# Configure
cp build/config-linux-gcc.py config.py

# Add rpath
echo "LINKFLAGS.append('-Wl,-rpath=${MITSUBA_DEST}')" >> config.py

scons --quiet -j$(nproc)

# Strip binaries
find dist -executable -type f -exec strip {} +

# Install
cp -a dist /usr/local/mitsuba
ln -s /usr/local/mitsuba/mitsuba -t /usr/local/bin
ln -s /usr/local/mitsuba/mtssrv  -t /usr/local/bin
ln -s /usr/local/mitsuba/mtsutil -t /usr/local/bin

# Cleanup
rm -rf /tmp/mitsuba
