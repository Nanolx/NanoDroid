#!/bin/bash

# this script pushes updates from NanoMod to
# NanoROM for Galaxy S6. Users won't need it.

NM=/storage/projects/NanoMod
NR=/android/NanoROM/ROM/nano

# microG
cp -r ${NM}/microG ${NR}/
rm -rf ${NR}/microG/priv-app/GmsCore/lib/arm

# PlaySstore
cp -r ${NM}/PlayStore ${NR}/system/

# Apps
for app in AdAway Amaze FaceSlim FDroid K9Mail Lightning \
	NewPipe QKSMS Twidere; do
	cp -r ${NM}/system/app/${app} \
		${NR}/apps/
done

cp -r ${NM}/system/app/OpenCamera ${NR}/alt/Camera/fdroid/
cp -r ${NM}/system/app/LeafPic ${NR}/alt/Gallery/LeafPic/app/
cp -r ${NM}/system/app/HackerKeyboard/HackerKeyboard.apk \
	${NR}/alt/Keyboard/HackersKeyboard/app/HackersKeyboard/HackersKeyboard.apk
cp -r ${NM}/system/app/KernelAdiutor \
	${NR}/system/kernel/adiutor/app/
cp -r ${NM}/system/app/SuperUser/ \
	${NR}/system/supersu/app/

# UserApps
cp -r ${NM}/userapps/{com.termux,com.xda.labs} \
	${NR}/apps/
rm -rf ${NR}/apps/{com.termux,com.xda.labs}/lib/arm
cp -r ${NM}/userapps/org.videolan.vlc-arm64/* \
	${NR}/apps/org.videolan.vlc/

# Magisk
cp -r ${NM}/Magisk.zip ${NR}/system/magisk/magisk.zip
cp -r ${NM}/system/app/MagiskManager \
	${NR}/system/magisk/app/
