#!/bin/bash

VERSION=7.3.20171231
CWD="${PWD}"

if [[ "$OSTYPE" == "darwin"* ]]; then
  if ! [ -x "$(command -v brew)" ]; then
      /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
  if ! [ -x "$(command -v gsed)" ]; then
      brew install gnu-sed
  fi
  alias sed=gsed
fi

_zip () {
	ZIP="${CWD}/NanoMod-${VERSION}".zip
		rm -f "${ZIP}"

	cd "${CWD}/Overlay"
	zip -r "${ZIP}" *
	cd "${CWD}"

	zip "${ZIP}" README.md
	zip "${ZIP}" ChangeLog.md

	echo "Zipfile ${ZIP} created"
}

_ver() {
	sed -e "s/^VERSION=.*/VERSION=${2}.${3}/" -i "${PWD}"/mod.sh

	for module in Overlay microG fdroid; do
		sed -e "s/\"     NanoMod.*/\"     NanoMod ${2}.${3}     \"/" -i \
			"${PWD}"/"${module}"/META-INF/com/google/android/update-binary
		sed -e "s/version=.*/version=v${2}.${3}/" -i \
			"${PWD}"/"${module}"/module.prop
	done

	sed -e "s/\"      NanoMod.*/\"      NanoMod ${2}.${3}     \"/" -i \
		"${PWD}"/framework-patcher/META-INF/com/google/android/update-binary
}

_bump () {
	for module in Overlay microG fdroid; do
		eval $(grep versionCode "${PWD}"/"${module}"/module.prop)
		versionCode=$((versionCode+1))
		sed -e "s/versionCode.*/versionCode=${versionCode}/" \
			-i "${PWD}"/"${module}"/module.prop
	done
}

_microg() {
	mkdir -p "${PWD}"/microG/system/{priv-,}app
	mkdir -p "${PWD}"/microG/system/{bin,etc}

	for app in nlpBackendIchnaea nlpBackendNomiantim; do
		cp -r "${PWD}"/Overlay/system/app/"${app}" \
			"${PWD}"/microG/system/app/
	done

	for app in DroidGuard FakeStore GmsCore GsfProxy Phonesky YalpStore; do
		cp -r "${PWD}"/Overlay/system/priv-app/"${app}" \
			"${PWD}"/microG/system/priv-app/
	done

	cp "${PWD}"/Overlay/system/bin/nanomod-overlay \
		"${PWD}"/microG/system/bin

	cp -r "${PWD}"/Overlay/system/framework/ \
		"${PWD}"/microG/system/

	cp -r "${PWD}"/Overlay/system/etc/permissions/ \
		"${PWD}"/microG/system/etc/

	ZIP="${CWD}/NanoMod-microG-${VERSION}".zip
	rm -f "${ZIP}"

	cd "${CWD}"/microG
	zip -r "${ZIP}" *
	cd "${CWD}"

	zip "${ZIP}" README.md
	zip "${ZIP}" ChangeLog.md

	rm -rf "${PWD}"/microG/system
	echo "Zipfile ${ZIP} created"
}

_fdroid() {
	mkdir -p "${PWD}"/fdroid/system/{priv-,}app

	cp -r "${PWD}"/Overlay/system/app/FDroid \
		"${PWD}"/fdroid/system/app/

	cp -r "${PWD}"/Overlay/system/priv-app/FDroidPrivileged \
		"${PWD}"/fdroid/system/priv-app/

	ZIP="${CWD}/NanoMod-fdroid-${VERSION}".zip
	rm -f "${ZIP}"

	cd "${CWD}"/fdroid
	zip -r "${ZIP}" *
	cd "${CWD}"

	zip "${ZIP}" README.md
	zip "${ZIP}" ChangeLog.md

	rm -rf "${PWD}"/fdroid/system
	echo "Zipfile ${ZIP} created"
}

_patcher() {
	ZIP="${CWD}/NanoMod-patcher-${VERSION}".zip
	rm -f "${ZIP}"

	cd "${CWD}"/framework-patcher
	zip -r "${ZIP}" *
	cd "${CWD}"

	zip "${ZIP}" README.md
	zip "${ZIP}" ChangeLog.md

	echo "Zipfile ${ZIP} created"
}

_unpacklibs () {

	for apk in Overlay/system/*app/*/*.apk; do
		if [ -n "$(zipinfo -1 ${apk} | grep ^lib/)" ]; then
			echo $apk >> apks;
		fi;
	done 

	for apk in $(cat apks); do
		dir=$(dirname $apk)
		fil=$(basename $apk)
		unzip -qq ${apk} -d ${fil}
		if [[ -d ${fil}/lib/arm64-v8a ]]; then
			mkdir -p ${dir}/lib/arm64
			cp ${fil}/lib/arm64-v8a/* ${dir}/lib/arm64/
		fi
		if [[ -d ${fil}/lib/armeabi-v7a ]]; then
			mkdir -p ${dir}/lib/arm
			cp ${fil}/lib/armeabi-v7a/* ${dir}/lib/arm/
		elif [[ -d ${fil}/lib/armeabi ]]; then
			mkdir -p ${dir}/lib/arm
			cp ${fil}/lib/armeabi/* ${dir}/lib/arm/
		fi
		rm -rf ${fil}
	done

	rm -f apks

}

case ${1} in
	zip)
		_zip
	;;

	ver)
		_ver "${@}"
	;;

	bump)
		_bump
	;;

	microg )
		_microg
	;;

	fdroid )
		_fdroid
	;;

	patcher )
		_patcher
	;;

	all )
		_zip
		_microg
		_fdroid
		_patcher
	;;

	unpacklibs )
		_unpacklibs
	;;

	*)
	echo -e "
** NanoMod ${VERSION} helper script **

usage:	mod.sh [opt] [arg]

possible opts:
	zip			| create module zip from repo *full package*
	microg			| create module zip from repo *microG only*
	fdroid			| create module zip from repo *fdroid only*
	patcher			| create framework-patcher zip from repo
	all			| create all zips from repo
	ver	[ver] [date]	| bump version
	bump			| bump versionCode in Magisk Modules
"
esac
