# NanoDroid

Versions until 15.1 were called **NanoMod**, starting with 16.0 they're called **NanoDroid**.

## Current Release

* Stable: 16.1.20180209
* Beta: ---

## Downloads

### Primary Mirror

On AndroidFileHost **all** stable and beta releases are available.

* Stable Downloads [> Androidfilehost](https://www.androidfilehost.com/f/NanoDroid_Stable)
  * Archived Stable Downloads [> Androidfilehost](https://www.androidfilehost.com/f/NanoDroid_StableArchive)
* Beta Downloads [> Androidfilehost](https://www.androidfilehost.com/f/NanoDroid_Beta)
  * Archived Beta Downloads [> Androidfilehost](https://www.androidfilehost.com/f/NanoDroid_BetaArchive)

### Secondary Mirror

On Nanolx the latest stable and beta releases are available, no previous releases.

* Stable Downloads [> Nanolx](https://downloads.nanolx.org/NanoDroid/Stable)
* Beta Downloads [> Nanolx](https://downloads.nanolx.org/NanoDroid/Beta)

### Snapshots

You can create snapshots from this repository.

* on GNU/Linux, MacOS or *BSD clone this repository and use the provided `build-package` script like
  * first step:
     * `build-package pull` to download all required apks for Full, microG and F-Droid package
  * second step:
     * `build-package full` to create the full package
     * `build-package microg` to create the microG only package
     * `build-package fdroid` to create the F-Droid only package
     * `build-package patcher` to create the on-device framework-patcher package
     * `build-package uninstaller` to create the uninstaller package
     * `build-package setupwizard` to create the Setup Wizard package
     * `build-package all` to create all packages at once
  * third step:
     * `build-package u-microg` to update microG
     * `build-package u-fdroid` to update F-Droid
     * `build-package u-apps` to update (most) applications
     * `build-package u-swipe` to update swipe libraries
     * `build-package u-gsync` to update Google Sync Adapters
     * `build-package pull` to update/re-download everything

for apks downloaded from F-Droid or microG repository or from APK Mirror, `build-package` checks the SHA256 hash.

The `build-package` script additionally supports the following parameters:

* `check` check if all files were properly downloaded
* `clean` remove any untracked files from the repo (e. g. from `build-package pull`)
* `dalvik [.jar]` prepare a jar file for use with DalvikVM
* `ver [version] [date]` change project version
* `bump` increment Magisk module version by 1

the `build-package` script does not download/update the following applications:

* Play Store (reason: re-signed and modified to support (in-)app-purchases with microG GmsCore)
* Fake Store (reason: built with CHECK_LICENSE permission)
* OpenLauncher (reason: last F-Droid build outdated)

those are still included in the repo itself. Also `build-package` looks if the configuration files

* `.nanodroid-setup`
* `.nanodroid-apps`
* `.nanodroid-overlay`

exist in the `data` directory of the repository, if so, those files are used when creating packages instead of the default ones from the `doc` directory.

See the documentation below for more information on those files and what they do.

## Supported Android Versions

NanoDroid officially supports the following Android versions:

* 4.4 / SDK 19 (KitKat)
  * System Mode only (Magisk does not support KitKat)
* 5.0 / SDK 21 (Lollipop)
* 5.1 / SDK 22 (Lollipop)
* 6.0 / SDK 23 (Marshmallow)
* 7.0 / SDK 24 (Nougat)
* 7.1 / SDK 25 (Nougat)
* 8.0 / SDK 26 (Oreo)
* 8.1 / SDK 27 (Oreo)

earlier versions will never officially be supported (you may still report bugs, though).

Future versions will be officially supported, eventually.

## Support

[> XDA](https://forum.xda-developers.com/apps/magisk/module-nanodroid-5-0-20170405-microg-t3584928) Support Thread

## ChangeLog

Full, user-readible [> ChangeLog](ChangeLog.md)

## Summary

**NanoDroid** can be installed as a Magisk Module or directly to /system, though a bit functionality is only available with Magisk.

More information about Magisk [> XDA](https://forum.xda-developers.com/apps/magisk)

NanoDroid includes

* microG and it's companions
  * on-device framework-patcher for microG support (signature spoofing)
  * on-pc framework-patcher for microG support (signature spoofing)
* F-Droid and it's privileged extension
* modified Play Store to allow (in-)app-purchases with microG
  * this required the Play Store to be modified, see the [> patch](doc/Phonesky.diff)
  * alternatively Yalp Store can be installed instead
* custom init scripts
* pseudo-debloat feature (Magisk-only)
  * disables applications systemless-ly
  * pre-configured [> default settings](doc/PseudoDebloat.md)
* several Open Source applications
  * include replacements for the pseudo-debloated applications
  * full list of [> included applications](doc/Applications.md)
* additional components
  * GNU Bash shell
  * GNU Nano terminal editor
  * several utilities from `util-linux`, `bsdmainutils` and more
* The Legend of Zelda ringtones and sounds

## Packages

### Modules

Module packages, flashing through TWRP recommended, though flashing through Magisk Manager works aswell.

* **NanoDroid**: includes
  * everything mentioned in the Summary
* **NanoDroid-microG**: includes
  * microG and it's companions
  * GNU Bash
  * pseudo-debloat feature
  * app store(s)
* **NanoDroid-fdroid**: includes
  * F-Droid and it's privileged extension

### Extras

Extra packages, always flash through TWRP.

* **NanoDroid-patcher**: includes
  * on-device framework-patcher for signature spoofing support
     * optionally can patch user interface for it into Developer Settings
  * creates the file `/data/adb/.nanodroid-patcher` after successful patching
  * installs an addon.d script for automatic re-patching after ROM update
     * addon.d support files reside in `/data/adb/nanodroid-patcher/`
  * the original, unpatched `services.jar` (and optionally `Settings.apk`) are backed up to `/sdcard/`
     * respectively `SecSettings.apk` on TouchWiz ROMs
* **NanoDroid-setupwizard**: includes
  * **AROMA** based Setup Wizard to create the configuration files
  * user can choose where to store the configuration files
     * `/sdcard`
     * `/external_sd`
     * `/data` (fallback)
  * **NOTE:** AROMA only works on `arm` and `arm64`, if your device is `x86` or `x86_64`, it won't work
* **NanoDroid-uninstaller**: includes
  * uninstalls *all* NanoDroid Magisk Modules
  * uninstalls NanoDroid installed in System Mode
  * uninstalls NanoDroid configuration files
  * uninstalls NanoDroid-Patcher addon.d environment
  * if `services.jar` or `Settings.apk` backups are found they get restored
     * respectively `SecSettings.apk` or `SecSettings2.apk` on TouchWiz ROMs
  * if `com.qualcomm.location` backup is found it gets restored

### Scripts

Misc. Script for use from PC/Notebook, while device is in TWRP.

* **framework-patcher** (clone this repository)
  * on-pc framework-patcher for signature spoofing support
  * creates the file `/data/adb/.nanodroid-patcher` after successful patching
  * invoke like `framework-patcher [ver] [--gui]`
     * where [ver] is your Android version (6.0, 7.1, ...)
     * where `--gui` is an optional switch to patch a global toggle for signature spoofing into Developer Settings
  * the original, unpatched `services.jar` (and optionally `Settings.apk`) are backed up to `/sdcard/`
     * respectively `SecSettings.apk` on TouchWiz ROMs
* **force-debloat** (clone this repository)
  * system debloater
  * the list of applications resides in the script itself
  * needs to be run from TWRP, requires explicit user acceptance
  * supports `.nanodroid-overlay` configuration file
     * uses fallback values, if none found
         * which are in the script itself and can be edited
  * has a test mode which prints what would be done
* **mount-magisk** (clone this repository)
  * script to mount or unmount Magisk in TWRP
  * script toggles mount-state (read: will mount Magisk if unmounted and unmount Magisk if mounted)

## Details

### NanoDroid

This lists features unique to NanoDroid.

#### nanodroid-overlay

The `nanodroid-overlay` script handles the following features

* pseudo-debloat (Magisk-only)
  * show the list of pseudo-debloated apps
  * add or remove apps from the list of pseudo-debloated apps
* add system properties (Magisk-only)
* grant signature spoofing permission to microG and Play Store if required
  * both in Magisk and System Mode
* issue `nanodroid-overlay --help` for the full list of options

Full details on the nanodroid-overlay Script [> Details](doc/NanoDroidOverlay.md)
Full details on the pseudo-debloat feature [> Details](doc/PseudoDebloat.md)

#### init scripts

The following init scripts are bundled with NanoDroid

* external_sd
  * symlink SD Card mount point to `/external_sd`
  * SD Card needs to be inserted upon boot
* fstrim
  * trim file systems (may increase speed)
* logscleaner
  * clean up log files
* sqlite
  * clean up sqlite databases

When in Magisk Mode the init scripts create their log files in

  `/magisk/NanoDroid/.logs/${script}.log.${date}`

When installed to /system your ROM needs to support running scripts in

  `/system/etc/init.d`

or you can use **Kernel Adiutor's** init.d emulation.

#### Shell Utilities

Several utilities from `bsdmainutils` and `util-linux`

* [> bsdmainutils Launchpad](https://launchpad.net/ubuntu/+source/bsdmainutils)
* [> util-linux GitHub](https://github.com/karelzak/util-linux)

are included:

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

* aapt [> eLinux Wiki](http://elinux.org/Android_aapt)
* less [> Website](http://www.greenwoodsoftware.com/less/)
  * lessecho
  * lesskey
* unzip [> Website](http://www.info-zip.org/UnZip.html)

#### GNU Bash and GNU Nano

NanoDroid includes GNU Bash shell and the GNU Nano terminal editor.

* [> GNU Bash Website](https://www.gnu.org/software/bash/bash.html)
* [> GNU Nano Website](https://www.nano-editor.org/)

### microG

microG is an Open Source replacement for Google Services, full details can be found at the microG homepage [> Website](http://microg.org/)

NanoDroid includes microG as follows

* microG GmsCore [> GitHub](https://github.com/microg/android_packages_apps_GmsCore) and Play Store [> APK Mirror](https://www.apkmirror.com/apk/google-inc/google-play-store/)  modified to allow (in-)app purchases
* with **Déjà Vu** location provider backend [> F-Droid](https://f-droid.org/de/packages/org.fitchfamily.android.dejavu/)
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
  * Play Store is modified to allow (in-)app-purchases with microG
* if `com.qualcomm.location` exists it will either be
  * pseudo-debloated (in Magisk Mode)
  * moved to /sdcard (in System Mode)
     * it conflicts with microG's location backend

### F-Droid and Applications

F-Droid [> Website](http://www.fdroid.org) is an app store for Open Source applications.

NanoDroid includes both F-Droid and it's Privileged Extension [> F-Droid](https://f-droid.org/repository/browse/?fdfilter=f-droid&fdid=org.fdroid.fdroid.privileged), so you don't need to enable `Unknown Sources`.

Additionally NanoDroid includes a variety of applications, check full details [> GitHub](doc/Applications.md)

### The Legend of Zelda ringtones and sounds

NanoDroid includes **The Legend of Zelda** [> Nintendo](http://www.zelda.com/) ringtones and sounds, because it's dangerous to root alone.

Full [> Details](doc/ZeldaSounds.md)

## Installation

### Alter Installation

NanoDroid supports altering the installation settings to a certain degree.

Full [> Details](doc/AlterInstallation.md) on altering installation manually, or use the Setup Wizard (if you've got an arm/arm64 device).

### Installation Process

#### NanoDroid

* Use Setup Wizard to create configuration files (if you've got an arm/arm64 device), or create manually (see above)
* Download pre-built zip or create one from this repository
* perform full wipe (/system, /data, /cache, Dalvik/ART cache)
  * recommended, but not required
* install desired ROM
  * make sure it does **not** include GApps if you want to use microG
  * either pre-patched with signature spoofing support or **deoxeded** so you can patch yourself (instructions follow)
* install **Magisk**
  * recommended, but not required
  * if **Magisk** is installed, NanoDroid will be installed as Magisk-Module, else it will install into `/system` directly
* install desired Kernel (if any)
* install **NanoDroid**
* reboot into ROM

#### microG

##### Signature Spoofing Support

For **microG** to work, your ROM needs to have signature spoofing enabled (or a **deodexed** ROM to patch yourself).

If your ROM does **not** have signature spoofing support, you can manually patch it either
  * flashing the on-device Patcher zip
     * it also installs an addon.d script that auto re-patches the ROM upon update
  * running the `framework-patcher` script
     * use from your PC or laptop while your device is in TWRP. This shell script for GNU Bash (and compatible shells) works on unixoid operating systems like GNU/Linux, BSD or MacOS. It automizes the process of downloading Haystack [> GitHub](https://github.com/Lanchon/haystack), pulling files from phone, patching and installing the modified `services.jar` on the device.

Both patchers support installing the patched `services.jar` into the following locations:
  * NanoDroid Magisk Module
  * NanoDroid-microG Magisk Module
  * directly into `/system`

So you can use them regardless whether you're using NanoDroid or not.

##### microG Setup

Once your ROM supports signature spoofing, you need to setup microG like this
  * go into **microG settings** and set up everything like:
     * check results in **Self-Check**, grant missing permissions (by tapping on them)
         * especially the **Battery Optimization** item
     * enable **Google device registration**
     * enable **Google Cloud Messaging** (only if you want to receive push messages from your applications)
     * enable **Google SafetyNet** (required for applications that utilize SafetyNet, for example Pokémon GO, ...)
         * '...' menu > set to use the **Official Server**
     * in **UnifiedNlp Settings** choose
         * **Déjà Vu** or **Mozilla** as Geolocation backend
         * **Nominatim** as Address lockup backend
     * after everything is done, reboot
     * go to **Play Store**, setup account and install your apps

## License & Credits

My own work (NanoDroid itself) is licensed under the GNU General Public License version 3 or newer [> GNU](https://www.gnu.org/licenses/gpl-3.0.txt)

For more details (including authors and license) on every provided application or Software press the link next to it.

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

* SafetyNet check fails with `Google Play Services not available`
  * you did not setup microG (or did not reboot afterwards)
* Play Store lacks fake signature spoofing permission
  * on ROMs like **crDroid** or **OmniROM**, that have built-in signature spoofing, in some cases the Play Store is not granted that permission automatically, to fix this either
     * issue the command `nanodroid-overlay --permission` as root
     * go to Settings > Apps > Gear Icon > App Permissions > `Signature Spoofing` > Enable for Play Store
* Google Sync adapters lacking permissions
  * to fix this either
     * issue the command `nanodroid-overlay --permission` as root
     * go to Settings > Apps > Google Contacts/Calendar Sync > Permissions > grant permissions
* Battery Drain
  * microG fails to register applications  to GCM (Google Cloud Messaging) if they were installed **before** microG, but the apps keep trying to register and that causes the battery drain, all apps installed **after** microG are properly registered, to fix the battery drain either
     * do a clean flash of your ROM (, Magisk) and NanoDroid and install your apps after microG setup
     * uninstall and re-install all your applications (backup application data if required)
* microG lacks features
  * if you use AppOps, PrivacyGuard or the like you have to grant microG GmsCore **all** permissions, if you prevent some permissions, some apps or features might not work as expected or not at all. Note: some APIs/features are stubs in microG GmsCore, meaning they exist that apps don't complain, but they do nothing - thus blocking microG GmsCore is pretty much of no benefit.

Additional helpful information in the microG [> Wiki](https://github.com/microg/android_packages_apps_GmsCore/wiki/Helpful-Information).

## TODO

* better error handling in **on-pc** framework-patcher
* split installer code into module-specific and non-module-specific to prevent duplication

## FAQ

```
Q: will there be a GApps version, instead of microG?
A: no. but you can choose not to populate microG.

Q: what devices is this tested on?
A: Moto X Play (lux), Nexus 6 (shamu)

Q: what ROMs was this tested on?
A: LineageOS, Resurrection Remix, AICP, AOSP Extended, crDroid, should work on any LineageOS / AOSP based ROM that is working with Magisk.
```
