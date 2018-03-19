# Alter Installation

## Configuration File

To alter the installation you can create the file

`.nanodroid-setup`

on your device, in one of the following directories

* `/sdcard` (internal storage)
* `/external_sd` (TWRP path to SD Card (if any))
* directory containing the zip file
* `/data` (fallback)

create it manually with the following content for the **full** package

```
nanodroid_microg=1
nanodroid_fdroid=1
nanodroid_apps=1
nanodroid_play=1
nanodroid_overlay=1
nanodroid_zelda=1
nanodroid_mapsv1=1
nanodroid_init=1
nanodroid_gsync=0
nanodroid_swipe=0
nanodroid_forcesystem=0
nanodroid_nlpbackend=1
nanodroid_bash=1
nanodroid_nano=1
nanodroid_utils=1
nanodroid_fonts=1
```

the **microG** package supports the following options

```
nanodroid_play=1
nanodroid_overlay=0
nanodroid_mapsv1=1
nanodroid_gsync=0
nanodroid_swipe=0
nanodroid_forcesystem=0
nanodroid_nlpbackend=1
```

the **F-Droid** package supports the following options

```
nanodroid_forcesystem=0
```

where `1` means `on` and `0` means `off`. If no `.nanodroid-setup` is found, the [default settings](.nanodroid-setup) will be used (equals to the example above), if your `.nanodroid-setup` file exists, but is missing entries, those entries will be added, using the default values.

Alternatively you can also use the NanoDroid-SetupWizard package instead of manual creation of the configuration file.

## Detailed Description

`nanodroid_microg=[0|1]`

whether to provide **microG**

`nanodroid_fdroid=[0|1]`

whether to provide **F-Droid**

`nanodroid_apps=[0|1]`

whether to provide included applications [> Details](doc/Applications.md)

`nanodroid_play=[0|1|2]`

what app store to use:
* `0` will not provide any app store
* `1` will provide **Play Store**
* `2` will provide **Yalp Store** and **Fake Store**

`nanodroid_overlay=[0|1]`

whether to populate the overlay to pseudo-debloat `/system` applications (Magisk-only)

`nanodroid_zelda=[0|1]`

whether to provide The Legend of Zelda ringtones and sounds

`nanodroid_mapsv1=[0|1]`

whether to provide **microG** Maps API v1

`nanodroid_init=[0|1]`

whether to provide init scripts

`nanodroid_gsync=[0|1]`

whether to provide Google Sync Adapters

`nanodroid_swipe=[0|1]`

whether to provide Swipe libraries

`nanodroid_forcesystem=[0|1]`

whether to force system mode installation, regardless whether Magisk is installed

`nanodroid_nlpbackend=[0|1|2]`

what location backend for microG to install
* 0 = no location backend
* 1 = Déjà Vu location backend
* 2 = Ichnaea (Mozilla) location backend
* 3 = Déjà Vu and Ichnaea location backends

`nanodroid_bash=[0|1]`

whether to install GNU Bash Shell

`nanoroid_nano=[0|1]`

whether to install GNU Nano Editor

`nanodroid_utils=[0|1]`

whether to install Shell Utils from util-linux and bsdmainutils

`nanodroid_fonts=[0|1]`

whether to install [NanoDroid-Font](NanoDroidFont.md) script and Nintendo Fonts
