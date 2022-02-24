#!/bin/bash
# Raspbian Quake1 installer
# https://github.com/froschgrosch/raspberrypi-stuff

TARGETDIR="/home/pi/quake1"
SOURCEDIR="/tmp/qurp-source"

# install required
apt-get update -y || exit 1
apt-get install git gcc build-essential libsdl2-dev libudev-dev -y || exit 1

# download qurp


git clone https://github.com/lasthopegf/qurp.git

# build
cd qurp/WinQuake
./build.sh release_gl 


copy releasearm/bin/glquake ${TARGETDIR}/glquake

rm -r ${SOURCEDIR}

chown pi ${TARGETDIR} -R
