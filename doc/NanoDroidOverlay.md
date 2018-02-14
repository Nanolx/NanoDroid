# nanodroid-overlay Script

## Purpose

The `nanodroid-overlay` Script, respectively it's shortcut `novl` is used by NanoDroid to perform various actions.

### Magisk-Only Features

The following features are **only** available, when NanoDroid is installed as Magisk Module:

* Pseudo-Debloat Feature
* utilize Magisk's `resetprop` feature for on-the-fly and permanently adjusting system properties

### General Features

The following features are available in **both** Magisk and System Mode:

* grant signature spoofing permissions to microG GmsCore / Play Store
  * on pre-patched ROMs that is
* grant required permissions to Google Sync Adapters
* fix navigation bar, status bar or lock screen issues after OTA update
* change Airplane Mode radio settings
* prevent applications from stealing audio focus
* prevent applications from reading the clipboard
* display device's boot count
  * requires Android 7.0 or newer

## Invocation

From within a terminal on your device, for example `adb shell` or `Termux` invoke the script using either

`nanodroid-overlay [switch] [parameter(s)]`

or

`novl [switch] [parameter(s)]`

## Feature overview

### Pseudo-Debloat feature (Magisk-Only)

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

remove existing Overlays and re-create them from the config file

`-c`, `--clear`

remove existing Overlays

`-g`, `--genconfig`

(re-)create config file from existing Overlays

### Utilize resetprop (Magisk-Only)

`-C`, `--cast`

set properties required to enable the cast feature on some custom ROMs

`-A`, `--add-prop` [prop] [value]

add a system property both on-the-fly and permanently by adding it to NanoDroid's `system.prop` file

`-R`, `--remove-prop` [prop]

remove a system property from NanoDroid's `system.prop` file

`-L`, `--list-prop`

list all properties from NanoDroid's `system.prop` file

### Grant signature spoofing permission

`-p`, `--permission`

grant signature spoofing permission to microG GmsCore and Play Store; grant permission to Google Sync Adapters (if they are installed)

### Fix OTA-Update issues

`-f`, `--fix-update`

fix issues with the navigation bar, status bar or lock screen after applying an OTA update; for a detailed description about this check [> XDA](https://www.xda-developers.com/broken-navigation-bar-lock-screen-ota-update/)

### Airplane Mode settings

`-P`, `--airplane-mode`

change Airplane Mode settings, this is interactive, user will be given instructions what to do. This allows to change which radios are disabled by Airplane Mode **and additionally** it instructs Android that it does **not** allow re-activation of **those** radios until Airplane Mode is switched off

### Prevent audio focus stealing

`-F`, `--audio-focus` [app]

some apps stop audio playback of other apps, when you bring them in foreground (or activate them in multi window mode), with this you can prevent Android from allowing this; [app] is the application name in `com.organisation.application` format, for example `com.xda.labs`

### Prevent clipboard reading

`-B`, `--read-clipboard` [app]

many apps have the permission to read the clipboard for no reason, with this you can prevent Android from allowing this; [app] is the application name in `com.organisation.application` format, for example `com.xda.labs`

**Note:** don't do this in applications like Browsers or the-like, as you'll disable the whole copy-paste feature for those app(s) with this feature

### Read boot count

`-b`, `--boot-count`

show how often the device was booted; requires Anroid 7.0 or newer

### Update custom APKs

`-U`, `--update-apks`

update custom NanoDroid apks:

* Fake Store
* Play Store
* MPV
* OpenLauncher
