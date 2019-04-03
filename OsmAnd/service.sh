#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}

# wait until boot completed
until [ `getprop sys.boot_completed`. = 1. ]; do sleep 1; done

# install Magisk Manager if NanoDroid migration was run
[ -f /data/adb/magisk.apk ] && \
	pm install -r /data/adb/magisk.apk ; \
	rm -f /data/adb/magisk.apk &
