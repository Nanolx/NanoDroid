# NanoMod

* install **Magisk** and **NanoMod** Magisk-Module
  * actually **NanoMod** is an **Overlay** to `/system` which holds the apps
  * allows for a user-defined list of system apps to be made unavailable (let's call this pseudo-debloat feature)
  * disabling the **NanoMod** module in **Magisk** will revert everything, as it's not actually doing any changes to `/system`
  * boot process may take a bit longer as **NanoMod** is a pretty big **Magisk** Module
  * for more information on **Magisk** visit [XDA Magisk Thread](https://forum.xda-developers.com/apps/magisk)
* remove stock **CyanogenMod**/**LineageOS** `su` binary
  * required to pass **SafetyNet**
  * since **LineageOS** (and derivates) now often no longer includes the old `su` implementation no actual change to `/system` is done
* install **microG** with either official **Play Store** or unofficial **Yalp Store**
  * for more information on microG visit [microG Homepage](http://www.microg.org)
  * with **Mozilla** location provider backend
  * with **Nominatim** adress provider backend
  * **microG** GmsCore and **Play Store** modified to allow (in-)app-purchases
* install **F-Droid** and many OpenSource applications
  * including the privileged extension, so you don't need to enable 'Unkown Sources' to use F-Droid
  * for more information on F-Droid visit [F-Droid Homepage](http://www.fdroid.org)
* install GNU **Bash** Shell
* install GNU **Nano** Shell Editor

# Why was this created?

Because I wanted to have a simple way to achieve my desired setup on any device or any ROM. That's it, basically. And since it already exists, I thought I'd push it to XDA aswell. Actually this is the generic version of my NanoROM for Galaxy S6, where I basically made the same changes to the ROM (except NanoMod is for LOS/AOSP based ROMs, not TouchWiz).

# Support

[XDA-Developers Thread](https://forum.xda-developers.com/apps/magisk/module-nanomod-5-0-20170405-microg-t3584928)

# Details

## Versions

* Full package contains **everything** mentioned above
* microG package **only** contains microG and nothing else

## Installation

* Download release build from [Androidfilehost](https://www.androidfilehost.com/?a=show&w=files&flid=150729)
* or create zip file from this repository
  * on Linux/BSD you can use the provided mod.sh script, either
    * `mod.sh zip` for the full package
    * `mod.sh microg` for the microg only package
* perform full wipe
* install desired ROM
  * make sure it does **not** include GApps
* install desired Kernel (if any)
* install NanoMod
  * for **microG** to work, your ROM needs to have fake signature signing enabled
  * to achieve that, use the supplied `framework-patcher.sh`. This shell script for GNU Bash (and compatible shells) works on GNU/Linux, BSD, Solaris and the-like. It automizes the process of downloading [Haystack](https://github.com/Lanchon/haystack), pulling files from phone, patching and populating them in the **NanoMod** Magisk Module.
* reboot into system
  * go into **microG settings** and set up everything like:
    * check results in **Self-Check**, grant missing permissions (by tapping on them)
      * especially the 'Battery Optimization' item
    * enable **Google device registration**
    * enable **Google Cloud Messaging** (only if you want to receive push messages from your applications)
    * enable **Google SafetyNet** (only if you you want to be able to use applications that require SafetyNet, for example AndroidPay, Pokémon GO, ...); set to use the official servers
    * in **UnifiedNlp Settings** choose
      * **Mozilla Location Backend** as Geolocation backend
      * **Nominatim** as Address lockup backend
    * after everything is done, reboot
    * go to **Play Store**, setup account and install your apps

## Alter Installation

To alter the installation you can create the file

`/data/media/0/.nanomod-setup`

on your phone, which can also be accessed or created as

`/sdcard/.nanomod-setup`

populate it with the following content for the **full package**

```
nanomod.unsu=1
nanomod.magisk=1
nanomod.microg=1
nanomod.apps=1
nanomod.play=1
nanomod.reinstall=0
nanomod.overlay=1
nanomod.zelda=1
```

the **microg only package** only supports the following options

```
nanomod.play=1
nanomod.reinstall=0
```

where `1` means `on` and `0` means `off`. Description:

`nanomod.unsu=[0|1]`

whether to *unroot* the phone before installing **Magisk**.

`nanomod.magisk=[0|1]`

whether to install **Magisk**. Note: **NanoMod** only works with **Magisk**, if you choose `0` you likely have it already installed.

`nanomod.apps=[0|1]`

whether to populate **F-Droid** and apps (see below).

`nanomod.microg=[0|1]`

whether to populate **microG**.

`nanomod.play=[0|1|2]`

what app store to use. `0` will not populate any app store, `1` will populate **Play Store**, `2` will populate **Yalp Store**.

`nanomod.overlay=[0|1]`

whether to populate the overlay to pseudo-debloat `/system` applications.

`nanomod.zelda=[0|1]`

whether to populate Zelda ringtones and sounds.

`nanomod.reinstall=[0|1]`

whether to backup an **already patched** `services.jar` and re-use it.

**Only use this, when you re-install NanoMod on the same ROM. If you updated or changed the ROM, re-run `framework-patcher.sh`
instead. See "Installation" below.** 

If no `/data/media/0/.nanomod-setup` is found, the default one will be installed (equals to the example above).

## Applications

### Pseudo-Debloated applications

#### Default Settings

The following applications are pseudo-debloated by default

* Basic Dreams
* CM File Manager
* Eleven (Audio Player)
* E-Mail + Exchange2
* Browser, Gello, Slimperience (Browser)
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
* Pixel Launcher
* Trebuchet

#### Alter the list of pseudo-debloated applications

You can add or remove applications from the list by modifying the file

`/data/media/0/.nanomod-overlay`

on your device, which is also accesible as

`/sdcard/.nanomod-overlay`

See here for the [default settings](.nanomod-overlay). The syntax is pretty simple:

* one item per line
* name must be an exact match
* applications in `/system/app` inside `APPS=( ... )`
* applications in `/system/priv-app` inside `PRIV_APPS=( ... )`

After you've made your changes, issue the following command on your phone, either using `adb shell` or **Termux**:

`nanomod-overlay --update`

This needs to be done in normal environment, not from recovery. If you know how to manually mount `/magisk` in recovery, you can update the overlay using:

`/magisk/NanoMod/system/bin/nanomod-overlay --update`

from recovery, aswell. After reboot your changes get applied. For more options, check:

`nanomod-overlay --help`

respectively

`/magisk/NanoMod/system/bin/nanomod-overlay --help`

from recovery.

### Applications provided by NanoMod

The following applications are magic-mounted as `/system` applications

* AdAway
* Amaze (File Manager)
* Anysoft Keyboard
* Face Slim (Facebook client)
* F-Droid (FOSS app store, including privileged extension)
* Hacker's Keyboard
* K9-Mail
* Kernel Adiutor
* KeyPassDroid (Password Safe)
* (Simple) Gallery
* Lightning (Browser)
* New Pipe (YouTube client)
* Oandbackup (App backup and restore)
* Odyssey (Audio player)
* OpenCamera
* OpenLauncher
* OpenVPN
* QK SMS
* Substratum (App and Compiler)¹
* Termux
* Twidere (Twitter client)
* VLC (Audio/Video Player)
* XDA Labs
* Yahoo Weather Provider

¹ will run in legacy mode on non-OMS ROMs

### Issues

The following applications are having issues:

* microG DroidGuard Helper
  * there's currently an issue with **Magisk** that prevents it from properly working when magic-mounted as `/system` application, see [Magisk Issue #155](https://github.com/topjohnwu/Magisk/issues/155)
  * instead install it as an user app, after installation you'll find DroidGuard Helper in `/sdcard/DroidGuard.apk`

## Magisk & root

**Magisk** allows modifying the ROM in system less fashion, it also brings it's own root solution (**MagiskSU**, which apparently is a fork of **PHH SuperUser**) and an companion application.

Upon **Magisk** installation, any previously installed root solution will be removed. ***(That is, unless you set `nanomod.unsu=0` in `/sdcard/.nanomod-setup` as listed in "Alter Installation" above)***

This is not a **Magisk** requirement, as **Magisk** also works with **SuperSU**, but it's a **NanoMod** requirement by default, as I do not support **SuperSU**, now, where we have a fully OpenSource root solution.

**NanoMod** will also re-flash the boot image backup if you had system less **SuperSU** installed, that is to ensure **MagiskSU** is properly installed and working.

## SafetyNet

To pass SafetyNet enable **MagiskHide** in **Magisk Manager** and reboot.

### Hiding Root from Apps

After enabling **MagiskHide** and reboot go to **Magisk Manager** again, you'll now notice a new **MagiskHide** settings tab. In this tab you can select any application root should be hidden for. No reboot is required for this to take effect.

*Note: don't select too many apps (10+), else **MagiskHide** may be too slow to actually hide root before the application checks for it.*

## Zelda ringtones & sounds

The following **The Legend of Zelda** sounds will be populated

### Notification sounds

* Flute
* Gold Bug Catch
* Hey Listen
* Intro
* Midna Alert
* Secret
* Start
* Vessel

### Ringtones

* Bolero of Fire
* Gerudo Valley
* House Remix (original title theme)
* Lost Woods Dubstep
* Lost Woods
* Market Theme
* Minuet of Forest
* Nocturne of Shadows
* Prelude of Light
* Requiem of Spirits
* Sarias Song
* Serenade of Water
* Shadow World
* Song of Storms
* Song of Time

### User Interface Sounds

* Lock
* LowBattery
* Unlock

## FAQ

```
Q: will there be a GApps version, instead of microG?
A: no. but you can choose not to populate microG.

Q: will there be support for x86?
A: x86 support is not planned currently.

Q: what devices was this tested on?
A: Moto X Play (lux), Samsung Galaxy Tab 4 (matissewifi), Samsung Galaxy S6 (zeroflte)

Q: what ROMs was this tested on?
A: LineageOS, Resurrection Remix, AICP, AOSP Extended, crDroid, should work on any LineageOS / AOSP based ROM that is working with Magisk.
```
