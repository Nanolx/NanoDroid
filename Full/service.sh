#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}

# Create private Log directory
LOGDIR="${MODDIR}/logs"

[[ ! -d ${LOGDIR} ]] && mkdir -p "${LOGDIR}"

# wait until boot completed
until [ `getprop vold.post_fs_data_done`. = 1. ]; do sleep 1; done

# Set current date in 20170607-12.07.25 format
CURDATE=$(date +%Y%m%d-%H.%M.%S)

# This script will be executed in late_start service mode
# More info in the main Magisk thread
for init in 10_sqlite 20_fstrim 30_logcat 40_external_sd 50_logscleaner; do
	"${MODDIR}/init.d/${init}" | \
		tee -a "${LOGDIR}/${init}.log.${CURDATE}" &
done

# in Magisk Mode microG DroidGuard Helper needs to be installed as user app
pm list packages -f | grep -q /data.*org.microg.gms.droidguard || \
	pm install -r "${MODDIR}/system/app/DroidGuard/DroidGuard.apk" &

# install Magisk Manager if NanoDroid migration was run
[ -f /data/adb/magisk.apk ] && \
	pm install -r /data/adb/magisk.apk ; \
	rm -f /data/adb/magisk.apk &
