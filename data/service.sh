#!/system/bin/sh

MODDIR=${0%/*}
MODULE=$(basename ${MODDIR})

run_initscripts () {
	# wait until boot completed
	until [ `getprop vold.post_fs_data_done`. = 1. ]; do sleep 1; done

	# Set current date in 20170607-12.07.25 format
	CURDATE=$(date +%Y%m%d-%H.%M.%S)

	# Create private Log directory
	LOGDIR="${MODDIR}/logs"

	[[ ! -d ${LOGDIR} ]] && mkdir -p "${LOGDIR}"

	# NanoDroid init scripts
	for init in 10_sqlite 20_fstrim 30_logcat 40_external_sd 50_logscleaner; do
		"${MODDIR}/init.d/${init}" | tee -a "${LOGDIR}/${init}.log.${CURDATE}" &
	done
}

install_droidguardhelper () {
	# wait until boot completed
	until [ $(getprop sys.boot_completed). = 1. ]; do sleep 1; done

	# microG DroidGuard Helper needs to be installed as user app to prevent crashes
	if [ -f "${MODDIR}/system/app/DroidGuard/DroidGuard.apk" ]; then
		pm list packages -f | grep -q /data.*org.microg.gms.droidguard || \
			pm install -r "${MODDIR}/system/app/DroidGuard/DroidGuard.apk" &
	fi
}

install_bromitewebview () {
	# wait until boot completed
	until [ $(getprop sys.boot_completed). = 1. ]; do sleep 1; done

	# Bromite WebView needs to be installed as user app to prevent crashes
	pm list packages -f | grep -q /data.*com.android.webview || \
		pm install -r "${MODDIR}/system/app/BromiteWebView/BromiteWebView.apk" &
}

case ${MODULE} in
	NanoDroid )
		run_initscripts &
		install_droidguardhelper &
	;;

	NanoDroid_microG )
		install_droidguardhelper &
	;;

	NanoDroid_FDroid )
		exit 0
	;;

	NanoDroid_BromiteWebView )
		install_bromitewebview &
	;;

	NanoDroid_OsmAnd )
		exit 0
	;;
esac
