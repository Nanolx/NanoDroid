# Pseudo-Debloated applications

Magisk allows for apps to be magically removed upon runtime, they don't get actually removed from `/system` but they are pseudo-removed during runtime. The pseudo-debloat feature is not available when NanoMod is installed in System Mode

## Default Settings

The following applications are pseudo-debloated by default

* Basic Dreams
* Calendar
* CM File Manager
* crDroid Filemanager and Music Player
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

## Alter the list of pseudo-debloated applications

**This feature is only available when installing as Magisk Module!**

You can pseudo-debloat applications by adding them to configuration file

`.nanomod-overlay`

on your device, in one of the following directories

* `/sdcard` (internal storage)
* `/external_sd` (TWRP path to SD Card (if any))
* directory containing the zip file
* `/data` (fallabck)

See the [default settings](.nanomod-overlay).

Alternatively you can also use the NanoMod Setup Wizard package instead of manual creation of the configuration file.

The syntax is pretty simple:

* one app per line
* name must be an exact match

After you've made your changes, issue the following command on your device, either using `adb shell` or **Termux** as root:

`nanomod-overlay --update`

This needs to be done in normal environment. If you're in **TWRP** you'll have to manually mount `/magisk` (you may use the `mount-magisk` script from the git repo for this purpose).

## Additional options

The `nanomod-overlay` script has more options available, see [> nanomod-overlay](NanoModOverlay).
