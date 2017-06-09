# Alter Installation

To alter the installation you can create the file

`.nanomod-setup`

on your device, in one of the following directories

* `/data` (default)
* `/sdcard` (internal storage)
* `/persist`
* mount point of your external SD-Card (if any)
* directory containing the zip file

populate it with the following content for the **full package**

```
nanomod.microg=1
nanomod.fdroid=1
nanomod.apps=1
nanomod.play=1
nanomod.reinstall=0
nanomod.overlay=1
nanomod.zelda=1
nanomod.mapsv1=1
nanomod.init=1
```

the **microg only package** only supports the following options

```
nanomod.play=1
nanomod.reinstall=0
nanomod.overlay=0
nanomod.mapsv1=1
```

where `1` means `on` and `0` means `off`. See the default settings [![GitHub Link](images/github.png)](.nanomod-setup). Description:

`nanomod.fdroid=[0|1]`

whether to populate **F-Droid**.

`nanomod.apps=[0|1]`

whether to populate FOSS apps (see below).

`nanomod.microg=[0|1]`

whether to populate **microG**.

`nanomod.mapsv1=[0|1]`

whether to provide **microG** Maps API v1.

`nanomod.play=[0|1|2]`

what app store to use. `0` will not populate any app store, `1` will populate **Play Store**, `2` will populate **Yalp Store**.

`nanomod.overlay=[0|1]`

whether to populate the overlay to pseudo-debloat `/system` applications.

`nanomod.zelda=[0|1]`

whether to populate Zelda ringtones and sounds.

`nanomod.init=[0|1]`

whether to install init scripts.

`nanomod.reinstall=[0|1]`

whether to backup an **already patched** `services.jar` and re-use it.

**Only use this, when you re-install NanoMod on the same ROM. If you updated or changed the ROM, re-run `framework-patcher.sh` instead. See "Installation" below.** 

If no `.nanomod-setup` is found, the default one will be installed (equals to the example above).
