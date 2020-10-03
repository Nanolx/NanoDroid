Table of Contents
=================

   * [NanoDroid](#nanodroid)
      * [NanoDroid-Overlay](#nanodroid-overlay)
      * [NanoDroid-Prop](#nanodroid-prop)
      * [NanoDroid-Perm](#nanodroid-perm)
      * [NanoDroid-Util](#nanodroid-util)
      * [init scripts](#init-scripts)
      * [GNU Bash](#gnu-bash)
      * [microG](#microg)
      * [F-Droid](#f-droid)
      * [Google Sync/Swipe Libraries](#google-syncswipe-libraries)
      * [Applications](#applications)

Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc)

# NanoDroid

This lists features unique to NanoDroid.

## NanoDroid-Overlay

The `nanodroid-overlay` script handles the debloat feature

* pseudo-debloat applications in Magisk Mode
* force-debloat applications in System Mode
* show the list of debloated apps
* show the list of non-debloated apps
* add or remove apps from the list of debloated apps

Full details on the NanoDroid-Overlay Script [> Details](NanoDroidOverlay.md)

## NanoDroid-Prop

The `nanodroid-prop` script utilizes Magisk's resetprop to alter system properties

* add system properties (Magisk-only)
  * both on-the-fly and permanently
* properties set by this script survive NanoDroid updates

Full details on the NanoDroid-Prop Script [> Details](NanoDroidProp.md)

## NanoDroid-Perm

The `nanodroid-perm` script grants microG and Co. required permissions, if lacking

Full details on the NanoDroid-Perm Script [> Details](NanoDroidPerm.md)

## NanoDroid-Util

The `nanodroid-util` script contains the following features

* show boot count
* fix OTA update issues (like non-working navbar)
* handle `Audio Focus` permission
  * prevent apps from stealing audio output, for example listen to Music while playing Pokémon Go
* handle `Read Clipboard` permission
* modify `Airplane Mode` settings
  * choose which radios are on or off in Airplane mode

Full details on the NanoDroid-Util Script [> Details](NanoDroidUtil.md)

## init scripts

The following init scripts are bundled with NanoDroid

* external_sd
  * symlink SD Card mount point to `/external_sd`
  * SD Card needs to be inserted upon boot
* fstrim
  * trim file systems (may increase speed)
* logcat
  * store logcat in /data/adb/logcats
     * logs older than 7 days are deleted on every reboot
* logscleaner
  * clean up system log files older than 7 days
* sqlite
  * clean up sqlite databases

When in Magisk Mode the init scripts create their log files in

  `/magisk/NanoDroid/logs/${script}.log.${date}`

When installed to /system your ROM needs to support running scripts in

  `/system/etc/init.d`

or you can use **Kernel Adiutor's** init.d emulation.

## GNU Bash

NanoDroid includes GNU Bash shell.

* [> GNU Bash Website](https://www.gnu.org/software/bash/bash.html)

The [> less](http://www.greenwoodsoftware.com/less/) Pager will be installed alongside.

The `column` utility from [> bsdmainutils Launchpad](https://launchpad.net/ubuntu/+source/bsdmainutils) is included to beautify the output of the `nanodroid-overlay` script.

## microG

microG is an Open Source replacement for Google Services, full details can be found at the microG homepage [> Website](http://microg.org/)

NanoDroid includes microG as follows

* microG GmsCore [> GitHub](https://github.com/microg/android_packages_apps_GmsCore)
* with optional **Déjà Vu** location provider backend [> F-Droid](https://f-droid.org/de/packages/org.fitchfamily.android.dejavu/)
* with optional **Mozilla** location provider backend [> F-Droid](https://f-droid.org/repository/browse/?fdfilter=mozilla&fdid=org.microg.nlp.backend.ichnaea)
* with optional **Apple** location provider backend [> F-Droid](https://f-droid.org/de/packages/org.microg.nlp.backend.apple/)
* with optional **Radiocells** location provider backend [> F-Droid](https://f-droid.org/en/packages/org.openbmap.unifiedNlp/)
* with **Nominatim** adress provider backend [> F-Droid](https://f-droid.org/repository/browse/?fdfilter=nominatim&fdid=org.microg.nlp.backend.nominatim)
* with **microG** GsfProxy [> GitHub](https://github.com/microg/android_packages_apps_GsfProxy)
* with **microG** DroidGuard Helper [> GitHub](https://github.com/microg/android_packages_apps_RemoteDroidGuard)
  * required for SafetyNet support
* support for Maps API version 1
* support for Google Calendar and Contacts Sync Adapter
  * disabled by default
* optional Swipe libraries
  * disabled by default
* choose between modified **Play Store** [> APK Mirror](https://www.apkmirror.com/apk/google-inc/google-play-store/) or **Aurora Store** [> F-Droid](https://f-droid.org/de/packages/com.dragons.aurora/)
  * **Aurora Store** can use system permissions to install packages, so you don't need to enable `Unknown Sources`
     * go to **Aurora Store** Settings > Installation Method > `Using system permissions`
  * Play Store is modified to allow (in-)app-purchases with microG
* GApps and several location services conflict with microG and unified Nlp. Thus they are removed during NanoDroid installation
  * using [> NanoDroid-Overlay](NanoDroidOverlay.md)
  * see [> GAppsRemoval](GAppsRemoval.md) for more details

## F-Droid

F-Droid [> Website](http://www.fdroid.org) is an app store for OpenSource applications.

NanoDroid includes both F-Droid and it's Privileged Extension [> F-Droid](https://f-droid.org/repository/browse/?fdfilter=f-droid&fdid=org.fdroid.fdroid.privileged), so you don't need to enable `Unknown Sources`. Alternatively (or additionally) you can install Aurora Droid [> F-Droid](https://f-droid.org/de/packages/com.aurora.adroid/).

Furthermore NanoDroid tells F-Droid to activate the following additional repositories by default:

* NanoDroid companion F-Droid repository [> Link](https://www.nanolx.org/fdroid/repo)
* BromiteWebView F-Droid repository [> Link](https://www.bromite.org/fdroid)
* official microG F-Droid repository [> Link](https://microg.org/fdroid.html)

## Google Sync/Swipe Libraries

Google Sync adapters and Swipe Libraries are optionally installable through the **NanoDroid-Google** package.

## Applications

NanoDroid includes a variety of OpenSource applications, check full [> list of applications](Applications.md).
