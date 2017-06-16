#!/sbin/sh

APPS="BasicDreams
Browser
Calendar
CMFileManager
Camera2
Eleven
Email
Exchange2
Gallery2
Gello
NexusLauncher
Phonograph
PhotoTable
ResurrectionStats
Slimperience
SoundRecorder
Stk
ViaBrowser
Wallpaper
WallpaperBackup
WallpaperPickerGoogle
messaging"

PRIV_APPS="FMRadio
Gallery2
OmniSwitch
Recorder
PixelLauncher
Screencast
Snap
SnapdragonCamera
SoundRecorder
Trebuchet
mGerrit"

is_mounted() {
	if [ ! -z "$2" ]; then
		cat /proc/mounts | grep $1 | grep $2, >/dev/null
	else
		cat /proc/mounts | grep $1 >/dev/null
	fi
	return $?
}

if (is_mounted /system); then
	mount -orw,remount /system
else	mount -orw /system
fi

for app in ${APPS}; do
	rm -rf /system/app/${app}
done

for app in ${PRIV_APPS}; do
	rm -rf /system/priv-app/${app}
done

umount /system
