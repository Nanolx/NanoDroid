#!/sbin/sh

is_mounted() {
  if [ ! -z "$2" ]; then
    cat /proc/mounts | grep $1 | grep $2, >/dev/null
  else
    cat /proc/mounts | grep $1 >/dev/null
  fi
  return $?
}

mount_image() {
  if [ ! -d "$2" ]; then
    mount -o rw,remount rootfs /
    mkdir -p $2 2>/dev/null
    ($BOOTMODE) && mount -o ro,remount rootfs /
    [ ! -d "$2" ] && return 1
  fi
  if (! is_mounted $2); then
    LOOPDEVICE=
    for LOOP in 0 1 2 3 4 5 6 7; do
      if (! is_mounted $2); then
        LOOPDEVICE=/dev/block/loop$LOOP
        if [ ! -e "$LOOPDEVICE" ]; then
          mknod $LOOPDEVICE b 7 $LOOP
        fi
        losetup $LOOPDEVICE $1
        if [ "$?" -eq "0" ]; then
          mount -t ext4 -o loop $LOOPDEVICE $2
          if (! is_mounted $2); then
            /system/bin/toolbox mount -t ext4 -o loop $LOOPDEVICE $2
          fi
          if (! is_mounted $2); then
            /system/bin/toybox mount -t ext4 -o loop $LOOPDEVICE $2
          fi
        fi
        if (is_mounted $2); then
          echo "$LOOPDEVICE" > /tmp/loopdevice
          break;
        fi
      fi
    done
  fi
}

mount_magisk () {
	mount /data &>/dev/null
	mount_image /data/magisk.img /magisk
}

umount_magisk () {
	if (is_mounted /magisk); then
		umount /magisk
		losetup -d $(cat /tmp/loopdevice)
		rm /tmp/loopdevice
	fi
}

if [[ ${1} == mount-magisk ]]; then
	mount_magisk
elif [[ ${1} == umount-magisk ]]; then
	umount_magisk
elif [[ ${1} == dataperms ]]; then
	chown -R 1000:1000 /data/app
	find /data/app -type f | xargs chmod 0644
	find /data/app -type d | xargs chmod 0771
elif [[ ${1} == mkdir ]]; then
	mkdir /tmp/magisk
	mkdir /tmp/overlay
elif [[ ${1} == rmdir ]]; then
	rm -rf /tmp/magisk
	rm -rf /tmp/overlay
elif [[ ${1} == overlay ]]; then
	if [[ ! -f /data/media/0/.nanomod-overlay ]]; then
		cp /tmp/.nanomod-overlay /data/media/0/.nanomod-overlay
		chown 1000:1000 /data/media/0/.nanomod-overlay
		chmod 0644 /data/media/0/.nanomod-overlay
	fi
elif [[ ${1} == setup ]]; then
	if [[ ! -f /data/media/0/.nanomod-setup ]]; then
		cp /tmp/.nanomod-setup /data/media/0/.nanomod-setup
		chown 1000:1000 /data/media/0/.nanomod-setup
		chmod 0644 /data/media/0/.nanomod-setup
	fi
elif [[ ${1} == backup-servicesjar ]]; then
	mount_magisk
	cp /magisk/NanoMod/system/framework/services.jar \
		/tmp/services.jar
	umount_magisk
elif [[ ${1} == restore-servicesjar ]]; then
	mount_magisk
	cp /tmp/services.jar \
		/magisk/NanoMod/system/framework/services.jar
	umount_magisk
fi
