# Alter Installation

## Configuration File

To alter the installation you can create the file

`.nanomod-setup`

on your device, in one of the following directories

* `/sdcard` (internal storage)
* `/persist`
* `/external_sd` (TWRP path to SD Card (if any))
* directory containing the zip file
* `/data` (fallabck)

populate it with the following content for the **full** package

```
nanomod_microg=1
nanomod_fdroid=1
nanomod_apps=1
nanomod_play=1
nanomod_overlay=1
nanomod_zelda=1
nanomod_mapsv1=1
nanomod_init=1
nanomod_gsync=0
nanomod_swipe=0
nanomod_forcesystem=0
nanomod_reinstall=0
```

the **microG** package supports the following options

```
nanomod_play=1
nanomod_overlay=0
nanomod_mapsv1=1
nanomod_gsync=0
nanomod_swipe=0
nanomod_forcesystem=0
nanomod_reinstall=0
```

the **F-Droid** package supports the following options

```
nanomod_forcesystem=0
```

where `1` means `on` and `0` means `off`. If no `.nanomod-setup` is found, the default settings [![GitHub Link](github.png)](.nanomod-setup) will be used (equals to the example above), if your `.nanomod-setup` file exists, but is missing entries, those entries will be added, using the default values.

## Detailed Description

`nanomod_microg=[0|1]`

whether to provide **microG**

`nanomod_fdroid=[0|1]`

whether to provide **F-Droid**

`nanomod_apps=[0|1]`

whether to provide included applications [![GitHub Link](doc/github.png)](doc/Applications.md)

`nanomod_play=[0|1|2]`

what app store to use:
* `0` will not provide any app store
* `1` will provide **Play Store**
* `2` will provide **Yalp Store** and **Fake Store**

`nanomod_overlay=[0|1]`

whether to populate the overlay to pseudo-debloat `/system` applications (Magisk-only)

`nanomod_zelda=[0|1]`

whether to provide The Legend of Zelda ringtones and sounds

`nanomod_mapsv1=[0|1]`

whether to provide **microG** Maps API v1

`nanomod_init=[0|1]`

whether to provide init scripts

`nanomod_gsync=[0|1]`

whether to provide Google Sync Adapters

`nanomod_swipe=[0|1]`

whether to provide Swipe libraries

`nanomod_forcesystem=[0|1]`

whether to force system mode installation, regardless whether Magisk is installed

`nanomod_reinstall=[0|1]`

whether to backup an **already patched** `services.jar` and re-use it

**Only use this, when you re-install NanoMod on the same ROM. If you updated or changed the ROM, re-run `framework-patcher.sh` instead or re-flash the NanoMod-patcher.**
