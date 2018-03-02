#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}

# in Magisk Mode microG DroidGuard Helper needs to be installed as user app
sleep 30 && pm list packages -f | grep -q /data.*org.microg.gms.droidguard || \
	pm install -r "${MODDIR}/system/priv-app/DroidGuard/DroidGuard.apk" &
