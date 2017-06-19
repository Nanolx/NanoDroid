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
		mkdir -p "$2" 2>/dev/null
		[ ! -d "$2" ] && return 1
	fi

	if ! is_mounted "$2"; then
		LOOPDEVICE=
		for LOOP in 0 1 2 3 4 5 6 7; do
			if ! is_mounted "$2"; then
				LOOPDEVICE=/dev/block/loop$LOOP
				[ -e $LOOPDEVICE ] || mknod $LOOPDEVICE b 7 $LOOP 2>/dev/null
				losetup $LOOPDEVICE "$1" && mount -t ext4 -o loop $LOOPDEVICE "$2"
				if is_mounted "$2"; then
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
	umount /magisk
	losetup -d $(cat /tmp/loopdevice)
	rm /tmp/loopdevice
}

if (is_mounted /magisk); then
	umount_magisk
else	mount_magisk
fi
