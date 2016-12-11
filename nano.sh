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
        if [ ! -f "$LOOPDEVICE" ]; then
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
          ui_print "- Mounting $1 to $2"
          break;
        fi
      fi
    done
  fi
}

if [[ ${1} == mount-magisk ]]; then
	mount_image /data/magisk.img /magisk
elif [[ ${1} == umount-magisk ]]; then
	if (is_mounted /magisk); then
		umount /magisk
		losetup -d $(cat /tmp/loopdevice)
		rm /tmp/loopdevice
	fi
	losetup -d /dev/block/loop0
elif [[ ${1} == dataperms ]]; then
	chown -R 1000:1000 /data/app
	find /data/app -type f | xargs chmod 0644
	find /data/app -type d | xargs chmod 0771
elif [[ ${1} == mkdir ]]; then
	mkdir /tmp/magisk
	mkdir /tmp/phh
	mkdir /tmp/nano-init
	mkdir /tmp/nano-miitomo
	mkdir /tmp/optimus
	mkdir /tmp/bash
elif [[ ${1} == rmdir ]]; then
	rm -rf /tmp/magisk
	rm -rf /tmp/phh
	rm -rf /tmp/nano-init
	rm -rf /tmp/nano-miitomo
	rm -rf /tmp/optimus
	rm -rf /tmp/bash
fi
