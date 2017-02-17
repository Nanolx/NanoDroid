NanoMod
=======

NanoMod makes several modifications to your ROM:

* user-friendly AROMA installer
* debloat ROM and remove stock CM su binary
* install microG and Play Store
  - for more information on microG visit [microG Homepage](http://www.microg.org)
  - with Mozilla location provider backend
  - with Nominatim adress provider backend
* install F-Droid and many OpenSource applications
  - for more information on F-Droid visit [F-Droid Homepage](http://www.fdroid.org)
* install The Legend of Zelda tunes
* install Magisk and companion modules
  - for more information on Magisk visit [XDA Magisk Thread](https://forum.xda-developers.com/apps/magisk)
* install GNU Bash Shell
* install GNU Nano Shell Editor

Details
=======

The following applications can be choosen to be removed:

* Basic Dreams
* CM File Manager
* Eleven (Audio Player)
* E-Mail + Exchange2
* Browser, Gello, Slimperience (Browser)
* PhotoTable
* Sound Recorder, Recorder
* Nexus Launcher
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

CyanogenMod su binary will be removed if Magisk is choosen to
be installed:

* /system/bin/su
* /system/xbin/su

The following system applications can be choosen to be installed:

* AdAway
* Amaze (File Manager)
* Anysoft Keyboard
* Face Slim (Facebook client)
* F-Droid
* Hacker's Keyboard
* K9-Mail
* Kernel Adiutor
* KeyPassDroid (Password Safe)
* LeafPic (Gallery)
* Lightning (Browser)
* MagiskManager
* New Pipe (YouTube client)
* Oandbackup (App backup and restore)
* Odyssey (Audio player)
* OpenCamera
* OpenVPN
* QK SMS
* Substratum (App and Compiler)¹
* Twidere (Twitter client)
* Yahoo Weather Provider

¹ will run in legacy mode on non-OMS ROMs

The following user applications can be choosen to be installed:

* Termux
* XDA Labs
* VLC (Audio/Video Player)

The following Magisk Modules can be choosen to be installed:

* Magisk (with builtin SuperUser)
* Nano-Init (a few init scripts)
* Nano-Miitomo (prevents Miitomo crashes on Custom ROMs)

The following The Legend of Zelda can be choosen to be installed (all or none):

::Notification sounds

* Flute
* Gold Bug Catch
* Hey Listen
* Intro
* Midna Alert
* Secret
* Start
* Vessel

::Ringtones

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

::User Interface Sounds

* Effect_Tick (sound when pressing something)
* Lock
* LowBattery
* Unlock

Installation
============

* Download stable release from [Androidfilehost](https://www.androidfilehost.com/?a=show&w=files&flid=150729)
* or create zip file from this repository
  - on Linux you can use the provided mod.sh script: `mod.sh zip`
* perform full wipe
* install desired ROM
  - make sure it does NOT include GApps, if you choose microG!)
* install desired Kernel (if any)
* install NanoMod
  * if you have choosen microG you need to patch the framework for signature
    spoofing. Some ROMs already include support for that, for example crDroid.
    If your ROM does not have signature spoofing included (very likely), patch
    the framework manually like:
    - in TWRP mount system partition
    - get [Tingle](https://github.com/ale5000-git/tingle) framework patcher
    - execute Tingle and choose ADB as source for framework
    - your framework.jar will now be patched for microG to work
* reboot into system
  * if you have choosen microG
    - go into 'microG settings' and set up everything like:
      + check results in 'Self-Check', grant missing
        permissions (by tapping on them)
      + enable 'Google device registration'
      + enable 'Google Cloud Messaging' (only if you want to
        receive push messages from your applications)
      + enable 'Google SafetyNet' (only if you you want to
        be able to use applications that require SafetyNet,
        for example AndroidPay, Pokemon GO, ...), set to
        use the official servers
      + under 'UnifiedNlp Settings' choose
        + 'Mozilla Location Backend' as Geolocation backend
        + 'Nominatim' as Address lockup backend
    - after everything is done, reboot
    - go to playstore, setup account and install your apps

SafetyNet
=========

To pass SafetyNet enable MagiskHide in MagiskManager. Make sure
your ROM/Kernel sets Selinux to permissive, as Magisk v11 does
have it's own pseudo-enforcing Selinux mode.

After enabling MagiskHide reboot.

Hiding Root from Apps
=====================

After enabling MagiskHide and reboot go to MagiskManager again,
you'll now notice a new 'MagiskHide' settings tab. In this tab
you can select any application root should be hidden for. No reboot
is required for this to take effect.

Note: don't select too many apps (10+), else MagiskHide may be too
slow to actually hide root before the application checks for it.

FAQ
===

* Q: will there be a GApps version, instead of microG?
* A: no, but you can opt-in to not install microG, then flash
   OpenGApps if you feel like.

* Q: will there be support for x86?
* A: x86 support is not planned currently.

* Q: what devices was this tested on?
* A: Moto X Play (lux), Samsung Galaxy Tab 4 (matissewifi)

* Q: what ROMs was this tested on?
* A: Resurrection Remix, AICP, AOSP Extended, crDroid, should work
   on any LineageOS based ROM.
