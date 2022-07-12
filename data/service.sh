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
		if [ -f "${MODDIR}/init.d/${init}" ]; then
			"${MODDIR}/init.d/${init}" | tee -a "${LOGDIR}/${init}.log.${CURDATE}" &
		fi
	done
}

run_npem () {
	# wait until boot completed
	until [ $(getprop sys.boot_completed). = 1. ]; do sleep 1; done
	${MODDIR}/system/bin/npem
}

install_bromitewebview () {
	# wait until boot completed
	until [ $(getprop sys.boot_completed). = 1. ]; do sleep 1; done

	# Bromite WebView needs to be installed as user app to prevent crashes
	if [ -d "${MODDIR}/system/product/app" ]; then
		pm list packages -f | grep -q /data.*org.bromite.webview || \
			pm install -r "${MODDIR}"/system/product/app/*/*.apk &
	else
		pm list packages -f | grep -q /data.*org.bromite.webview || \
			pm install -r "${MODDIR}"/system/app/*/*.apk &
	fi
}

case ${MODULE} in
	NanoDroid )
		run_initscripts &
		run_npem &
	;;

	NanoDroid_microG )
		run_npem &
	;;

	NanoDroid_BromiteWebView )
		install_bromitewebview &
	;;

	* )
		exit 0
	;;
esac
