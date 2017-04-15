#!/sbin/sh

BASEDIR="/tmp/dexpatcher"
SDK_VERSION=$(getprop ro.build.version.sdk)
PATCH_CORE="core_services.jar.dex"
ABI=$(getprop ro.product.cpu.abi)

error () {
	echo "${@}"
	exit 1
}

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

apply_patch () {

	if [ ${SDK_VERSION} -gt 21 ]; then
		mkdir -p "${1}"
	fi

	LD_LIBRARY_PATH="/system/lib:/system/lib64" \
		dalvikvm -cp "/tmp/dexpatcher/dexpatcher.dex" \
		lanchon.dexpatcher.Main \
		"${DEX_OPTS}" --api-level "${SDK_VERSION}" \
		--verbose --output "${1}" "${2}" "${3}"

	/system/xbin/zip -d "${2}" 'classes*.dex'
	/system/xbin/zip -j "${2}" "${1}"/classes*.dex

	rm -rf "${1}"

}

if [ ${SDK_VERSION} -gt 25 ]; then
	echo "Android versions beyond Nougat are not yet supported"
	exit 1
elif [ ${SDK_VERSION} -lt 24 ]; then
	PATCH_HOOK="hook_4.1-6.0_services.jar.dex"
else	PATCH_HOOK="hook_7.x_services.jar.dex"
fi

if [ ${SDK_VERSION} -gt 21 ]; then
	DEX_OPTS="--multi-dex"
fi

if ! (is_mounted /system); then
	mount -oro /system
fi

if ! (is_mounted /data); then
	mount -orw /data
fi

if [ -f /data/magisk.img ]; then
	mount_image /data/magisk.img /magisk
fi

cp /system/framework/services.jar \
	/tmp/services.jar || \
	error "failed to copy services.jar"

apply_patch /tmp/services.jar-hook \
	/tmp/services.jar \
	"${BASEDIR}/${PATCH_HOOK}" || \
	error "failed to patch services.jar with ${PATCH_HOOK}"

apply_patch /tmp/services.jar-hook-core \
	/tmp/services.jar \
	"${BASEDIR}/${PATCH_CORE}" || \
	error "failed to patch services.jar with ${PATCH_CORE}"

if [ -d /magisk/NanoMod ]; then
	echo "installing services.jar into NanoMod (full)"
	mkdir -p /magisk/NanoMod/system/framework/
	cp /tmp/services.jar \
		/magisk/NanoMod/system/framework/services.jar || \
		error "failed to install services.jar into NanoMod (full)"
	chown 1000:1000 /magisk/NanoMod/system/framework/services.jar
	chmod 0644 /magisk/NanoMod/system/framework/services.jar
elif [ -d /magisk/NanoModmicroG ]; then
	echo "installing services.jar into NanoMod (microG)"
	mkdir -p /magisk/NanoModmicroG/system/framework/
	cp /tmp/services.jar \
		/magisk/NanoModmicroG/system/framework//services.jar || \
		error "failed to install services.jar into NanoMod (microG)"
	chown 1000:1000 /magisk/NanoModmicroG/system/framework/services.jar
	chmod 0644 /magisk/NanoModmicroG/system/framework/services.jar
else
	echo "installing services.jar into ROM :/"
	mount -orw,remount /system >/dev/null
	cp /tmp/services.jar \
		/system/framework//services.jar || \
		error "failed to install services.jar into ROM"
	chown 1000:1000 /system/framework/services.jar
	chmod 0644 /system/framework/services.jar
fi

if (is_mounted /magisk); then
	umount /magisk
	losetup -d $(cat /tmp/loopdevice)
	rm /tmp/loopdevice
fi

mount -oro,remount /system >/dev/null

rm /tmp/services.jar

