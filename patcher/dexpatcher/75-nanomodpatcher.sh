#!/sbin/sh
##########################################################################################
# 
# NanoMod Patcher survival script
# by Nanolx
# 
# Inspired by 99-flashafterupdate.sh of osm0sis @ xda-developers
# Forked from 99-magisk.sh of topjohnwu @ xda-developers
# 
##########################################################################################

. /tmp/backuptool.functions

# This script always run in recovery
BOOTMODE=false
SYSPATH=/system

# This path should work in any cases
BASEDIR=/data/nanomod.patcher
ANDROID_DATA="${BASEDIR}"
PATH="$PATH:/system/bin:/system/xbin"
PATCH_CORE="core_services.jar.dex"

# remove our own, temporary dalvik-cache
rm -rf "${BASEDIR}/dalvik-cache"

##########################################################################################
# Generic Functions
##########################################################################################

ui_print () {
	echo -n -e "ui_print $1\n" >> /proc/self/fd/$OUTFD
	echo -n -e "ui_print\n" >> /proc/self/fd/$OUTFD
}

is_mounted () {
	if [ ! -z "$2" ]; then
		cat /proc/mounts | grep $1 | grep $2, >/dev/null
	else
		cat /proc/mounts | grep $1 >/dev/null
	fi
	return $?
}

error () {
	ui_print "${@}"
	if [ "${MODE}" = "MAGISK" ]; then
		magisk_cleanup
	fi
	exit 1
}


grep_prop() {
	shift
	FILES=$@
	if [ -z "$FILES" ]; then
		FILES='/system/build.prop'
	fi
	cat $FILES 2>/dev/null | sed -n "s/^$1=//p" | head -n 1
}

detect_odex () {
	if [ -n "$(find '/system/app/' -name '*.odex')" ]; then
		error " !! odexed ROMs are not supported"
	fi
}

detect_dalvik () {
	if [[ ! -f /system/bin/dalvikvm ]]; then
		error "!! /system/bin/dalvikvm does not exist"
	else	DALVIK_ARCH=$("${FILE}" -m "${BASEDIR}/magic.mgc" -L /system/bin/dalvikvm)
	fi

	case ${DALVIK_ARCH} in
		*32-bit* )
			DP_LD="/system/lib:/system/vendor/lib:$LD_LIBRARY_PATH"
			ui_print " > DalvikVM bitness: 32-bit"
		;;
		*64-bit* )
			DP_LD="/system/lib64:/system/vendor/lib64:$LD_LIBRARY_PATH"
			ui_print " > DalvikVM bitness: 64-bit"
		;;
		* )
			error " !! could not detect dalvikvm architecture"
		;;
	esac
}

detect_arch () {
	ABI=$(getprop ro.product.cpu.abi | cut -c-3)
	ABI2=$(getprop ro.product.cpu.abi2 | cut -c-3)
	ABILONG=`grep_prop ro.product.cpu.abi`

	ARCH=arm
	IS64BIT=false

	if [ "$ABI" = "x86" ]; then
		ARCH=x86
	fi

	if [ "$ABI2" = "x86" ]; then
		ARCH=x86
	fi

	if [ "$ABILONG" = "arm64-v8a" ]; then
		ARCH=arm64
	fi

	if [ "$ABILONG" = "x86_64" ]; then
		ARCH=x86_64
	fi

	case ${ARCH} in
		arm | arm64 )
				FILE=${BASEDIR}/file.arm
				ZIPB=${BASEDIR}/zip.arm
		;;
		x86 | x86_64 )
				FILE=${BASEDIR}/file.x86
				ZIPB=${BASEDIR}/zip.x86
		;;
	esac

	ui_print " > device architecture: ${ARCH}"
}

detect_sdk () {
	SDK_VERSION=$(awk -F= '/^ro.build.version.sdk/{print $2}' /system/build.prop)

	if [ "${SDK_VERSION}" -gt 25 ]; then
		error " !! Android versions beyond Nougat are not yet supported"
	fi

	if [ "${SDK_VERSION}" -lt 16 ]; then
		error " !! Android versions before Jelly Bean are not supported"
	fi

	if [ "${SDK_VERSION}" -lt 24 ]; then
		ui_print " > Android 4.1 - 6.0 (SDK ${SDK_VERSION}) detected"
		PATCH_HOOK="hook_4.1-6.0_services.jar.dex"
		PATCH_UI_SERVICES="ui_4.1-6.0_services.jar.dex"
		PATCH_UI_SETTINGS="ui_4.1-6.0_Settings.apk.dex"
	else
		ui_print " > Android 7.x (SDK ${SDK_VERSION}) detected"
		PATCH_HOOK="hook_7.x_services.jar.dex"
		PATCH_UI_SERVICES="ui_7.x_services.jar.dex"
		PATCH_UI_SETTINGS="ui_7.x_Settings.apk.dex"
	fi

	if [ "${SDK_VERSION}" -gt 21 ]; then
		DEX_OPTS="--multi-dex-threaded"
	fi
}

##########################################################################################
# Patcher Functions
##########################################################################################

dalvik_cache () {
	ui_print " "
	ui_print " > creating dalvik-cache"
	ui_print " "
	ui_print " << this might take a bit!"

	for jar in /system/framework/*.jar ; do
		BOOTCLASSES=${BOOTCLASSES}:${jar}
	done

	LD_LIBRARY_PATH="${DP_LD}" \
		/system/bin/dalvikvm \
			-Xbootclasspath:"${BOOTCLASSES}" \
			--help 2>/dev/null
}

apply_patch () {
	if [ "${SDK_VERSION}" -gt 21 ]; then
		mkdir -p "${1}"
	fi

	LD_LIBRARY_PATH="${DP_LD}" \
		/system/bin/dalvikvm \
			-Xbootclasspath:"${BOOTCLASSES}" \
			-classpath "${BASEDIR}/dexpatcher.dex" \
			lanchon.dexpatcher.Main \
			${DEX_OPTS} --api-level "${SDK_VERSION}" \
			--verbose --output "${1}" "${2}" "${3}" || \
				error "${4}"

	[ ! -f "${1}/classes.dex" ] && error "${4}"

	LD_LIBRARY_PATH="${DP_LD}" \
		${ZIPB} -d "${2}" 'classes*.dex' || \
			error " !! zip failed"

	LD_LIBRARY_PATH="${DP_LD}" \
		${ZIPB} -j "${2}" "${1}"/classes*.dex || \
			error " !! zip failed"

	rm -rf "${1}"
}

patch_services () {
	ui_print " "
	ui_print " > patching signature spoofing support"
	ui_print " "

	cp /system/framework/services.jar \
		${BASEDIR}/services.jar || \
		error " !! failed to copy services.jar"

	ui_print " >> [1/2] applying hook patch (services.jar)"
	apply_patch ${BASEDIR}/services.jar-hook \
		${BASEDIR}/services.jar \
		"${BASEDIR}/${PATCH_HOOK}" \
		" !! failed to apply ${PATCH_HOOK}"

	ui_print " >> [2/2] applying core patch (services.jar)"
	apply_patch ${BASEDIR}/services.jar-hook-core \
		${BASEDIR}/services.jar \
		"${BASEDIR}/${PATCH_CORE}" \
		" !! failed to apply ${PATCH_CORE}"

}

patch_services_ui () {
	if [[ -f /system/priv-app/Settings/Settings.apk ]]; then
		cp /system/priv-app/Settings/Settings.apk \
			${BASEDIR}/Settings.apk || \
			error " !! failed to copy Settings.apk"
	elif [[ -f /system/priv-app/SecSettings/SecSettings.apk ]]; then
		cp /system/priv-app/SecSettings/SecSettings.apk \
			${BASEDIR}/SecSettings.apk || \
			error " !! failed to copy SecSettings.apk"
	else	error " !! neither Settings.apk nor SecSettings.apk found"
	fi

	ui_print " "
	ui_print " > patching signature spoofing user interface"
	ui_print " "

	ui_print " >> [1/2] applying ui patch (services.jar)"
	apply_patch ${BASEDIR}/services.jar-hook-core-ui \
		${BASEDIR}/services.jar \
		"${BASEDIR}/${PATCH_UI_SERVICES}" \
		" !! failed to apply ${PATCH_UI_SERVICES}"

	ui_print " >> [2/2] applying ui patch (Settings.apk)"
	apply_patch ${BASEDIR}/Settings.apk-ui \
		${BASEDIR}/Settings.apk \
		"${BASEDIR}/${PATCH_UI_SETTINGS}" \
		" !! failed to apply ${PATCH_UI_SETTINGS}"
}

install_services () {
	ui_print " "
	if [ "${MODE}" = "SYSTEM" ]; then
		ui_print " << backing up services.jar to: /sdcard"
		cp /system/framework/services.jar /sdcard || \
			error " !! failed to backup services.jar"

		if [ "${nanomod_sigspoofui}" -eq 1 ]; then
			ui_print " << backing up Settings.apk to: /sdcard"
			cp /system/priv-app/Settings/Settings.apk /sdcard || \
				error " !! failed to backup Settings.apk"
		fi

		ui_print " << installing patched files to: ROM"
		install_path="${SYSPATH}/"
	else
		if [ -d /dev/magisk_merge/NanoMod ]; then
			ui_print " << installing patched files to: NanoMod (full) [merge]"
			install_path="/magisk/NanoMod/system/framework/"
		elif [ -d /dev/magisk_merge//NanoModmicroG ]; then
			ui_print " << installing patched files to: NanoMod (microG) [merge]"
			install_path="/magisk/NanoModmicroG/system/"
		elif [ -d /magisk/NanoMod ]; then
			ui_print " << installing patched files to: NanoMod (full)"
			install_path="/magisk/NanoMod/system/"
		elif [ -d /magisk/NanoModmicroG ]; then
			ui_print " << installing patched files to: NanoMod (microG)"
			install_path="/magisk/NanoModmicroG/system/"
		else
			ui_print " << backing up services.jar to: /sdcard"
			cp /system/framework/services.jar /sdcard || \
				error " !! failed to backup services.jar"

			if [ "${nanomod_sigspoofui}" -eq 1 ]; then
				ui_print " << backing up Settings.apk to: /sdcard"
				cp /system/priv-app/Settings/Settings.apk /sdcard || \
					error " !! failed to backup Settings.apk"
			fi

			ui_print " << installing patched files to: ROM"
			install_path="${SYSPATH}"
		fi
	fi

	mkdir -p "${install_path}/framework"
	cp ${BASEDIR}/services.jar "${install_path}/framework" \
		|| error " !! failed to install services.jar"

	if [ "${nanomod_sigspoofui}" -eq 1 ]; then
		if [[ -f ${BASEDIR}/Settings.apk ]]; then
			mkdir -p "${install_path}/priv-app/Settings"
			cp ${BASEDIR}/Settings.apk "${install_path}/priv-app/Settings" \
				|| error " !! failed to install Settings.apk"
		elif [[ -f ${BASEDIR}/SecSettings.apk ]]; then
			mkdir -p "${install_path}/priv-app/SecSettings"
			cp ${BASEDIR}/SecSettings.apk "${install_path}/priv-app/SecSettings" \
				|| error " !! failed to install SecSettings.apk"
		fi
	fi

	if [ "${install_path}" = "${SYSPATH}" ]; then
		echo /system/framework/services.jar >> \
			${SYSPATH}/.nanomod-list

		if [ "${nanomod_sigspoofui}" -eq 1 ]; then
			echo /system/priv-app/Settings/Settings.apk >> \
				${SYSPATH}/.nanomod-list
		fi
	fi

	touch ${SYSPATH}/.nanomod-patcher
}

##########################################################################################
# Magisk Functions
##########################################################################################

grow_magisk_img () {
	e2fsck -yf ${IMG}
	resize2fs -f ${IMG} ${newSizeM}M
	e2fsck -yf ${IMG}
}

shrink_magisk_img () {
	e2fsck -yf ${IMG}
	resize2fs -f ${IMG} ${newSizeM}M
	e2fsck -yf ${IMG}
}

magisk_setup () {
	ui_print " > setup Magisk environment"

	MAGISKBIN=/data/magisk

	[ -d $MAGISKBIN -a -f $MAGISKBIN/magisk -a -f $MAGISKBIN/util_functions.sh ] || \
		error " !! Magisk version 13.1 or newer is required"

	. $MAGISKBIN/util_functions.sh
	[ ! -z $SCRIPT_VERSION -a $SCRIPT_VERSION -ge 1310 ] || \
		error " !! Magisk version 13.1 or newer is required"

	MOUNTPATH=/magisk
	IMG=/data/magisk.img

	request_size_check "${INSTALLER}"

	if [ -f "$IMG" ]; then
		image_size_check "${IMG}"
		if [ "$reqSizeM" -gt "$curFreeM" ]; then
			newSizeM=$(((reqSizeM + curUsedM) / 32 * 32 + 64))
			$MAGISKBIN/magisk --resizeimg $IMG $newSizeM || grow_magisk_img
		fi
	else
		newSizeM=$((reqSizeM / 32 * 32 + 64))
		$MAGISKBIN/magisk --createimg $IMG $newSizeM
	fi

	MAGISKLOOP=`$MAGISKBIN/magisk --mountimg $IMG $MOUNTPATH`
	if ! is_mounted $MOUNTPATH; then
		error " !! $IMG mount failed... abort"
	fi
}

magisk_cleanup () {
	$MAGISKBIN/magisk --umountimg $MOUNTPATH $MAGISKLOOP

	image_size_check $IMG
	newSizeM=$((curUsedM / 32 * 32 + 64))
	if [ $curSizeM -gt $newSizeM ]; then
		$MAGISKBIN/magisk --resizeimg $IMG $newSizeM || shrink_magisk_img
	fi
}

##########################################################################################
# Configuration File
##########################################################################################

# check for configuration files
config_locations="/sdcard /external_sd /persist $(dirname ${ZIP})) /data"

get_config () {
	config=""
	config_exists=0
	for path in ${config_locations}; do
		if test -r "${path}/${1}" -a -f "${path}/${1}"; then
			config="${path}/${1}"
			config_exists=1
			return
		fi
	done
}

main () {
	ui_print " "
	ui_print "********************************"
	ui_print "      NanoMod 13.1.99999999     "
	ui_print "       created by @Nanolx       "
	ui_print "       Framework Patcher        "
	ui_print "Powered by DexPatcher (@lanchon)"
	ui_print "         addon.d Script         "
	ui_print "********************************"
	ui_print " "

	if ! (is_mounted /system); then
		mount /system
	fi

	get_config .nanomod-setup
	if [ "$config_exists" -eq 1 ]; then
		source ${config}
		if [ "${nanomod_forcesystem}" -eq 1 ]; then
			MODE=SYSTEM
			ui_print " ++ forced system mode installation"
		else
			nanomod_forcesystem=0
			nanomod_sigspoofui=0
		fi
	fi

	for bin in zip.arm zip.x86 file.arm file.x86; do 
		chmod 0755 "${BASEDIR}/${bin}" || \
			error " !! failed to prepare environment"
	done

	detect_sdk
	detect_odex
	setup_patcher
	detect_arch
	detect_dalvik

	if ! (is_mounted /data); then
		mount -orw /data || error " !! failed to mount /data"
	else	mount -orw,remount /data || error " !! failed to remount /data read-write"
	fi

	if [ "${nanomod_forcesystem}" -ne 1 ]; then
		if [ -f /data/magisk.img  ]; then
			MODE=MAGISK
			magisk_setup
		fi
	fi

	if [ "${MODE}" = "SYSTEM" ]; then
		mount -orw,remount /system
	fi

	dalvik_cache
	patch_services

	if [ "${nanomod_sigspoofui}" -eq 1 ]; then
		patch_services_ui
	fi

	install_services

	ui_print " "
	ui_print " >> clean up"
	magisk_cleanup

	ui_print " "
	ui_print " > Done!"
	ui_print " "
	ui_print "Thanks for using NanoMod"
	ui_print " "

	exit 0
}

case "$1" in
	backup)
		# Stub
	;;
	restore)
		# Stub
	;;
	pre-backup)
		# Stub
	;;
	post-backup)
		# Stub
	;;
	pre-restore)
		# Stub
	;;
	post-restore)
		# Get the FD for ui_print
		OUTFD=`ps | grep -v grep | grep -oE "update(.*)" | cut -d" " -f3`
		# Run the main function in a parallel subshell 
		main
	;;
esac

