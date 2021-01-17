Table of Contents
=================

   * [Deodex services.jar](#deodex-servicesjar)
      * [Pre-Check](#pre-check)
      * [Android 9.0 Pie](#android-90-pie)
      * [VDEX](#vdex)
      * [ODEX](#odex)

Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc)

# Deodex services.jar

Here you can find instructions on how to manually deodex `services.jar` as preparation for Signature Spoofing support.

If you want to check beforehand (or afterwards) if your ROM supports Signature Spoofing, use this [tool](https://f-droid.org/de/packages/lanchon.sigspoof.checker/).

## Pre-Check

If your `/system/framework/services.jar` file contains the file `classes.dex`, you can skip deodexing and start patching right-away. Else follow these instructions.

## Android 9.0 Pie

Android 9.0 is currently not supported by smali/baksmali (more precisely O/DEX format 039 and OAT format changes are not yet implemented).

VdexExtractor will create CompatDex for Android 9.0 (more precisely VDEX 019 files) instead of DEX. Theese CDEX files can only be manually converted to DEX on a GNU/Linux or MacOS PC, see [this instructions](https://github.com/anestisb/vdexExtractor#compact-dex-converter).

## VDEX

If you can see `/system/framework/oat/[arch]/services.vdex`, where `[arch]` is the device architecture (arm, arm64, x86 or x86_64), you should follow theese instructions.

The instructions are basically simple, though there is a lot of commands:

* connect phone with PC while in TWRP, mount `/system` **read-write**
* get latest `vdexExtractor`
  * [vdexExtractor Sources](https://github.com/anestisb/vdexExtractor)
* zip/unzip utilities for commandline (or some UI tool)
* common sense on using commandline (or some UI tool instead)

```bash
adb pull /system/framework framework
cp framework/services.jar services.jar-backup
```

now deodex `services.vdex`:

```bash
vdexExtractor -i framework/oat/[arch]/services.vdex --ignore-crc-error
```

This will create the following file: `framework/oat/[arch]/services.apk_classes.dex`

If it has been properly created, rename it to `classes.dex` and add it to `services.jar`. If there are additional files like `services.apk_classes2.dex`, rename them to `classes2.dex` and add them to `services.jar` like this:

```bash
mv framework/oat/[arch]/services.apk_classes.dex classes.dex
... mv for other dex files ...
zip -j framework/services.jar classes*.dex
```

Then, install the new `services.jar` on the device:

```bash
adb push framework/services.jar /system/framework
adb shell
chmod 0644 /system/framework/services.jar
chown root:root /system/framework/services.jar
```

Unmount `/system` and flash the **NanoDroid-Patcher**.

If something goes wrong, you still have the unpatched `services.jar`, as we created a copy named `services.jar-backup`.

## ODEX

If you can see `/system/framework/oat/[arch]/services.odex`, where `[arch]` is the device architecture (arm, arm64, x86 or x86_64), you should follow theese instructions:

The instructions are basically simple, though there is a lot of commands:

* connect phone with PC while in TWRP, mount `/system` **read-write**
* get latest `baksmali.jar` and `smali.jar`
  * [smali Sources](https://github.com/JesusFreke/smali)
* zip/unzip utilities for commandline (or some UI tool)
* common sense on using commandline (or some UI tool instead)

```bash
adb pull /system/framework framework
cp framework/services.jar services.jar-backup
```

```bash
java -jar baksmali.jar x framework/oat/[arch]/services.odex -d framework/[arch] -d framework/ -o services-new
java -jar smali.jar a services-new -o classes.dex
```

Sometimes `baksmali.jar` can't find the bootclasses file itself. In this case, you need to pass it manually using `-b`, for example:

`-b framework/[arch]/boot.oat`

In any case, if a new `classes.dex` was successfully created in the services-new directory, re-package it into the `services.jar` we previously pulled:

```bash
zip -j framework/services.jar classes*.dex
```

Then, install the new `services.jar` on the device:

```bash
adb push framework/services.jar /system/framework
adb shell
chmod 0644 /system/framework/services.jar
chown root:root /system/framework/services.jar
```

Unmount `/system` and flash the NanoDroid-Patcher.

If something goes wrong you still have the unpatched `services.jar`, as we created a copy named `services.jar-backup`.
