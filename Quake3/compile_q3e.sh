#!/bin/bash
# Raspbian Quake3e compile help script

TARGETDIR="/home/pi/quake3e"
SOURCEDIR="/tmp/quake3e-source"

# install required packages
#apt update -y || exit 1
apt install wget gcc build-essential libxxf86dga-dev libcurl4-openssl-dev -y || exit 1

# clone source code
mkdir ${SOURCEDIR} || exit 1
cd ${SOURCEDIR} 

# git isn't working for now, might fix in later revision
wget https://github.com/ec-/Quake3e/archive/refs/tags/latest.tar.gz
tar -zxvf latest.tar.gz
rm latest.tar.gz

# create target directory
mkdir ${TARGETDIR}/ || exit 1
mkdir ${TARGETDIR}/baseq3 
#mkdir ${TARGETDIR}/missionpack

cd Quake3e-latest

make -j4 USE_VULKAN=0

cp build/release-linux-arm/quake3e.arm ${TARGETDIR}/quake3e.arm
cp build/release-linux-arm/quake3e.ded.arm ${TARGETDIR}/quake3e.ded.arm
cp build/release-linux-arm/quake3e_opengl_arm.so ${TARGETDIR}/quake3e_opengl_arm.so
cp build/release-linux-arm/quake3e_opengl_arm.so ${TARGETDIR}/quake3e_vulkan_arm.so

#rm -f -r ${SOURCEDIR}

cd ${TARGETDIR}

chmod +x quake3e.arm
chmod +x quake3e.ded.arm

# add game key
echo "2222222222222222" > baseq3/q3key

# change the owner to pi so that you can add and remove files
chown pi ${TARGETDIR} -R

exit 0
