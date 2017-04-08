#!/bin/bash

VERSION=5.1.20171231
CWD="${PWD}"

case ${1} in
	zip)
		if [[ -d "${2}" ]]; then
			ZIP="${2}/NanoMod-${VERSION}".zip
			rm -f "${ZIP}"
		else	ZIP="${CWD}/NanoMod-${VERSION}".zip
			rm -f "${ZIP}"
		fi

		cd "${CWD}/Overlay"
		zip -r "${CWD}/Overlay.zip" *
		cd "${CWD}"

		for part in META-INF Overlay.zip Magisk.zip \
			nano.sh unsu.sh README.md ChangeLog \
			.nanomod-overlay .nanomod-setup; do
			zip -r "${ZIP}" "${part}"
		done

		rm -f "${CWD}/Overlay.zip"
		echo "Zipfile NanoMod-${VERSION} created"
	;;

	ver)
		sed -e "s/^VERSION=.*/VERSION=${2}.${3}/" -i ${PWD}/mod.sh
		sed -e "s/< NanoMod.*/< NanoMod ${2}.${3} >\");/" -i \
			"${PWD}"/META-INF/com/google/android/updater-script
		sed -e "s/\"     NanoMod.*/\"     NanoMod ${2}.${3}     \"/" -i \
			"${PWD}"/Overlay/META-INF/com/google/android/update-binary
		sed -e "s/\"     NanoMod.*/\"     NanoMod ${2}.${3}     \"/" -i \
			"${PWD}"/microG/META-INF/com/google/android/update-binary
	;;

	microg )
		mkdir -p "${PWD}"/microG/system/{priv-,}app

		for app in nlpBackendIchnaea nlpBackendNomiantim; do
			cp -r "${PWD}"/Overlay/system/app/"${app}" \
				"${PWD}"/microG/system/app/
		done

		for app in DroidGuard FakeStore GmsCore GsfProxy Phonesky YalpStore; do
			cp -r "${PWD}"/Overlay/system/priv-app/"${app}" \
				"${PWD}"/microG/system/priv-app/
		done

		if [[ -d "${2}" ]]; then
			ZIP="${2}/NanoMod-microG-${VERSION}".zip
			rm -f "${ZIP}"
		else	ZIP="${CWD}/NanoMod-microG-${VERSION}".zip
			rm -f "${ZIP}"
		fi

		cd "${CWD}"/microG
		zip -r "${ZIP}" *
		cd "${CWD}"

		rm -rf "${PWD}"/microG/system

	;;

	*)
	echo -e "
** NanoMod ${VERSION} helper script **

usage:	mod.sh [opt] [arg]

possible opts:
	zip	[dir]		| create zip file from repo *full package*
				  (in [dir] if provided)
	microg	[dir]		| create zip file from repo *microG only*
				  (in [dir] if provided)
	ver	[ver] [date]	| bump version
"
esac
