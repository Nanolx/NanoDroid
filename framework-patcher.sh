#!/bin/bash

GITHUB_URL="https://github.com/Lanchon/haystack.git"
PATCH_CORE="sigspoof-core"

error () {

	echo "${@}"
	exit 1

}

help () {

echo -e "haystack framework patcher helper

provide Android Version like:
	haystack [version]

there version is one of:
	4.1	[JB]
	4.2	[JB]
	4.3	[JB]
	4.4	[KK]
	5.0	[LL]
	5.1	[LL]
	6.0	[MM]
	7.0	[N]
	7.1	[N]

device desired to patch must be connected through
TWRP and /system mounted read-write."

exit 0

}

case "${1}" in
	4.1 )	API=16	;;
	4.2 )	API=17	;;
	4.3 )	API=18	;;
	4.4 )	API=19	;;
	5.0 )	API=21	;;
	5.1 )	API=22	;;
	6.0 )	API=23	;;
	7.0 )	API=24	;;
	7.1 )	API=25	;;
	*   )	help	;;
esac

if [[ ${API} -lt 24 ]]; then
	PATCH_HOOK="sigspoof-hook-4.1-6.0"
	PATCH_UI="sigspoof-ui-global-4.1-6.0"
else	PATCH_HOOK="sigspoof-hook-7.0"
	PATCH_UI="sigspoof-ui-global-7.0"
fi

[[ -d ${PWD}/haystack ]] && rm -rf ${PWD}/haystack
git clone "${GITHUB_URL}" || error "Failed to down haystack!"

cd ${PWD}/haystack

${PWD}/pull-fileset mydevice || error "Failed to pull files from device!"

${PWD}/patch-fileset ${PWD}/patches/${PATCH_HOOK} ${API} ${PWD}/mydevice \
	|| error "Failed applying sigspoof hook patch!"

${PWD}/patch-fileset ${PWD}/patches/${PATCH_CORE} ${API} \
	${PWD}/mydevice__${PATCH_HOOK} \
	|| error "Failed applying sigspoof core patch!"

${PWD}/patch-fileset ${PWD}/patches/${PATCH_UI} ${API} \
	${PWD}/mydevice__${PATCH_HOOK}__${PATCH_CORE} \
	|| error "Failed applying sigspoof ui patch!"

${PWD}/push-fileset ${PWD}/mydevice__${PATCH_HOOK}__${PATCH_CORE}__${PATCH_UI} \
	|| error "Failed to push files to device!"
