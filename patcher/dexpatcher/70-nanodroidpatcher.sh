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

source /tmp/backuptool.functions || source /postinstall/tmp/backuptool.functions

OUTFD=
BASEDIR=/system/addon.d/nanodroid_patcher

detect_outfd () {
	# taken from Magisk
	# update-binary|updater <RECOVERY_API_VERSION> <OUTFD> <ZIPFILE>
	OUTFD=$(ps | grep -v 'grep' | grep -oE 'update(.*) 3 [0-9]+' | cut -d" " -f3)
	[ -z $OUTFD ] && OUTFD=$(ps -Af | grep -v 'grep' | grep -oE 'update(.*) 3 [0-9]+' | cut -d" " -f3)
	# update_engine_sideload --payload=file://<ZIPFILE> --offset=<OFFSET> --headers=<HEADERS> --status_fd=<OUTFD>
	[ -z $OUTFD ] && OUTFD=$(ps | grep -v 'grep' | grep -oE 'status_fd=[0-9]+' | cut -d= -f2)
	[ -z $OUTFD ] && OUTFD=$(ps -Af | grep -v 'grep' | grep -oE 'status_fd=[0-9]+' | cut -d= -f2)
}

NanoDroidPatcher () {
	detect_outfd

	show_banner
	detect_sdk
	detect_arch

	if check_fake_package_signature; then
		ui_print " ROM has native signature spoofing already!"
		exit 0
	fi

	detect_odex
	patch_services
	install_services

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
