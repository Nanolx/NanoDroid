#!/bin/bash

VERSION=5.3.20171231
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


case ${1} in
	zip)
		ZIP="${CWD}/NanoMod-${VERSION}".zip
		rm -f "${ZIP}"

		cd "${CWD}/Overlay"
		zip -r "${ZIP}" *
		cd "${CWD}"

		zip "${ZIP}" README.md
		zip "${ZIP}" ChangeLog.md

		echo "Zipfile ${ZIP} created"
	;;

	ver)
		sed -e "s/^VERSION=.*/VERSION=${2}.${3}/" -i "${PWD}"/mod.sh
		
		for module in Overlay microG fdroid; do
			sed -e "s/\"     NanoMod.*/\"     NanoMod ${2}.${3}     \"/" -i \
				"${PWD}"/"${module}"/META-INF/com/google/android/update-binary
			sed -e "s/version=.*/version=v${2}.${3}/" -i \
				"${PWD}"/"${module}"/module.prop
		done

		sed -e "s/\"     NanoMod.*/\"     NanoMod ${2}.${3}     \"/" -i \
			"${PWD}"/framework-patcher/META-INF/com/google/android/update-binary

	;;

	bump)
		for module in Overlay microG fdroid; do
			eval $(grep versionCode "${PWD}"/"${module}"/module.prop)
			versionCode=$((versionCode+1))
			sed -e "s/versionCode.*/versionCode=${versionCode}/" \
				-i "${PWD}"/"${module}"/module.prop
		done
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

		cp -r "${PWD}"/Overlay/system/{etc,framework}/ \
			"${PWD}"/microG/system/

		ZIP="${CWD}/NanoMod-microG-${VERSION}".zip
		rm -f "${ZIP}"

		cd "${CWD}"/microG
		zip -r "${ZIP}" *
		cd "${CWD}"

		zip "${ZIP}" README.md
		zip "${ZIP}" ChangeLog.md

		rm -rf "${PWD}"/microG/system
		echo "Zipfile ${ZIP} created"
	;;

	fdroid )
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
	;;

	patcher )

		ZIP="${CWD}/NanoMod-patcher-${VERSION}".zip
		rm -f "${ZIP}"

		cd "${CWD}"/framework-patcher
		zip -r "${ZIP}" *
		cd "${CWD}"

		zip "${ZIP}" README.md
		zip "${ZIP}" ChangeLog.md

		echo "Zipfile ${ZIP} created"
	;;

	*)
	echo -e "
** NanoMod ${VERSION} helper script **

usage:	mod.sh [opt] [arg]

possible opts:
	zip			| create module zip from repo *full package*
	microg			| create module zip from repo *microG only*
	fdroid			| create module zip from repo *fdroid only*
	patcher			| create framework-patcher from repo
	ver	[ver] [date]	| bump version
	bump			| bump versionCode in Magisk Modules
"
esac
