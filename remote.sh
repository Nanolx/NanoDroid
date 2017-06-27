#!/sbin/sh

is_mounted() {
	if [ ! -z "$2" ]; then
		cat /proc/mounts | grep $1 | grep $2, >/dev/null
	else
		cat /proc/mounts | grep $1 >/dev/null
	fi
	return $?
}

request_size_check() {
	reqSizeM=`unzip -l "$1" 2>/dev/null | tail -n 1 | awk '{ print $1 }'`
	reqSizeM=$((reqSizeM / 1048576 + 1))
}

image_size_check() {
	e2fsck -yf $1
	curBlocks=`e2fsck -n $1 2>/dev/null | grep $1 | cut -d, -f3 | cut -d\  -f2`;
	curUsedM=`echo "$curBlocks" | cut -d/ -f1`
	curSizeM=`echo "$curBlocks" | cut -d/ -f1`
	curFreeM=$(((curSizeM - curUsedM) * 4 / 1024))
	curUsedM=$((curUsedM * 4 / 1024 + 1))
	curSizeM=$((curSizeM * 4 / 1024))
}

grow_magisk_img () {
	request_size_check /tmp/services.jar
	image_size_check /data/magisk.img
	if [ "$reqSizeM" -gt "$curFreeM" ]; then
		SIZE=$(((reqSizeM + curUsedM) / 32 * 32 + 64))
		resize2fs /data/magisk.img ${SIZE}M
	fi
}

shrink_magisk_img () {
	image_size_check /data/magisk.img
	NEWDATASIZE=$((curUsedM / 32 * 32 + 32))
	if [ "$curSizeM" -gt "$NEWDATASIZE" ]; then
		resize2fs $IMG ${NEWDATASIZE}M
	fi
}

mount_image() {
	if [ ! -d "$2" ]; then
		mount -o rw,remount rootfs /
		mkdir -p "$2" 2>/dev/null
		$BOOTMODE && mount -o ro,remount rootfs /
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

echo ""

if [[ ! -d /twres ]]; then
	echo "Not running in TWRP, exiting"
	exit 1
fi

if [[ -f /data/magisk.img ]]; then
	grow_magisk_img
	echo "magisk found: mount to /magisk"
	mount_magisk
fi

if [[ -f /system/.nanomod-patcher ]]; then
	echo " ++ /system/.nanomod-patcher exists"
	echo " ++ assuming ROM is already patched"
	exit 0
fi

install_path=""

if [[ -d /magisk/NanoMod ]]; then
	echo "NanoMod detected"
	install_path="/magisk/NanoMod/system/framework"
	mkdir -p "${install_path}"
elif [[ -d /magisk/NanoModmicroG ]]; then
	echo "NanoMod microG detected"
	install_path="/magisk/NanoModmicroG/system/framework"
	mkdir -p "${install_path}"
else
	echo "backing up services.jar to /sdcard"
	cp /tmp/services.jar /sdcard

	echo "using ROM as destination"
	install_path="/system/framework"
fi

echo "install to \"${install_path}\""
cp /tmp/services.jar "${install_path}/" || exit 1

touch /system/.nanomod-patcher

if (is_mounted /magisk); then
	echo "unmount /magisk"
	umount_magisk
	shrink_magisk_img
fi

echo "unmount /system"
umount /system
