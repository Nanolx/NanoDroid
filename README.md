NanoMod
=======

NanoMod makes several modifications to your ROM:

!!! Note: this README is for version 5.0 and newer (currently in-development)

* install Magisk and NanoMod Magisk-Module
  - actual NanoMod is an Overlay to /system which holds the apps
  - allows for a user-defined list of system apps to be made unavailable
    (let's call this pseudo-debloat feature)
  - disabling the NanoMod module in Magisk will revert everything, as it's
    not actually doing any changes to /system
  - boot process may take a bit longer as NanoMod is a pretty big Magisk Module
  - for more information on Magisk visit [XDA Magisk Thread](https://forum.xda-developers.com/apps/magisk)
* remove stock CM su binary
  - required to pass SafetyNet
  - since LineageOS now often does no longer include that no actual change
    to /system is done
* install microG with official PlayStore
  - for more information on microG visit [microG Homepage](http://www.microg.org)
  - with Mozilla location provider backend
  - with Nominatim adress provider backend
  - microG GmsCore and Play Store modified to allow (in-)app-purchases
* install F-Droid and many OpenSource applications
  - for more information on F-Droid visit [F-Droid Homepage](http://www.fdroid.org)
* install GNU Bash Shell
* install GNU Nano Shell Editor

Why was this created?
=====================

Because I wanted to have a simple way to achieve my desired setup on any device
or any ROM. That's it, basically. And since it already exists, I thought I'd push
it to XDA aswell. Actually this is the generic version of my NanoROM for Galaxy S6,
where I basically made the same changes to the ROM (except NanoMod is for LOS/AOSP
based ROMs, not TouchWiz).

Support
=======

[XDA-Developers Thread](https://forum.xda-developers.com/android/development/nanomod-3-0-20170204-microg-magisk-foss-t3550800)

Details
=======

Applications
============

The following applications are pseudo-debloated by default:

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

You can add or remove applications from the list by modifying the file

`/data/media/0/.nanomod-overlay`

which is also accesible from the device as

`/sdcard/.nanmod-overlay`

See here for the [default settings](.nanomod-overlay). The syntax is pretty simple:

- one item per line
- name must be an exact match
- apps in /system/app inside APPS=( ... )
- apps in /system/priv-app inside PRIV_APPS=( ... )

After you made your changes, issue the following command on your phone,
either using adb shell or Termux:

`nanomod-overlay --update`

After reboot your changes are applied. For more options, check:

`nanomod-overlay --help`

The following applications are magic-mounted as system applications:

* AdAway
* Amaze (File Manager)
* Anysoft Keyboard
* Face Slim (Facebook client)
* F-Droid
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
* OpenVPN
* QK SMS
* Substratum (App and Compiler)¹
* Twidere (Twitter client)
* Yahoo Weather Provider
* OpenLauncher

¹ will run in legacy mode on non-OMS ROMs

The following user applications are directly installed to /data:

* Termux
* XDA Labs
* VLC (Audio/Video Player)

Magisk & root
=============

Magisk allows modifying the ROM in system less fashion, it also
brings it's own root solution (MagiskSU, which apparently is a
fork of PHH SuperUser) and an companion application.

Upon Magisk installation, any previously installed root solution
will be removed. This is not a Magisk requirement, as Magisk also
works with SuperSU, but it's a NanoMod requirement, as I do not
support SuperSU, now, where we have a fully OpenSource root solution.

NanoMod will also re-flash the boot image backup if you had system
less SuperUser installed, that is to ensure MagiskSU is properly
installed and working.

SafetyNet
=========

To pass SafetyNet enable MagiskHide in MagiskManager. Make sure
your ROM/Kernel sets Selinux to permissive, as Magisk v11+ does
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

Zelda Ringtones
===============

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
    If your ROM does not have signature spoofing included (very likely), use
    the supplied framework-patcher.sh. This shell script for GNU Bash (and
    compatible shells) works on GNU/Linux, *BSD, Solaris and the-like. It
    automizes the process of downloading [Haystack](https://github.com/Lanchon/haystack),
    pulling files from phone, mounting /magisk read-write in TWRP, patching files
    and pushing modified files to the device. See `framework-patcher.sh --help`
    for more information.
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
