# Pseudo-Debloated applications

## Default Settings

The following applications are pseudo-debloated by default

* Basic Dreams
* Calendar
* CM File Manager
* Eleven, Phonograph (Audio Player)
* E-Mail + Exchange2
* Browser, Gello, Slimperience, Via Browser (Browser)
* PhotoTable
* Sound Recorder, Recorder
* messaging (SMS & MMS)
* Wallpaper, WallpaperPickerGoogle (Google Wallpaper application)
* Wallpaper Backup
* mGerrit
* FM Radio
* Gallery2
* OmniSwitch
* Screencast
* Snap, Snapdragon Camera (Camera)
* Resurrection Remix Statistics
* Sim Toolkit
* Pixel Launcher, Nexus Launcher
* Trebuchet

## Alter the list of pseudo-debloated applications

**This feature is only available when installing as Magisk Module!**

You can add or remove applications from the list by modifying the file

`.nanomod-overlay`

on your device, in one of the following directories

* `/data` (default)
* `/sdcard` (internal storage)
* `/persist`
* mount point of your external SD-Card (if any)
* directory containing the zip file

See the default settings [![GitHub Link](github.png)](.nanomod-overlay). The syntax is pretty simple:

* one item per line
* name must be an exact match
* applications in `/system/app` inside `APPS=( ... )`
* applications in `/system/priv-app` inside `PRIV_APPS=( ... )`

After you've made your changes, issue the following command on your phone, either using `adb shell` or **Termux** as root:

`nanomod-overlay --update`

This needs to be done in normal environment. If you're in **TWRP** you'll have to manually mount `/magisk`. For this you can use the supplied `mount-magisk.sh` script, connect phone to PC while in **TWRP** and run the following commands

```
adb push mount-magisk.sh /tmp/
adb shell
chmod 0755 /tmp/mount-magisk.sh
/tmp/mount-magisk.sh mount-magisk
```

afterwards you can call `nanomod-overlay` like

`/magisk/NanoMod/system/bin/nanomod-overlay --update`

from **TWRP**, aswell. Issue

`/tmp/mount-magisk.sh umount-magisk`

to unmount `/magisk`. Reboot for your changes to get applied. For more options, check:

`nanomod-overlay --help`

respectively

`/magisk/NanoMod/system/bin/nanomod-overlay --help`

from **TWRP**.
