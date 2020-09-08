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

### nanodroid_overlay

`nanodroid_overlay=[0|1]`

whether to populate the overlay to pseudo-debloat `/system` applications (Magisk-only)

`nanodroid_mapsv1=[0|1]`

whether to provide **microG** Maps API v1

`nanodroid_init="10_sqlite 20_fstrim 30_logcat 40_external_sd 50_logscleaner"`

whether to provide init scripts (the choosen ones, or "" for none)

`nanodroid_gsync=[0|1]`

whether to provide Google Sync Adapters

`nanodroid_swipe=[0|1]`

whether to provide Swipe libraries

`nanodroid_forcesystem=[0|1]`

whether to force system mode installation, regardless whether Magisk is installed

`nanodroid_nlpbackend=[0|1][0|1][0|1][0|1]`

what location backends for microG to install
* 1st element 0|1 = Déjà Vu location backend
* 2nd element 0|1 = Ichnaea (Mozilla) location backend
* 3rd element 0|1 = Apple location backend
* 4th element 0|1 = Radiocells.org location backend

`nanodroid_bash=[0|1]`

whether to install GNU Bash Shell

`nanodroid_utils="findfs findmnt hexdump lessecho lesskey lsblk lscpu lsipc lslocks lsns ncal whereis"`

whether to install Shell Utils from util-linux and bsdmainutils (the choosen ones, or "" for none)
