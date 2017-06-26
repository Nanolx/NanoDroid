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
Jelly
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
mGerrit"

is_mounted() {
	if [ ! -z "$2" ]; then
		cat /proc/mounts | grep $1 | grep $2, >/dev/null
	else
		cat /proc/mounts | grep $1 >/dev/null
	fi
	return $?
}

debloat_system () {
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
}

error () {
	echo "${@}"
	exit 1
}


[[ ! -d /twres ]] && error "Not running from TWRP, exiting"
is_mounted /data || mount /data
[[ -f /data/magisk.img ]] && error "Magisk is installed, exiting"

echo "NanoMod force-debloat script

This script will actually remove apps from

	/system/app
	/system/priv-app

Are you sure you want to proceed?

Enter [y] / [j]
"

read -r USER_INPUT

case ${USER_INPUT} in
	y | Y | j | J )
		debloat_system
	;;

	"" )
		error "No user input, exiting"
	;;

	* )
		error "Unknown user input, exiting"
	;;
esac
