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
* E-Mail
* Exchange2
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

CyanogenMod su binary will be removed:

* /system/bin/su
* /system/xbin/su

The following system applications can be choosen to be installed:

* AdAway
* Amaze (File Manager)
* Face Slim (Facebook client)
* F-Droid
* Hacker's Keyboard
* K9-Mail
* Kernel Adiutor
* LeafPic (Gallery)
* Lightning (Browser)
* MagiskManager
* New Pipe (YouTube client)
* Oandbackup (App backup and restore)
* Odyssey (Audio player)
* Open Camera
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

* Magisk (with builtin PHH SuperUser)
* Nano-Init (a few init scripts)
* Nano-Miitomo (prevents Miitomo crashes on Custom ROMs)
* Nano-Selinux-Enforce (enforces Selinux, aids in passing SafetyNet)¹

¹ not installed by default since version 3.1, as Magisk does now have pseudo
  enforcing mode built-in

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

* Download stable release from:
  - https://www.androidfilehost.com/?a=show&w=files&flid=150729
* or create zip file from this repository
  - on GNU/Linux or BSD (or compatible) you can use the provided
    mod.sh script like `mod.sh zip`
* perform full wipe
* install desired ROM (make sure it does NOT include GApps, if you choose microG!)
* install desired Kernel (if any)
* install NanoMod
  * if you have choosen microG
    - in TWRP mount system partition
    - get Tingle from https://github.com/ale5000-git/tingle
    - execute Tingle and choose ADB as source for framework
    - Tingle will now patch your framework.jar in order for
    microG to work
* reboot into system
  * if you have choosen microG
    - go into 'microG settings' and set up everything, check results
      in 'self check' lists, once done, reboot
    - go to playstore, setup account as usual and install yer apps

SafetyNet
=========

To pass SafetyNet enable MagiskHide in MagiskManager. Make sure
your ROM/Kernel sets Selinux to permissive, as Magisk v11 does
have it's own pseudo-enforcing Selinux mode.

After enabling Magisk Hidereboot.

Hiding Root from Apps
=====================

After enabling Magisk Hide and reboot go to MagiskManager again,
you'll now notice a new 'MagiskHide' settings tab. In this tab
you can select any application root should be hidden for. No reboot
is required for this to take effect.

Note: don't select too many apps (10+), else MagiskHide may be too
slow to actually hide root before the application checks for it.

FAQ
===

Q: will there be a GApps version, instead of microG?
A: no, but you can opt-in to not install microG, then flash
   OpenGApps if you feel like.

Q: will there be support for x86?
A: x86 support is not planned currently.

Q: what devices was this tested on?
A: Moto X Play (lux), Samsung Galaxy Tab 4 (matissewifi)

Q: what ROMs was this tested on?
A: Resurrection Remix, AICP, AOSP Extended, should work on any
   LineageOS based ROM.
