#!/sbin/sh
# unSU Script: Recovery Flashable Zip
# osm0sis @ xda-developers

# NanoMod changes:
#
# added find_boot_image() from Magisk
#  by topjohnwu @ xda-developers
# added support for re-flashing boot image
# in case of system less SuperSU

find_boot_image() {
  if [ -z "$BOOTIMAGE" ]; then
    for PARTITION in kern-a KERN-A android_boot ANDROID_BOOT kernel KERNEL boot BOOT lnx LNX; do
      BOOTIMAGE=`readlink /dev/block/by-name/$PARTITION || readlink /dev/block/platform/*/by-name/$PARTITION || readlink /dev/block/platform/*/*/by-name/$PARTITION`
      if [ ! -z "$BOOTIMAGE" ]; then break; fi
    done
  fi
  if [ -z "$BOOTIMAGE" ]; then
    FSTAB="/etc/recovery.fstab"
    [ ! -f "$FSTAB" ] && FSTAB="/etc/recovery.fstab.bak"
    [ -f "$FSTAB" ] && BOOTIMAGE=`grep -E '\b/boot\b' "$FSTAB" | grep -oE '/dev/[a-zA-Z0-9_./-]*'`
  fi
}

flash_orig_boot() {
  mv -f /data/stock_boot_*.gz /data/stock_boot.img.gz 2>/dev/null
  gzip -d /data/stock_boot.img.gz 2>/dev/null
  rm -f /data/stock_boot.img.gz 2>/dev/null

  find_boot_image

  if [ -f /data/stock_boot.img -a ! -z "$BOOTIMAGE" ]; then
    dd if=/data/stock_boot.img of=$BOOTIMAGE bs=4096
    rm -f /data/stock_boot.img;
  fi
}

if [ -e /data/su ]; then
  rm -rf /data/app/me.phh.superuser* /data/data/me.phh.superuser* /data/su;

  flash_orig_boot
fi;

if [ -e /cache/su.img -o -e /data/su.img ]; then
  umount /su;

  flash_orig_boot

  rm -rf /cache/.supersu /cache/su.img /cache/SuperSU.apk /data/.supersu /data/stock_boot_*.img.gz /data/su.img /data/SuperSU.apk /data/app/eu.chainfire.supersu* /data/data/eu.chainfire.supersu*;
fi;

if [ -e /system/bin/.ext/.su ]; then
  mount -o rw,remount /system;

  rm -rf /system/.pin /system/.supersu /system/app/Superuser.apk /system/app/SuperSU /system/bin/.ext /system/bin/app_process_init /system/etc/.installed_su_daemon /system/etc/install-recovery.sh  /system/etc/init.d/99SuperSUDaemon /system/lib/libsupol.so /system/lib64/libsupol.so /system/su.d /system/xbin/daemonsu /system/xbin/su /system/xbin/sugote /system/xbin/sugote-mksh /system/xbin/supolicy /cache/.supersu /data/.supersu /data/app/eu.chainfire.supersu* /data/data/eu.chainfire.supersu*;

  mv -f /system/bin/app_process32_original /system/bin/app_process32;
  mv -f /system/bin/app_process64_original /system/bin/app_process64;
  mv -f /system/bin/install-recovery_original.sh /system/bin/install-recovery.sh;

  cd /system/bin;
  if [ -e app_process64 ]; then
    ln -sf app_process64 app_process;
  else
    ln -sf app_process32 app_process;
  fi;
fi;

if [ -e /system/bin/su -a "$(strings /system/xbin/su | grep koush)" ]; then
  mount -o rw,remount /system;

  rm -rf /system/app/Superuser.apk /system/bin/su /system/etc/.has_su_daemon /system/etc/.installed_su_daemon /system/xbin/su /cache/su /cache/Superuser.apk /cache/install-recovery-sh /data/app/com.koushikdutta.superuser* /data/data/com.koushikdutta.superuser*;
fi;

# from NanoMod < 3.1
mount -o rw,remount /system;
rm -rf /system/app/SuperUser;

if [ -e /system/bin/su -o -e /system/xbin/su ]; then
  mount -o rw,remount /system;

  rm -rf /system/bin/su /system/xbin/su;
fi;
exit 0;

