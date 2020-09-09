# Alter Installation

## Configuration File

To alter the installation you can create the file

`.nanodroid-setup`

on your device, in one of the following directories

* `/data/media/0` (internal storage (TWRP))
* `/sdcard1` (internal storage (ORANGEFOX))
* `/external_sd` (TWRP path to SD Card (if any))
* `/data` (fallback)

You can use the [default configuration file](.nanodroid-setup) as a starting point. Below follows the detailed information on what each setting does (also described in the file itself); also which setting is support by what package. If an required entry is missing from your configuration file, the default setting will be added to your configuration file.

## Detailed Description

### nanodroid_microg

whether to install **microG**

* supported packages
  * Full package
  * microG package

Syntax: `nanodroid_microg=1`, value can be 0, 1 or 2:

* 0 = don't install microG at all (Note: does not effect NanoDroid-microG package)
* 1 = install microG GmsCore, GsfProxy and DroidGuard Helper and Nominatim Geocoder Backend
* 2 = install microG GmsCore and Nominatim Geocoder Backend only
  * note: OpenSource purists setting; this will leave you
      * without Push Messaging support through GCM
      * without the ability to pass SafetyNet attestation

### nanodroid_nlpbackend

what uNlp backends to install

* supported packages
	* Full package
	* microG package

Syntax: `nanodroid_nlpbackend=1000`

this setting is four digits long, each digit represents one uNlp backend:
* 0 = for each digit means don't install the backend
* 1 = for each digit means install the backend

digits represent the following backends:
* 1st digit = Déjà Vu backend
* 2nd digit = Ichnaea (Mozilla) backend
* 3rd digit = Apple backend
* 4th digit = Radiocells.org backend

examples:
* nanodroid_nlpbackend=1000 = install Déjà Vu backend
* nanodroid_nlpbackend=1010 = install Déjà Vu and Apple backends

### nanodroid_mapsv1

whether to provide **microG** Maps API v1

* supported packages
  * Full package
  * microG package

Syntax: `nanodroid_mapsv1=1`, value can be or 1:

* 0 = don't install Maps v1 API support
* 1 = install Maps v1 API support

### nanodroid_play

what app store to install

* supported packages
  * Full package
  * microG package

Syntax: `nanodroid_play=21`, this setting is value pair, the first digit declares the app store, the second whether to install Fake store alongside:

* 00 = install no app store
* 10 = install Google Play (patched with microG (in-)app-purchase support)
* 01 = install Fake Store
* 20 = install Aurora Store (alongside Aurora Services addon)
* 21 = install Aurora Store (alongside Aurora Services addon) and Fake Store
* 30 = install Google Play (patched with microG (in-)app-purchase support) and Aurora Store (alongside Aurora Services addon)

Note:
* if `nanodroid_play=11` or  `nanodroid_play=31` it will be silently treated as `10` or `30`
  * you can't install both Play Store and Fake Store at the same time

### nanodroid_fdroid

whether to install **F-Droid**

* supported packages
  * Full package
  * F-Droid package

Syntax: `nanodroid_fdroid=1`, value can be 0, 1, 2 or 3:

* 0 = don't install F-Droid at all (Note: does not effect NanoDroid-FDroid package)
* 1 = install official F-Droid client (alongside priviledged extension)
* 2 = install unofficial Aurora F-Droid client (alongside Aurora Services addon)
* 3 = install both official and Aurora F-Droid clients (alongside their addons)

### nanodroid_apps

whether to install applications

* supported packages
  * Full package

Syntax: `nanodroid_apps=1`, value can be 0 or 1:

* 0 = don't install applications
* 1 = install applications

see [> Applications](Applications.md) for detailed information

### nanodroid_overlay

whether to utilize the NanoDroid-Overlay to pseudo-debloat `/system` applications in Magisk Mode, or force-debloat on System Mode

Syntax: `nanodroid_overlay=1`, value can be 0 or 1:

* 0 = don't utilize NanoDroid-Overlay
* 1 = utilize NanoDroid-Overlay

see [> NanoDroid-Overlay](NanoDroidOverlay.md) for detailed information

### nanodroid_bash

whether to install GNU Bash (alongside the less pager)

* supported packages
  * Full package

Syntax: `nanodroid_bash=1`, value can be 0: 1:

* 0 = don't install GNU Bash
* 1 = install GNU Bash

### nanodroid_utils

whether and what shell utils to install

* supported packages
  * Full package

Syntax: `nanodroid_utils="findfs findmnt hexdump lessecho lesskey lsblk lscpu lsipc lslocks lsns ncal whereis"`

this setting is a list of utils, each listed item will be installed, possible values are

```
findfs
findmnt
hexdump
lessecho
lesskey
lsblk
lscpu
lsipc
lslocks
lsns
ncal
whereis
```

to install no utils, leave empty (`nanodroid_utils=""`), the `""` are mandatory in any case

see [here for more information](../README.md#shell-utilities)

### nanodroid_init

whether and what init scripts to install

* supported packages
  * Full package

this setting is a list of init scripts, each listed item will be installed, possible values

```
10_sqlite
20_fstrim
30_logcat
40_external_sd
50_logscleaner
```

to install no init scripts, leave empty (`nanodroid_init=""`), the `""` are mandatory in any case

see [here for more information](../README.md#init-scripts)

### nanodroid_gsync

whether to install Google Sync Adapters

* supported packages
  * Google

Syntax: `nanodroid_gsync=1`, value can be 0 or 1:

* 0 = don't install Google Sync Adapters
* 1 = install Google Sync Adapters

### nanodroid_swipe

whether to install Swipe libraries

* supported packages
  * Google

Syntax: `nanodroid_swipe=1`, value can be 0 or 1:

* 0 = don't install Swipe libraries
* 1 = install Swipe libraries

### nanodroid_forcesystem

force direct /system installation (else NanoDroid will autodetect whether Magisk is installed and will prefer Magisk Module installation)

* supported packages
  * Full package
  * microG package
  * F-Droid package
  * Bromite System WebView package
  * OSM Android
  * Google package

Syntax: `nanodroid_forcesystem=0`, value can be 0 or 1:

* 0 = auto detect installation mode
* 1 = force /system installation
