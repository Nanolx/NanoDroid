# Alter Installation

## Configuration File

To alter the installation you can create the file

`.nanodroid-setup`

on your device, in one of the following directories

* `/data/media/0` (internal storage (TWRP))
* `/sdcard1` (internal storage (ORANGEFOX))
* `/external_sd` (TWRP path to SD Card (if any))
* directory containing the zip file
* `/data` (fallback)

create it manually with the following content for the **full** package

```
nanodroid_microg=1
nanodroid_fdroid=1
nanodroid_apps=1
nanodroid_play=21
nanodroid_overlay=1
nanodroid_mapsv1=1
nanodroid_init="10_sqlite 20_fstrim 30_logcat 40_external_sd 50_logscleaner"
nanodroid_forcesystem=0
nanodroid_nlpbackend=1000
nanodroid_bash=1
nanodroid_utils="findfs findmnt hexdump lessecho lesskey lsblk lscpu lsipc lslocks lsns ncal whereis"
```

the **microG** package supports the following options (nanodroid_microg is always 1)

```
nanodroid_play=21
nanodroid_overlay=0
nanodroid_mapsv1=1
nanodroid_forcesystem=0
nanodroid_nlpbackend=1000
```

the **F-Droid** (nanodroid_fdroid is always 1) and **Bromite WebView** package supports the following options

```
nanodroid_forcesystem=0
```

the **Google** package supports the following options

```
nanodroid_gsync=0
nanodroid_swipe=0
```

where `1` means `on` and `0` means `off`. If no `.nanodroid-setup` is found, the [default settings](.nanodroid-setup) will be used (equals to the example above), if your `.nanodroid-setup` file exists, but is missing entries, those entries will be added, using the default values.

Alternatively you can also use the NanoDroid-SetupWizard package instead of manual creation of the configuration file.

## Detailed Description

`nanodroid_microg=[0|1|2]`

whether to provide **microG**

* 0 = don't install microG at all (Note: does not effect NanoDroid-microG package)
* 1 = install microG GmsCore, GsfProxy and DroidGuard Helper and Nominatim Geocoder Backend
* 2 = install microG GmsCore and Nominatim Geocoder Backend only
  * note: OpenSource purists setting; this will leave you
      * without Push Messaging support through GCM
      * without the ability to pass SafetyNet attestation

`nanodroid_fdroid=[0|1|2]`

whether to provide **F-Droid**

* 0 = don't install F-Droid at all (Note: does not effect NanoDroid-FDroid package)
* 1 = install official F-Droid client
* 2 = install unofficial Aurora F-Droid client
  * alongside Aurora Services addon

`nanodroid_apps=[0|1]`

whether to provide included applications [> Details](doc/Applications.md)

`nanodroid_play=[0|1|2|3][0|1]`

what app store to use:
* 1st item
  * 0 = No App Store
  * 1 = Play Store
  * 2 = Aurora Store
      * alongside Aurora Services addon
* 2nd item
  * 0 = without Fake Store
  * 1 = with Fake Store

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
