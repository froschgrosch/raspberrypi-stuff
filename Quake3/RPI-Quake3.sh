#!/bin/bash
# Raspbian Quake3 installer by github:froschgrosch
# Set keyboard layout to en/us or otherwise console won't open.

TARGETDIR="/home/pi/ioquake3"
SOURCEDIR="/tmp/ioquake3-source"

# install required
apt-get update -y || exit 1
apt-get install git gcc build-essential libsdl1.2-dev -y || exit 1

# clone source code
mkdir ${SOURCEDIR} || exit 1
cd ${SOURCEDIR} 
git clone https://github.com/raspberrypi/quake3.git || exit 1
cd quake3

# create target directory
mkdir ${TARGETDIR}/ || exit 1
mkdir ${TARGETDIR}/baseq3 
mkdir ${TARGETDIR}/missionpack
mkdir ${TARGETDIR}/lib 

# compile
sh build_rpi_raspbian.sh || exit 1

# move compiled engine
cd build/release-linux-arm 
mv ioquake3.arm ${TARGETDIR}/ioquake3.arm
mv ioq3ded.arm ${TARGETDIR}/ioq3ded.arm

mv baseq3/*.so ${TARGETDIR}/baseq3/
mv missionpack/*.so ${TARGETDIR}/missionpack/

cd ../../lib/ 
mv libSDL.so ${TARGETDIR}/lib/libSDL.so
mv libSDL-1.2.so.0 ${TARGETDIR}/lib/libSDL-1.2.so.0
mv libSDL-1.2.so.0.11.3 ${TARGETDIR}/lib/libSDL-1.2.so.0.11.3

# delete the source code
rm -r ${SOURCEDIR}

# add game key
echo "2222222222222222" > ${TARGETDIR}/baseq3/q3key

# required to run as non-root (requires restart)
usermod -a -G video pi

# change the owner to pi so that you can add and remove files
chown pi ${TARGETDIR} -R

exit 0