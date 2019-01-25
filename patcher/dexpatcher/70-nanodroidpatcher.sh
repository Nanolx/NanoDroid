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

if [ ! -f /data/adb/nanodroid_patcher/CommonPatcher ]; then
	echo " !! failed to load CommonPatcher"
	exit 1
else
	source "/data/adb/nanodroid_patcher/CommonPatcher"
fi

setup_environment
BASEDIR=/data/adb/nanodroid_patcher
export ANDROID_DATA=${BASEDIR}

NanoDroidPatcher () {
	sleep 5

	ui_print " "
	ui_print "*******************************"
	ui_print "   NanoDroid Framework Patcher   "
	ui_print "     addon.d 20.6.20190125     "
	ui_print "       created by @Nanolx      "
	ui_print " Utilizing DexPatcher @lanchon "
	ui_print "*******************************"
	ui_print " "

	mount_partitions

	[ -f /data/adb/.nanodroid-patcher ] && \
		rm -f /data/adb/.nanodroid-patcher
	[ -f /data/adb/NanoDroid_Patched ] && \
		rm -f /data/adb/NanoDroid_Patched

	for artifact in classes.dex oat dalvik-cache \
		services.jar services.jar-mod; do
		rm -rf ${BASEDIR}/${artifact}
	done

	detect_sdk
	detect_arch

	if search_fake_package_signature; then
		ui_print " ROM has native signature spoofing already!"
		exit 0
	fi

	detect_odex

	[ -f ${MAGISK_IMG} ] && magisk_setup

	patch_services
	install_services

	ui_print " "
	ui_print " >> clean up"

	magisk_cleanup

	ui_print " "
	ui_print " > Done!"
	ui_print " "
	ui_print "Thanks for using NanoDroid"
	ui_print " "

	exit 0
}

##########################################################################################
# Check environment
##########################################################################################

OUTFD=
detect_outfd

if ! test -d /data/adb/nanodroid_patcher ; then
	ui_print " "
	ui_print " !! NanoDroid-Patcher environment missing"
	ui_print " !! guessing, you've wiped /data ?"
	ui_print " !! re-flash the NanoDroid-Patcher zip"
	ui_print " "
	exit 0
fi

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

