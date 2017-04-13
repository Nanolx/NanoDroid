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
		zip "${ZIP}" ChangeLog

		echo "Zipfile ${ZIP} created"
	;;

	ver)
		sed -e "s/^VERSION=.*/VERSION=${2}.${3}/" -i "${PWD}"/mod.sh
		sed -e "s/\"     NanoMod.*/\"     NanoMod ${2}.${3}     \"/" -i \
			"${PWD}"/Overlay/META-INF/com/google/android/update-binary
		sed -e "s/\"     NanoMod.*/\"     NanoMod ${2}.${3}     \"/" -i \
			"${PWD}"/microG/META-INF/com/google/android/update-binary
		sed -e "s/version=.*/version=v${2}.${3}/" -i \
			"${PWD}"/Overlay/module.prop
		sed -e "s/version=.*/version=v${2}.${3}/" -i \
			"${PWD}"/microG/module.prop
	;;

	bump)
		eval $(grep versionCode "${PWD}"/Overlay/module.prop)
		versionCode=$((versionCode+1))
		sed -e "s/versionCode.*/versionCode=${versionCode}/" \
			-i "${PWD}"/Overlay/module.prop

		eval $(grep versionCode "${PWD}"/microG/module.prop)
		versionCode=$((versionCode+1))
		sed -e "s/versionCode.*/versionCode=${versionCode}/" \
			-i "${PWD}"/microG/module.prop
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

		ZIP="${CWD}/NanoMod-microG-${VERSION}".zip
		rm -f "${ZIP}"

		cd "${CWD}"/microG
		zip -r "${ZIP}" *
		cd "${CWD}"

		zip "${ZIP}" README.md
		zip "${ZIP}" ChangeLog

		rm -rf "${PWD}"/microG/system
		echo "Zipfile ${ZIP} created"
	;;

	*)
	echo -e "
** NanoMod ${VERSION} helper script **

usage:	mod.sh [opt] [arg]

possible opts:
	zip			| create zip file from repo *full package*
	microg			| create zip file from repo *microG only*
	ver	[ver] [date]	| bump version
	bump			| bump versionCode in Magisk Modules
"
esac
