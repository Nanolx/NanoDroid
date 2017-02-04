#!/bin/bash
#
# create zip file from repository
#

VERSION="3.0.20170204"

for part in apps bash META-INF microG nano PlayStore \
	substratum userapps zelda-ringtones Magisk.zip \
	nano-*.zip nano.sh README; do
	zip -r NanoMod-"${VERSION}".zip ${part} || exit 1
done

echo "Zipfile NanoMod-${VERSION} created"
