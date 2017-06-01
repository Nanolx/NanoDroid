#!/system/bin/sh
# Please don't hardcode /magisk/modname/... ; instead, please use $MODDIR/...
# This will make your scripts compatible even if Magisk change its mount point in the future
MODDIR=${0%/*}

# This script will be executed in post-fs-data mode
# More info in the main Magisk thread
${MODDIR}/system/etc/init.d/fstrim
${MODDIR}/system/etc/init.d/logscleaner
${MODDIR}/system/etc/init.d/sqlite
${MODDIR}/system/etc/init.d/external_sd
