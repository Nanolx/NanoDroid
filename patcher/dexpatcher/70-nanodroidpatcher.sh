#!/sbin/sh
#
# ADDOND_VERSION=2
#
##########################################################################################
# 
# NanoDroid Patcher survival script
# by Nanolx
# 
# Inspired by 99-flashafterupdate.sh of osm0sis @ xda-developers
# Forked from 99-magisk.sh of topjohnwu @ xda-developers
# 
##########################################################################################

source /tmp/backuptool.functions

OUTFD=
BASEDIR=/system/addon.d/nanodroid_patcher

detect_outfd

NanoDroidPatcher () {
	sleep 5

	show_banner

	mount_partitions

	detect_sdk
	detect_arch

	if check_fake_package_signature; then
		ui_print " ROM has native signature spoofing already!"
		exit 0
	fi

	detect_odex
	patch_services
	install_services

	umount_partitions

	for artifact in classes.dex oat dalvik-cache \
		services.jar services.jar-mod; do
		rm -rf ${BASEDIR}/${artifact}
	done

	ui_print " "
	ui_print " > Done!"
	ui_print " "
	ui_print "Thanks for using NanoDroid"
	ui_print " "

	exit 0
}

##########################################################################################
# Stuffz
##########################################################################################

case "${1}" in
	backup)
		# Stub
	;;
	restore)
		# Stub
	;;
	pre-backup)
		# Stub
	;;
	post-backup)
		# Stub
	;;
	pre-restore)
		# Stub
	;;
	post-restore)
		NanoDroidPatcher
	;;
esac
