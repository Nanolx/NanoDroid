# NanoDroid-Overlay Script

## Purpose

The `nanodroid-overlay` Script, respectively it's shortcut `novl` is used by NanoDroid to handle the

  * Pseudo Debloat Feature (Magisk Mode)
  * Foce Debloat Feature (System Mode)

### Pseudo Debloat Feature

Magisk allows for apps to be magically removed upon runtime, they don't get actually removed from `/system` but they are pseudo-removed during runtime.

### Force Debloat Feature

In System Mode apps can are moved to `/sdcard/nanodroid_backups/` or restored from there.

## Default Settings

The following applications are debloated by default

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

### Alter the list of pseudo-debloated applications

You can pseudo-debloat applications by adding them to configuration file

`.nanodroid-overlay`

on your device, in one of the following directories

* `/sdcard` (internal storage)
* `/external_sd` (TWRP path to SD Card (if any))
* directory containing the zip file
* `/data` (fallabck)

See the [default settings](.nanodroid-overlay).

Alternatively you can also use the NanoDroid Setup Wizard package instead of manual creation of the configuration file.

The syntax is pretty simple:

* one app per line
* name must be an exact match

After you've made your changes, issue the following command on your device, either using `adb shell` or **Termux** as root:

`nanodroid-overlay --update`

This needs to be done in normal environment. If you're in **TWRP** you'll have to manually mount `/magisk` (you may use the `mount-magisk` script from the git repo for this purpose).

## Invocation

From within a terminal on your device, for example `adb shell` or `Termux` invoke the script using either

`nanodroid-overlay [switch] [parameter(s)]`

or

`novl [switch] [parameter(s)]`

## Overview

`-a`, `--add` [app]

add Overlay for **app** (if it exists) and add it to the config file; [app] is the name of the app's directory in `/system/app` or `/system/priv-app`

`-r`, `--remove` [app]

remove Overlay for **app** (if it exists) and remove it from the config file; [app] is the name of the app's directory in `/system/app` or `/system/priv-app`

`-s`, `--show`

show all apps that **don't** have an Overlay (slow)

`-l`, `--list`

show all apps that **do** have an Overlay

`-x`, `--create`

create Overlays from config file

`-u`, `--update`

**The following features are only available in Magisk Mode:**

remove existing Overlays and re-create them from the config file

`-c`, `--clear`

remove existing Overlays

`-g`, `--genconfig`

(re-)create config file from existing Overlays
