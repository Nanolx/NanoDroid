# NanoMod

## Current Stable Release

11.1.20170714

## Downloads

* Stable Downloads [> Androidfilehost](https://www.androidfilehost.com/f/NanoMod_Stable)
  * Archived Stable Downloads [> Androidfilehost](https://www.androidfilehost.com/f/NanoMod_StableArchive)
* Beta Downloads [> Androidfilehost](https://www.androidfilehost.com/f/NanoMod_Beta)
  * Archived Beta Downloads [> Androidfilehost](https://www.androidfilehost.com/f/NanoMod_BetaArchive)
* Snapshot
  * on GNU/Linux, MacOS or *BSD clone this repository and use the provided `build-package` script like
    * `build-package full` for the full package
    * `build-package microg` for the microg only package
    * `build-package fdroid` for the F-Droid only package
    * `build-package patcher` for the on-device framework-patcher package
    * `build-package uninstaller` for the uninstaller package
    * `build-package setupwizard` for the Setup Wizard package
    * `build-package all` for all packages at once

## Support

[> XDA](https://forum.xda-developers.com/apps/magisk/module-nanomod-5-0-20170405-microg-t3584928) Support Thread

## ChangeLog

Full, user-readible [> ChangeLog](ChangeLog.md)

## Summary

**NanoMod** can be installed as a Magisk Module or directly to /system, though a bit functionality is only available with Magisk.

More information about Magisk [> XDA](https://forum.xda-developers.com/apps/magisk)

NanoMod includes

* microG and it's companions
  * on-device framework-patcher for microG support (signature spoofing)
  * on-pc framework-patcher for microG support (signature spoofing)
  * both patchers create the `/system/.nanomod-patcher` file after patching
* F-Droid and it's privileged extension
* modified Play Store to allow (in-)app-purchases with microG
  * this required two steps
    * microG Gms Core and Play Store need to be signed with the same key
    * Play Store needs to be modified see the [> patch](doc/Phonesky.diff)
  * alternatively Yalp Store can be installed instead
* custom init scripts
* pseudo-debloat feature (Magisk-only)
  * disables applications systemless-ly
  * pre-configured default settings
* several Open Source applications
  * include replacements for the pseudo-debloated applications
* additional components
  * GNU Bash shell
  * GNU Nano terminal editor
* The Legend of Zelda ringtones and sounds

## Packages

* **NanoMod**: includes
  * everything mentioned in the Summary
* **NanoMod-microG**: includes
  * microG and it's companions
  * GNU Bash
  * pseudo-debloat feature
  * app store
* **NanoMod-fdroid**: includes
  * F-Droid and it's privileged extension
* **NanoMod-patcher**: includes
  * on-device framework-patcher
  * creates the file `/system/.nanomod-patcher` after successful patching
* **NanoMod-setupwizard**: includes
  * AROMA based Setup Wizard to create the configuration files
  * user can choose where to store the configuration files
    * `/sdcard`
    * `/external_sd`
    * `/data` (fallback)
* **NanoMod-uninstaller**: includes
  * uninstalls any NanoMod Magisk Module
  * uninstalls NanoMod installed in System Mode aswell
* **framework-patcher** (clone this repository)
  * on-pc framework-patcher
  * creates the file `/system/.nanomod-patcher` after successful patching
* **force-debloat** (clone this repository)
  * system debloater
  * the list of applications resides in the script itself
  * needs to be run from TWRP, requires explicit user acceptance
* **mount-magisk** (clone this repository)
  * script to mount or unmount Magisk in TWRP
  * script toggles mount-state (read: will mount Magisk if unmounted and unmount Magisk if mounted)

## Details

### NanoMod

This lists features unique to NanoMod.

#### nanomod-overlay

The `nanomod-overlay` script handles the following features

* pseudo-debloat (Magisk-only)
  * show the list of pseudo-debloated apps
  * add or remove apps from the list of pseudo-debloated apps
* grant signature spoofing permission to microG and Play Store if required
  * both in Magisk and System Mode
* issue `nanomod-overlay --help` for the full list of options

Full details on the pseudo-debloat feature [> Details](doc/PseudoDebloat.md)

#### init scripts

The following init scripts are bundled with NanoMod

* external_sd
  * symlink SD Card mount point to `/external_sd`
  * SD Card needs to be inserted upon boot
* fstrim
  * trim file systems (may increase speed)
* logscleaner
  * clean up log files
* sqlite
  * clean up sqlite databases
* permission
  * set proper permission for microG & Co. on pre-patched ROMs

When in Magisk Mode the init scripts create their log files in

  `/magisk/NanoMod/.logs/${script}.log.${date}`

When installed to /system your ROM needs to support running scripts in

  `/system/etc/init.d`

or you can use **Kernel Adiutor's** init.d emulation.

#### Shell Utilities

Several utilities from `bsdmainutils` and `util-linux` are included:

* col
* colcrt
* colrm
* column
* findfs
* findmnt
* hexdump
* look
* lsblk
* lscpu
* lsipc
* lslocks
* lsns
* ncal
* setterm
* whereis

Other shell utilities

* aapt
* less
* lessecho
* lesskey
* unzip

### microG

microG is an Open Source replacement for Google Services, full details can be found at the microG homepage [> Website](http://microg.org/)

NanoMod includes microG as follows

* microG GmsCore [> GitHub](https://github.com/microg/android_packages_apps_GmsCore) and Play Store [> APK Mirror](https://www.apkmirror.com/apk/google-inc/google-play-store/)  modified to allow (in-)app purchases
* with **Mozilla** location provider backend [> F-Droid](https://f-droid.org/repository/browse/?fdfilter=mozilla&fdid=org.microg.nlp.backend.ichnaea)
* with **Nominatim** adress provider backend [> F-Droid](https://f-droid.org/repository/browse/?fdfilter=nominatim&fdid=org.microg.nlp.backend.nominatim)
* with **microG** GsfProxy [> GitHub](https://github.com/microg/android_packages_apps_GsfProxy)
* with **microG** DroidGuard Helper [> GitHub](https://github.com/microg/android_packages_apps_RemoteDroidGuard)
  * required for SafetyNet support
* support for Maps API version 1
* support for Google Calendar and Contacts Sync
  * disabled by default
* optional Swipe libraries
  * disabled by default
* choose between official **Play Store** or unofficial **Yalp Store** [> F-Droid](https://f-droid.org/repository/browse/?fdfilter=yalp&fdid=com.github.yeriomin.yalpstore)
  * **Yalp Store** can use system permissions to install packages, so you don't need to enable `Unknown Sources`
    * got to **Yalp Store** > Settings > Installation Method > `Using system permissions`

### F-Droid and Applications

F-Droid [> Website](http://www.fdroid.org) is an app store for Open Source applications.

NanoMod includes both F-Droid and it's Privileged Extension [> F-Droid](https://f-droid.org/repository/browse/?fdfilter=f-droid&fdid=org.fdroid.fdroid.privileged), so you don't need to enable `Unknown Sources`.

Additionally NanoMod includes a variety of applications, check full details [> GitHub](doc/Applications.md)

### The Legend of Zelda ringtones and sounds

NanoMod includes **The Legend of Zelda** [> Nintendo](http://www.zelda.com/) ringtones and sounds, because it's dangerous to root alone.

Full [> Details](doc/ZeldaSounds.md)

## Installation

### Alter Installation

NanoMod supports altering the installation settings to a certain degree.

Full details on altering installation [> Details](doc/AlterInstallation.md)

### Installation Process

#### NanoMod

* Download pre-built or create a zip file from this repository
* perform full wipe (/system, /data, /cache, Dalvik/ART cache)
  * recommended, but not required
* install desired ROM
  * make sure it does **not** include GApps if you want to use microG
  * either pre-patched with signature spoofing support or **deoxeded** so you can patch yourself (instructions follow)
* install desired Kernel (if any)
* install **Magisk**
  * recommended, but not required
  * if **Magisk** is installed, NanoMod will be installed as Magisk-Module, else it will install into `/system` directly
* install **NanoMod**
* reboot into ROM

#### microG

For **microG** to work, your ROM needs to have signature spoofing enabled (or a **deodexed** ROM to patch yourself).

If your ROM does not have signature spoofing support, you can manually patch it using either
  * the on-device framework-patcher zip
    * flash after booting into the ROM once
  * the `framework-patcher` script (found in the github repository)
    * use from your PC or laptop while your device is in TWRP. This shell script for GNU Bash (and compatible shells) works on unixoid operating systems like GNU/Linux, BSD or MacOS. It automizes the process of downloading Haystack [> GitHub](https://github.com/Lanchon/haystack), pulling files from phone, patching and installing the modified **services.jar** on the device.

Both patchers support installing the patched services.jar into the following locations
  * NanoMod Magisk Module
  * NanoMod-microG Magisk Module
  * directly into `/system`

So you can use them regardless whether you're using NanoMod or not.

Once your ROM supports signature spoofing, you need to setup microG like this
  * go into **microG settings** and set up everything like:
    * check results in **Self-Check**, grant missing permissions (by tapping on them)
      * especially the 'Battery Optimization' item
    * enable **Google device registration**
    * enable **Google Cloud Messaging** (only if you want to receive push messages from your applications)
    * enable **Google SafetyNet** (required for applications that utilize SafetyNet, for example Pokémon GO, ...)
      * menu > set to use the official servers
    * in **UnifiedNlp Settings** choose
      * **Mozilla Location Backend** as Geolocation backend
      * **Nominatim** as Address lockup backend
    * after everything is done, reboot
    * go to **Play Store**, setup account and install your apps

## License & Credits

My own work (NanoMod itself) is licensed under the GNU General Public License version 3 or newer [> GNU](https://www.gnu.org/licenses/gpl-3.0.txt)

For more details (including authors and license) on every provided application or Software press the icon next to it.

Additional credits go to

* Mar-V-In for microG
* topjohnwu for Magisk
* Lanchon for dexpatcher and haystack
* osm0sis for GNU Nano build

Special Thanks to the beta testers

* xenithorb
* ShapeShifter499

## Issues

List of known issues

* microG DroidGuard Helper or Play Store crashing
  * there's currently an issue with **Magisk** that prevents microG DroidGuard Helper or Play Store from properly working when magic-mounted as `/system` application, see Magisk Issue 155 [> GitHub](https://github.com/topjohnwu/Magisk/issues/155)
  * this does not happen on all devices
  * if you are affected of this issue, instead install them as an user app, by installing the apk from
    * `/system/priv-app/DroidGuard/DroidGuard.apk` for microG DroidGuard Helper
    * `/system/priv-app/Phonesky/Phonesky.apk` for Play Store
* SafetyNet check fails with `can't connect to Google API`
  * see `microG DroidGuard Helper or Play Store crashing` above and install microG DroidGuard Helper as user application
* SafetyNet check fails with `Google Play Services not available`
  * you did not setup microG (or did not reboot afterwards)
* Play Store lacks fake signature spoofing permission
  * on ROMs like **crDroid** or **OmniROM**, that have built-in signature spoofing, in some cases the Play Store is not granted that permission automatically, to fix this either
    * issue the command `nanomod-overlay --permission` as root
    * go to Settings > Apps > Gear Icon > App Permissions > `Signature Spoofing` > Enable for Play Store
* Google Sync adapters lacking permissions
  * to fix this either
    * issue the command `nanomod-overlay --permission` as root
    * go to Settings > Apps > Google Contacts/Calendar Sync > Permissions > grant permissions
* Battery Drain
  * microG fails to register applications  to GCM (Google Cloud Messaging) if they were installed **before** microG, but the apps keep trying to register and that causes the battery drain, all apps installed **after** microG are properly registered, to fix the battery drain either
    * do a clean flash of your ROM (, Magisk) and NanoMod and install your apps after microG setup
    * uninstall and re-install all your applications (backup application data if required)

Additional helpful information in the microG [> Wiki](https://github.com/microg/android_packages_apps_GmsCore/wiki/Helpful-Information).

## TODO

* better error handling in **on-pc** framework-patcher

## FAQ

```
Q: will there be a GApps version, instead of microG?
A: no. but you can choose not to populate microG.

Q: what devices was this tested on?
A: Moto X Play (lux), Samsung Galaxy Tab 4 (matissewifi), Samsung Galaxy S6 (zeroflte)

Q: what ROMs was this tested on?
A: LineageOS, Resurrection Remix, AICP, AOSP Extended, crDroid, should work on any LineageOS / AOSP based ROM that is working with Magisk.
```
