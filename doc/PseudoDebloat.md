# Pseudo-Debloated applications

Magisk allows for apps to be magically removed upon runtime, they don't get actually removed from `/system` but they are pseudo-removed during runtime. The pseudo-debloat feature is not available when NanoMod is installed in System Mode

## Default Settings

The following applications are pseudo-debloated by default

* Basic Dreams
* Calendar
* CM File Manager
* Eleven, Phonograph (Audio Player)
* E-Mail + Exchange2
* Browser, Gello, Slimperience, Via Browser, Jelly (Browser)
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

After you've made your changes, issue the following command on your device, either using `adb shell` or **Termux** as root:

`nanomod-overlay --update`

This needs to be done in normal environment. If you're in **TWRP** you'll have to manually mount `/magisk`.

For more options, check

`nanomod-overlay --help`
