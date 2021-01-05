# ChangeLog

## 23.1 in-dev

NOTE: There's now a new git repository as central place/navigational point for all custom builds from NanoDroid:

* https://gitlab.com/Nanolx/nanodroid-patches

## Bug Fixes

* Installer, Addon
  * read configuration files from `/system/addon.d` (fallback if TWRP can't mount `/data`)
  * read configuration files from `/tmp` (fallback if TWRP can't mount `/data`)

* Uninstaller
  * make use of bundled `busybox` at all

* CommonInstaller, Uninstaller, SysTest, Patcher
  * setup bundled `busybox` before mounting partitions
     * should fix segmentation faults reported on Sammy devices

* Full, microG packages
  * fix that (in Magisk Mode) GmsCore was not automatically ensured to be a user app

## General Changes

* CommonInstaller
  * resturctured, consolidated and cleaned-up code

* Addon
  * simplify addon.d and remove unused functions

* NanoDroid-Overlay
  * read configuration files from `/system/addon.d` (fallback if TWRP can't mount `/data`)
  * read configuration files from `/tmp` (fallback if TWRP can't mount `/data`)

* NanoDroid-Util
  * add `-R`, `--reset-permissions` switch

* Full package
  * move from `Blokada` v4 to v5
  * no longer ship `XDA Labs`
  * grab `NewPipe` from NewPipe repo instead of F-Droid
     * F-Droid build is outdated
  * grab `SmartPack Kernel Manager` from F-Droid instead of Github

* Full, F-Droid package
  * add `NewPipe` repo to F-Droid's `additional_repos.xml` @Vavun

* Documentation
  * re-structure and update Issues section
  * minor updates

### Updates

* automatic
  * microG GmsCore (0.2.16.204713)
  * Amaze (3.5.2)
  * Blokada (5.6.0)
  * Bromite System WebView (87.0.4280.131)
  * FreeOTP+ (2.2.13)
  * KeePassDX (2.9.7)
  * NewPipe (0.20.8)
  * Open Camera (1.48.3)
  * OpenLauncher (0.7.4)
  * OSM Android (3.8.5)
  * Privacy Browser (3.6.1)
  * Simple Calendar (6.11.3)
  * Simple Gallery (6.18.0)
  * SmartPack-KernelManager (15.4)
  * Termux (0.104)
  * Tor Browser (10.0.07)
  * Twidere (4.1.6)

* manual
  * GNU Bash (5.1.0[4]-2 w/ Debian patches)
  * SQLite3 (3.34.0
  * MPV (20210104-nightly)

## 23.0.1.20201029 "[FCK 2020](https://www.discogs.com/de/Scooter-FCK-2020/release/16102123)"

### Bug Fixes

* Installer, SysTest, Patcher, Uninstaller
  * fix a logical issue preventing mounting of `/system` on some non-A/B devices

* Patcher
  * fix `BASEDIR` being declared to late

### Updates

* automatic
  * F-Droid (1.10)
  * Simple Calendar (6.11.0)
  * Simple Gallery (6.16.4)

## 23.0.20201023 "[All Aboard](https://www.discogs.com/Francesco-Zeta-All-Aboard/release/15998163)"

### Note

If you use Google Play, but it doesn't show your bought apps as bought, [check this Issue entry for a fix](https://gitlab.com/Nanolx/NanoDroid/-/blob/master/doc/Issues.md#play-store-does-not-show-bought-apps-as-bought)

### Bug Fixes

* Installer
  * update privapp-permission detection to fix bootloops on Android 11
  * update APEX mount code for new `com.android.art.runtime` in Android 11
  * fix that empty `nanodroid_init=""` setup variable will get overriden with default value
     * note: missing `nanodroid_init` will still make the default value used, as desired
  * improve handling of conflict between `Fake Store` and `Play Store`
  * when `nanodroid_forcesystem=1` is given, but we flash from Magisk Manager stop
     * when you want `/system` installation, install from TWRP
  * fix creating Uninstaller/Addon.d information for installed init scripts
  * look for configuraiton files in `/sdcard` explicitely (in certain occasions `/data/media/0` might not be available, still `/sdcard` is)
  * when flashing NanoDroid directly after Magisk (without booting into ROM first), the installer previously wouldn't find Magisk, thus falling back to `/system` installation

* Installer, Patcher, SysTest, Uninstaller
  * improve detection of system-as-root devices and fix issues mounting `/system`
  * ensure we mount `/vendor` block device if direct mounting fails
     * fixes issue with mounting `/vendor` on some devices in TWRP
  * only create `/system/vendor -> /vendor` compat link needed on some devices if there's no `vendor_${SLOT}` partition

* Addon.d
  * several fixes and improvements

* Patcher
  * fix check whether we're updating the Magisk Module

* Uninstaller
  * fix that NanoDroid-Patcher Magisk module wouldn't have been uninstalled

* NanoDroid-Overlay script
  * `--genconfig` no longer forcefully sets config to `/data/.nanodroid-overlay`
  * fix running `nanodroid-overlay` during addon.d
  * fix read-write remounting `/system` for system mode debloating in when there's no `/system` but `/` to handle instead

* build-package
  * fix downloading APK from GitHub when release tag has multiple APKs
  * make mime-type checking more robust

* service.sh
  * microG GmsCore may need to be installed as user app for all permissions to be granted, now `service.sh` does the job
     * this is not required in `/system` mode
     * see microG [issue 1100](https://github.com/microg/android_packages_apps_GmsCore/issues/1100#issuecomment-711088518)

* nanodroid-perm
  * pass microG GmsCore userId to `pm` when granting restricted permissions
    * `android.permission.ACCESS_BACKGROUND_LOCATION` and `android.permission.RECEIVE_SMS` on Android 10+
    * see microG [issue 1100](https://github.com/microg/android_packages_apps_GmsCore/issues/1100#issuecomment-711141077)

### General Changes

* Installer, SysTest, Patcher, Uninstaller
  * NanoDroid can now be flashed from TWRP, even if `/data` couldn't be mounted
     * in this case configuration files can be read from `/tmp`

* Installer
  * improve function to auto-detect wether we use official or Nanolx GmsCore/DroidGuard and migrate between, if required
     * (there's no public Nanolx microG GmsCore build, I'm using this for internal testing)
  * simplify function for checking whether ROM has builtin or selfpatched support for `android.permission.FAKE_PACKAGE_SIGNATURE`
  * simplify and speed-up function for on-the-fly creation of privapp-permission whitelists
  * simplify function for linking swipe libraries
  * new `setup_installer()` function to reduce amount of code in each module's `update-binary`
  * re-order functions and make the `CommonInstaller` file better readable
  * store System Mode file list in `/system/addon.d` instead of `/data/adb`
    * allows for full compat with recoveries that can't decrypt `/data`
  * when newly flashing NanoDroid from Magisk Manager use `pm` to reset runtime permissions for better compat
    * when flashing from TWRP the runtime-permissions.xml is still removed
    * this is in both cases not done on NanoDroid upgrades

* Full, microG packages
  * move all utilities from `/system/xbin` to `/system/bin`

* Patcher, SysTest, Uninstaller
  * update functions from Installer

* SysTest
  * minor internal improvements

* NanoDroid-Overlay script
  * in system mode the script now only removes apps, no longer backs them up and restores them
     * allows for full compat with recoveries that can't decrypt `/data`
  * somewhat nicer output
  * major code clean-up and simplification

* NanoDroid-Perm script
  * add newly required `android.permission.RECEIVE_SMS` restricted permission for microG GmsCore
  * when granting microG GmsCore restricted permissions, pass it's userId to `pm` for better compat
  * allow running `nanodroid-perm` via `adb` @FriendlyNeighborhoodShane

* Patcher, Patcher Addon.d
  * install Patcher environment into `/system/addon.d` no longer `/data/adb`
    * allows for full compat with recoveries that can't decrypt `/data`

* Uninstaller
  * update for changes to `nanodroid-overlay`
  * update for changes to Patcher
  * update for new location of System Mode file list
     * both new and old locations are supported
  * drop support for uninstalling ancient NanoDroid versions
  * simplify code

* Full package
  * add `Warden` an app management utility that let's you disable Services and Trackers
  * drop shell utilites from the package
     * except `lesskey` and `lessecho`, they'll be installed together with `bash` and `less` if `nanodroid_bash=1`

* build-package
  * allow side-loading custom APKs from `local` directory inside the NanoDroid tree
     * side-loading libraries is currently not supported
  * simplify functions for downloading APKs from github, gitlab, url and opengapps
  * use Android build-tools version 29.0.3 when calling `dx` utility
     * for `build-package dalvik`
  * compress APKs using ZStandard instead of GZip
     * better performance on low-end devices

* sysconfig
  * whitelist Aurora Services for `allow-in-power-save-except-idle`
  * whitelist Aurora Services for `system-user-whitelisted-app`
  * drop whitelist for Yalp Store (removed from NanoDroid since ages)

* Documentation
  * update and improve Issues section
  * some minor improvements

## Updates

* automatic
  * microG GmsCore (0.2.13.203915)
  * Amaze (3.5.0)
  * Blokada (4.8.5)
  * Bromite System WebView (86.0.4240.99)
  * F-Droid (1.10-alpha1)
  * FreeOTP+ (2.1)
  * K-9 Mail (5.718)
  * KeePassDX (2.8.7)
  * NewPipe (0.20.1)
  * OAndBackupX (3.2.0)
  * Odyssey (1.1.20)
  * OpenVPN (0.7.21)
  * Simple Calendar (6.10.3)
  * Simple Gallery (6.16.3)
  * SmartPack Kernel Manager (13.8)
  * Termux (0.102)

* manual
  * GNU Bash (5.1-rc1)
  * MPV (201016-nightly)

## 22.9.20200910 "[Tiefseequappe]"

### General Changes

* SetupWizard
  * removed - AROMA works unreliably, not working properly on many devices, not working at all on x86/x86_64

* NanoDroid-Perm Script
  * running `nanodroid-perm`, respectively `npem` will now grant `android.permission.ACCESS_BACKGROUND_LOCATION` to microG

* Installer
  * drop loading setup files from directory containing the zip (internally `${ZIPDIR}`)
  * ignore empty and commented out lines in the configuration files (= starting with `#`)
  * don't load configuration files that aren't required by the package that's going to be flashed

* Full Package
  * add FreeOTP+ {FreeOTPPlus} a two factor auth application with import and export function

* build-package script
  * disable `u-patch` for now as we use new patches since 22.7

* Documentation
  * majorly improved documentation regarding configuring NanoDroid (now there the SetupWizard is gone)
  * the default configuration files are now more prominently visible in the documentation
  * the default configuration files are now fully documented inside themselfs
  * updates and fixes in the documentation
  * improvements and reorganization of the documentation

### Updates

* automatic
  * microG GmsCore (0.2.12.203315)
  * Blokada (4.8.3)
  * Bromite System WebView (85.0.4183.94)
  * FreeOTP+ (2.0.11)
  * KeePassDX (2.8.3)
  * OAndBackupX (3.1.0)
  * Privacy Browser (3.5.1)

## 22.8.20200901 "[The Beauty And The Bug]"

### Bug Fixes

* CommonInstaller
  * fix flashing when Magisk is not installed (System Mode)
  * fix `nanodroid_init` setup variable not being respected
  * fix installation failure when configuration files have Windows CRLF linefeeds instead of Unix LF linefeeds
  * typos in `nanodroid_init` setup variable will now cause a warning instead of aborting installation
  * typos in `nanodroid_utils` setup variable will now cause a warning instead of aborting installation

* SetupWizard
  * fix crash due malfored `aroma-config`

### General Changes

* Full, microG packages
  * grant `android.permission.ACCESS_BACKGROUND_LOCATION` permisson to microG on SDK version 29 (Android 10) or newer


## 22.7.20200829 "[The Velvet Machine](https://nealacree.bandcamp.com/album/the-velvet-machine)"

### Important Note

Starting with this release the Patcher will no longer install the patched `services.jar` and the companion
`org.spoofing.apk` into the NanoDroid or NanoDroid_microG Magisk Modules, instead it will install both files
into it's own NanoDroid_Patcher Magisk Module, which makes it easier to disable or remove the module in case
it doesn't properly work.

The one-time downside is, that when upgrading the NanoDroid or NanoDroid-microG Magisk Modules the patched
`services.jar` and `org.spoofing.apk` will **no longer be preserved**! So if you intent to upgrade NanoDroid
to 22.7 and are on a self-patched ROM, you **have to reflash** the Patcher in order to retain
`FAKE_PACKAGE_SIGNATURE` permission.

This is only required once, because later on the patched file resides in it's own module. System Mode install
for the Patcher is of course still supported and will be done if Magisk wasn't found on your device.

### Bug Fixes

* SetupWizard
  * when selecting no apps create empty config file (working around an uncommon corner case)
     * when one selects no apps but still activates "install apps", the installer would install all apps

* Patcher
  * drop `-Xnodex2oat`from `dalvikvm` flags to avoid crashes on Android 10
     * falsely listed as supported flag by `dalvikvm --help`

* Installer
  * fix bootloops with recent Play/GmsCore on Android 10 due to changed privapp-permissions

* SysTest
  * fix collecting `dalvikvm` information on some recent ROMs
  * fix logging block devices for `/system` and `/vendor`

* Installer, Patcher, SysTest, Uninstaller
  * improved APEX compatibility
  * improved Android 10 compatibility
  * improve detection of block devices for `/system` and `/vendor`

* Installer, Patcher, SysTest
  * also detect whether ROM has `FAKE_PACKAGE_SIGNATURE` permisson on self-patched ROMs
  * don't pollute logs with magisk mounts

* Google Package
  * fix GoogleCalendarSync on SDK 21 - 29 @Spongebob
  * fix installing swipe libraries in cases where `LatinIME` does not have it's libs linked to `/system`

* build-package Script
  * Darwin compatibility
  * BSD compatibility
  * fix `build-package clean` not properly working

### General Changes

* Installer
  * Installing through Magisk Manager is possible again (atleast 19.0 required, 20.4 highly recommended)
  * setup variable `nanodroid_init` is now a list `nanodroid_init="10_sqlite 20_fstrim 30_logcat 40_external_sd 50_logscleaner"`
     * all listed init scripts will be installed
  * setup variable `nanodroid_utils` is now a list `nanodroid_utils="findfs findmnt hexdump lessecho lesskey lsblk lscpu lsipc lslocks lsns ncal whereis"`
     * all listed utils will be installed
     * the `column` util will always be installed (required by `nanodroid-overlay`)
  * various internal improvements

* Full Package
  * switch from `Oandbackup` to `OAndBackupX`
  * changes to the GNU Bash shell included:
     * include patches from Debian GNU/Linux
     * set default `PATH` to `/sbin:/system/sbin:/product/bin:/product/xbin:/apex/com.android.runtime/bin:/system/bin:/system/xbin:/odm/bin:/vendor/bin:/vendor/xbin:.`
     * set `DEFAULT_UTILS_PATH` to `/sbin:/system/sbin:/product/bin:/product/xbin:/apex/com.android.runtime/bin:/system/bin:/system/xbin:/odm/bin:/vendor/bin:/vendor/xbin:/etc:/apex/com.android.runtime/etc:/system/etc`
     * set `SYS_BASHRC` to `/system/etc/bashrc`
     * set `SYS_BASH_LOGOUT` to `/system/etc/bash_logout`
     * set `SYS_PROFILE` to `/sdcard/bash_profile`
     * set `DEFAULT_BASHRC` to `/sdcard/bashrc`
   * changes to the MPV build included:
     * merged youtube-dl support (see [this pull request](https://github.com/mpv-android/mpv-android/pull/58))
     * merged preference to extend video in the cutout area (see [this pull request](https://github.com/mpv-android/mpv-android/pull/296))

* Full, microG package
  * setup variable `nanodroid_play` has new value `30` which will install both Play Store and Aurora Store
  * use own DroidGuard instead of Official, as long as there's no release

* Full, F-Droid package
  * setup variable `nanodroid_fdroid` has new value `3` which will install both official and Aurora Store F-Droid clients
     * installs F-Droid priviledged extension and Aurora Services alongside

* Patcher
  * Patching through Magisk Manager is possible (atleast 19.0 required, 20.4 highly recommended)
  * instead of installing patched files into the NanoDroid or NanoDroid_microG Magisk Modules the files will be installed in own NanoDroid_Patcher Magisk Module
     * that is if Magisk was found on the device, else System Mode installation is done, as before
  * remove restriction for Android 10
  * use Android 7 - 9 patch for Android 10
  * collect APEX information in log
  * create `BOOTCLASSPATH` on-the-fly and log it
  * experimental: use newly proposed Haystack patches, see https://github.com/Lanchon/haystack/pull/34
  * various internal improvements

* Addon, Patcher Addon
  * improve System Mode addon.d scripts

* SysTest
  * check and log LD_CONFIG_FILE
  * log loaded APEX modules
  * log boot slot
  * don't pollute Magisk Manager with logs, we create a logfile
  * cosmetic changes to generated logfile

* Patcher, Uninstaller
  * drop old code regarding NanoMod (= NanoDroid older than version 16.0)

* Setup Wizard
  * updated for aforementioned changes
  * other minor changes

* build-package Script
  * a bit more info when `BP_DEBUG=1` is passed over

* Documentation
  * minor updates

### Updates

* automatic
  * microG GmsCore (0.2.11.202414)
  * microG Droidguard Helper (0.1.2) [custom build]
     * note: SafetyNet attestation still does not work with microG!
  * AnySoftKeyboard (1.10.1109)
  * Aurora Droid (1.0.6)
  * Aurora Services (1.0.6)
  * Aurora Store (3.2.9)
  * Bromite System WebView (85.0.4183.82)
  * F-Droid (1.10-alpha0)
  * Frost (2.4.5)
  * K-9 Mail (5.717)
  * KeePassDX (2.8.2)
  * NewPipe (0.19.8)
  * OAndBackupX (3.0.0)
  * Odyssey (1.1.19)
  * Open Camera (1.48.2)
  * OpenLauncher (0.7.3)
  * OpenVPN (0.7.17a)
  * OsmAnd+ (3.7.4)
  * Privacy Browser (3.5)
  * Simple Calendar (6.10.0)
  * Simple Gallery (6.15.2)
  * SmartPack Kernel Manager (12.8)
  * Termux (0.96)
  * Tor Browser (68.12.0)
  * Twidere (4.1.4)

* manual
  * GNU Bash (5.1~alpha1)
  * Google Play (20.9.20)
  * MPV (20200828-nightly)

* tools
  * sqlite3 (3330000)
  * smali (2.4.0) [SDK26+]
  * baksmali (2.4.0) [SDK26+]
  * file (5.38-5)
  * dexpatcher (1.8.0-beta1) [SDK26+]
  * aapt [from Substratum 1021]

## 22.6.20200208 "[La Sirena](https://memory-alpha.fandom.com/wiki/La_Sirena)"

### Bugfixes

* Installer
  * add more permission to privapp whitelist automatically (0xc212)
     * fix bootloops on Android 10

* Patcher
  * fix dexpatcher crashing
  * fix setting ld environment

### General Changes

* Full Package
  * replace Face Slim with Frost
     * users will be auto migrated
  * no longer ship Substratum
  * no longer ship Orbot
  * no longer ship GNU Nano Editor
     * use 0smosis' GNU Nano flashable zip
  * drop the following shell utilities:
     * col
     * colcrt
     * colrm
     * look
     * setterm
  * no longer ship Zelda ringtones
  * break-out Google Sync Adapters and Swipe libraries into NanoDroid-Google package
  * switch from F-Droid to GitHub builds for Amaze

* microG package
  * break-out Google Sync Adapters and Swipe libraries into NanoDroid-Google package

* Google package
  * new package which includes Google Sync and Swipe libraries
  * support Sync Adapters and swipe libraries on Android 10

* Bromite System WebView package
  * Bromite v80 supports Android 10

* Patcher
  * for SDK 19 - 25 use dexpatcher 1.6.3
  * for SDK 26 and newer user dexpatcher 1.8.0-alpha4

* SetupWizard
  * remove Nintendo Fonts entry (no longer available)
  * set Aurora Droid as default F-Droid client
  * update for recent changes

### Updates

* automatic
  * Amaze (3.4.1)
  * Aurora Services (1.0.5)
  * Aurora Store (3.1.7)
  * Blockada (4.5.2)
  * Bromite System WebView (80.0.3987.78)
  * F-Droid (1.8-alpha1)
  * K-9 Mail (5.704)
  * New Pipe (0.18.2)
  * Open Keychain (5.5)
  * Privacy Browser (3.3)
  * QKSMS (3.8.1)
  * Simple Calendar Pro (6.8.3)
  * SmartPack Kernel Manager (9.6)
  * Termux (0.90)
  * Tor Browser (68.4.1)

* manual
  * Google Play (18.7.18)
  * MPV (200207-nightly)

* tools
  * dexpatcher (1.8.0-alpha4-snapshot)
  * busybox (1.31.1) (only used by the Installer)
  * magic.mgc (5.38) (only used by the Patcher)

## 22.5.1.20200102 "[NCIA-93](https://memory-alpha.fandom.com/wiki/NCIA-93_type)"

### Bugfixes

* SetupWizard
  * fix writing configuration files to external SD card on some devices @hockeymikey

* Installer
  * fix compat with vendor partition on some devices

* build-package
  * fix `u-gsync` not working
  * fix `u-bromite` not working
  * fix `u-osmand` not working

### General Changes

* Sync Adapters
  * use API 19 Calendar Sync only for API 19 (KitKat)
  * use API 21 Calendar Sync for API 21 - API 28 (Lolipop - Pie)

### Updates

* automatic
  * Aurora Store (3.1.5)
  * Blokada (4.4.3)
  * Bromite System WebView (79.0.3945.107)
  * F-Droid (1.8-alpha0)
  * F-Droid Privileged Extension (0.2.11)
  * K-9 Mail (5.703)
  * KeePass DX (2.50.0.0beta25)
  * NewPipe (0.18.0)
  * Open Camera (1.47.3)
  * OpenLauncher (0.7.2)
  * OSM Android+ (3.5.5)
  * QKSMS (3.7.10)
  * Simple Calendar Pro (6.8.2)
  * Simple Gallery Pro (6.10.8)
  * Tor Browser (68.3.0)

* manual
  * Google Play Store (17.9.17)
  * MPV (20191106-nightly)

* tools
  * dexpatcher (1.8.0-alpha4)
  * vdexextractor (0.6.0)

## 22.5.20191029 "[SS Emette](https://memory-alpha.fandom.com/wiki/SS_Emmette)"

### Bugfixes

* Patcher
  * better ROM compat by detecting what DalvikVM options are actually supported

* Installer, Patcher, Uninstaller, SysTest
  * improved support for A/B and system-as-root devices
  * mount `com.android.runtime` APEX on Android 10 (if ROM provides it)
     * required for fully working installation environment

* Uninstaller
  * properly unmount system partition on system-as-root devices

* Full package
  * on Android 10 ringtones may need to be installed into `/system/product/media`

* Bromite WebView package
  * on Android 10 Bromite System WebView may need to be installed into `/system/product/app`
  * fix check whether ROM actually supports Bromite WebView

* build-package Script
  * minor fix in version bumping

### General Changes

* Full, microG packages
  * drop `Yalp Store`, as it hasn't received updates for a year now
  * update `nanodroid_play` setup value accordingly
     * before: value 20 = Yalp Store; 21 = Yalp + Fake Store ; 30 = Aurora Store ; 31 = Aurora + Fake Store
     * now: value 20 = Aurora Store ; 21 = Aurora + Fake Store
     * user will be auto-migrated from Yalp to Aurora Store (if required)

* SysTest
  * log the mounted android runtime APEX on Android 10 (if ROM provides it)

* Uninstaller
  * in uninstalling System Mode NanoDroid support restoring apps from `/system/reserve` and `/system/product` (if any)

* nanodroid-overlay Script
  * support creating overlays for `/system/product/app`
  * support creating overlays for `/system/product/priv-app`
  * guard non-universal app-directories (`/system/reserve`, `/system/product`) to prevent meaningless error messages

* build-package Script
  * improve dalvik-izing jar files

* nanodroid-font Script
  * dropped `nanodroid-font` Script and Nintendo UI Fonts

### Updates

* automatic
  * Aurora Droid (1.0.4)
  * Aurora Store (3.1.3)
  * Blokada (4.3.11)
  * Bromite System WebView (78.0.3904.72)
  * KeePassDX (2.5.0.0beta23)
  * microG GmsCore (0.2.9.19420-5 (official nightly))
  * NewPipe (0.17.3)
  * nlp Backend Déjà Vu (1.1.12)
  * OpenCamera (1.47.2)
  * Orbot (16.1.2-RC-2)
  * OpenKeychain (5.4)
  * OpenLauncher (0.7.0)
  * OSM Android (3.4.8)
  * QKSMS (3.7.3)
  * Simple Calendar (6.6.4)
  * Simple Gallery (6.10.3)
  * SmartPack Kernel Manager (8.9)
  * Substratum (1020)
  * Termux (0.76)
  * Tor Browser (68.2.0)

* manual
  * Google Play (17.2.13)
  * MPV (20191025-nightly)

## 22.4.20190811 "[Château Picard](https://memory-alpha.fandom.com/wiki/Chateau_Picard)"

### Bugfixes

* build-package
  * fix various minor issues @TanyaEleventhGoddess

### General Changes

* build-package
  * major refactoring @TanyaEleventhGoddess
  * new envvar `BP_USE_WGET=1`: use `wget` instead of `curl` for downloads @TanyaEleventhGoddess
  * new envvar `BP_DEBUG=1`: print debug information during downloads @TanyaEleventhGoddess
  * dynamic date in created packages @TanyaEleventhGoddess
  * new switch `report`: create package report with (way too much) information about NanoDroid
     * will also be auto-created when building `all` packages
     * reports get their SHA256 checksum and GPG signature

* Installer
  * `GoogleCalendarSync` is the same APK across all Android versions, thus it's now only downloaded/included once

### Updates

* automatic
  * Aurora Services (1.0.4)
  * Bromite System WebView (76.0.3809.100)
  * OsmAnd+ (3.4.6)
  * Simple Calendar (6.5.7)
  * Termux (0.73)

* manual
  * Google Play (16.1.23)

## 22.3.20190805 "[Transwarp](https://memory-alpha.fandom.com/wiki/Transwarp)"

### Bugfixes

* build-package
  * fix downloading APKs from repos when NanoDroid repo clone is empty
  * fix default setting of `nanodroid_overlay` variable across packages
  * fix downloading APKs from GitHub

* Magisk service.sh
  * fix installing Bromite System WebView as user-app on first boot

### General Changes

* build-package
  * support downloading APKs from GitLab
  * improve checking NanoDroid integrity
  * use cURL instead of wget for downloads

* Full, microG packages
  * when installing Aurora Store, also install Aurora Services

* Full, F-Droid packages
  * new `nanodroid_fdroid=2` configuration value
     * installs Aurora Droid instead of official F-Droid client
         * also installs Aurora Services

* SetupWizard
  * update to support new `nanodroid_fdroid=2` configuration value
  * clearify that `nanodroid_microg=0` does not effect microG package
  * clearify that `nanodroid_fdroid=0` does not effect F-Droid package

### Updates

* automatic
  * Aurora Droid (1.0.3)
  * Aurora Services (1.0.2)
  * Aurora Store (3.0.9)
  * Blokada (4.1.5)
  * Bromite System WebView (76.0.3809.91)
  * F-Droid (1.7.1)
  * OsmAnd+ (3.4.5)
  * Simple Calendar (6.5.4)
  * Simple Gallery (6.9.1)

## 22.2.20190728 "[Nexus](https://memory-alpha.fandom.com/wiki/Nexus)"

### Bugfixes

* build-package
  * fix fallback `.nandroid-apps` configuration file not being packaged
  * fix fallback `.nanodroid-overlay` configuration file not being packaged

* Installer
  * fix mounting /system on non-A/B devices with system-as-root

* Uninstaller
  * fix mounting /system on non-A/B devices with system-as-root

* Patcher
  * fix mounting /system on non-A/B devices with system-as-root

* SysTest
  * fix mounting /system on non-A/B devices with system-as-root

### General Changes

* Installer
  * log whether device is A/B
  * log used system block device
  * log used vendor block device
  * log whether device is system-as-root
  * log whether vendor compat link was created

* SysTest
  * only bind-mount random device when in TWRP
  * log used system block device
  * log used vendor block device
  * log whether device is system-as-root

### Updates

* automatic
  * Bromite System WebView (76.0.3809.85)

* manual
  * Google Play (16.0.15)

## 22.1.20190726 "[USS Enterprise B](https://memory-alpha.fandom.com/wiki/USS_Enterprise_(NCC-1701-B))"

### Notes

* This replaces original `Yalp Store` with `Yalp Store (fork)`
  * original Yalp Store seems not be maintained anymore

* This replaces `Kernel Adiutor` with `SmartPack-Kernel-Manager`
  * if you've previously opted-in for `Kernel Adiutor`, you'll be auto-migrated

* This release changes the mirrors a bit
  * Nanolx: like before only the latest stable relase and current beta release
  * Android Filehost: archive for all stable releases, no more beta releases

### Bugfixes

* Installer
  * fix microG installation in System Mode

### General Changes

* Installer
  * include path to setup files in installation log

* Magisk Modules
  * bump minimum Magisk version in all module.prop files to 1900
  * unify services.sh into one file for all packages

* build-package
  * fix comparing SHA256 hashes in some corner cases
  * download `Substratum` APK from GitHub instead of APK Mirror
  * download `XDA Labs` apk from XDA instead of APK Mirror
  * drop support for downloading APKs from `https://www.apkmirror.com`

### Updates

* automatic
  * OsmAnd+ (3.4.4)
  * Privacy Browser (3.2)
  * Simple Gallery (6.8.3)
  * Twidere (3.7.6)

* manual
  * GNU Nano (4.2)
  * Google Play (15.9.21)

* tools
  * sqlite3 (3290000)

## 22.0.20190713 "[USS Excelsior](https://memory-alpha.fandom.com/wiki/USS_Excelsior)"

### Notes

* This release no longer ships the custom microG GmsCore
  * if you previously opted-in for it you'll be auto-migrated to the official build
  * the setup variable `nanodroid_gmscore` is obsolete now

* This release no longer ships the custom microG DroidGuard Helper
  * if you previously opted-in for it you'll be auto-migrated to the official build

* This release replaces `OmniClock` with `Alarmio`
  * if you previously opted-in for OmniClock you'll be auto-migrated to Alarmio

* This release replaces `Lightning` with `Privacy Browser`
  * if you previously opted-in for Lightning you'll be auto-migrated to Privacy Browser

* This release replaces `BeHeKeyboard` with `Hacker's Keyboard`
  * if you previously opted-in for BeHeKeyboard you'll be auto-migrated to Hacker's Keyboard

* This release drops `OpenWeatherMapProvider`
  * check your ROM for supported Weather Providers

* This release switches from alpha to stable `Tor Browser` build

### Bugfixes

* SetupWizard
  * fix creating configuration files

* Installer
  * improve automatic privapp-whitelist creation
     * fixes LineageOS 16 bootloops
  * fix bootloops on LineageOS 16
  * fix bootloops on LineageOS 16 for microG

* Uninstaller
  * several fixes for System Mode uninstallation

* nanodroid-font Scipt
  * fix applying font

* build-package
  * fix filepaths in SHA256 checksums

### General Changes

* SetupWizard
  * backup previous configuration files into `/data/media/0/nanodroid_backups/config_%Y%m%d-%H.%M.%S`
     * where `%Y%m%d-%H.%M.%S` is the current date in `20190609-12.07.16` format
  * sort list of applications alphabetically
  * make official microG GmsCore the default choice
  * string changes

* SysTest
  * allow running from Magisk Manager
  * filter out Magisk mounts from log
  * log usable space for Installer

* Installer
  * allow in-place migration between NanoDroid and Official microG GmsCore
  * support recoveries with `/sdcard1` (like OrangeFox) @Vavun
  * internal improvements

* Uninstaller
  * drop support for uninstalling old Magisk mode installs (Magisk < 19.0)
  * drop support for uninstalling old System mode installs (NanoDroid < 18.0.3)

* build-package
  * use JSON instead of XML indices for F-Droid repositories
  * only download F-Droid indices if required
  * compress APKs using GNU Zip (gzip)
     * saves about 120 MB space in TWRP for full package
  * many internal improvements

* Patcher
  * build dexpatcher dex with minimal SDK 19 (KitKat)

### Updates

* automatic
  * Alarmio (1.0.2)
  * Bromite System WebView (75.0.3770.139)
  * F-Droid (1.7)
  * microG GmsCore (0.2.8.17785-mapbox)
  * NewPipe (0.16.2)
  * Odyssey (1.1.18)
  * OpenKeychain (5.3)
  * Orbot (16.1.0-RC-2)
  * OsmAnd+ (3.4.0)
  * QKSMS (3.6.6)
  * Simple Calendar (6.5.4)
  * Simple Gallery (6.8.2)
  * Tor Browser (60.8.0)
  * Twidere (3.7.5)

* manual
  * dexpatcher (1.6.3)
  * MPV (20190620-nightly)
  * Play Store (15.7.17)

## 21.0.20190601 "[USS Reliant](https://memory-alpha.fandom.com//wiki/USS_Reliant)"

### Notes

* This release drops support for Magisk older than version 19.0!
  * except the Uninstaller

### Bugfixes

* logscleaner init.d Script
  * prevent the script from unintentionally removing Magisk log

* Uninstaller
  * syntax fix

### General

* Installer, Uninstaller, Addon.d, Patcher
  * use full `/data/media/0` path instead of `/sdcard`

* Installer
  * store installation logs into `/data/media/0/nanodroid_logs` instead of `/data/adb`
     * change file permissions, so they can be accessed as ordinary user
  * append version to the installation logs
     * for example: `NanoDroid_20.8.20190504_log_20190505-21.35.00`
  * append `.log` extension to installation logs
  * when updating NanoDroid in Magisk Mode make init.d logs survive it
  * automatically create priv-app permission whitelist files
  * simplify code

* Uninstaller
  * remove `/data/media/0/nanodroid_logs` aswell

* SysTest
  * store logs into `/data/media/0/nanodroid_logs` instead of `/data/media/0`
     * change file permissions, so they can be accessed as ordinary user
  * append date in +%Y%m%d-%H.%M.%S format to log file name
    * example: 20190505-09.35.00, 20190505-21.35.00
  * add check whether ROM supports Bromite WebView installation
  * improve check whether Magisk is installed
    * also log Magisk version
    * also log whether Magisk is imageless or not
  * pipe installed package checks through `sort` for nicer log result
  * update mount code

* Full package
  * drop OmniJAWS

* Full, microG packages
  * move Aurora Store from `priv-app` to `app`, drop now useless permission file @Vavun

* Bromite WebView package
  * only install Bromite WebView if ROM supports `com.android.webview`

* Scripts
  * detect full path to storage instead of hardcoding `/sdcard`

* init.d Scripts
  * move init.d scripts logs from `${MODDIR}/.logs` to `${MODDIR}/logs`
  * change and unify time format to 24h clock for logging to "+%Y%m%d-%H.%M.%S"
     * example: 20190505-09.35.00, 20190505-21.35.00
  * wait for `vold.post_fs_data_done` instead of `sys.boot_completed` @Vavun
  * make all init.d scripts wait until device fully booted
     * only effects System Mode, already been the case for Magisk Mode before
  * sort init.d logically, so that native init.d starts them successively @Vavun
  * only execute load heavy scripts if battery charge is at least 15 % @Vavun

* logscleaner init.d Script
  * only clean files older than 7 days
  * verbose logging

* logcat init.d Script
  * verbose logging of the script itself
  * simplify code

* fstrim init.d Scripts
  * trim `/vendor` aswell @Vavun

* external_sd init.d Script
  * if `ro.build.characteristics` contains `nosdcard` abort without further action

###  Updates

* automatic
  * Simple Gallery (6.7.7)
  * Simple Calendar (6.5.0)
  * F-Droid (1.7-alpha0)
  * Termux (0.72)
  * Tor Browser (60.7.0)
  * Bromite System WebView (75.0.3770.70)
  * Open Camera (1.46)
  * OpenVPN (0.7.8)
  * AnySoftKeyboard (1.10.606)
  * Aurora Store (3.0.5)

* manual
  * microG (NanoDroid) (0.2.7.17455-65-mapbox)
  * microG (Official) (0.2.7.17455-vtm)
  * Google Play (15.1.23)
  * MPV (20190511-nightly)

## 20.8.20190504 "[Prometheus](https://memory-alpha.fandom.com/wiki/USS_Prometheus_(Prometheus_class))"

### Notes

* Full and microG packages up to version 20.7 by default installed Google Play. Starting with version 20.8 the default behaviour is changed and by default Aurora Store and Fake Store are now installed. If you previously ran the Setup Wizard nothing will change. If you don't have your own `nanodroid-setup` configuration file, you'll notice the different setup.

* Bromite System WebView 74.x breaks Google Login. The Bromite System WebView thus stays at version 73.0.3683.107 until the bug is fixed. After logging in to your Google Account with all desired apps, you may update to the latest Bromite System WebView using F-Droid.

### Bug Fixes

* Full, microG packages
  * fix bootloop with OmniROM Pie

* Patcher
  * explicitely set permissions on installed files

* Installer
  * fix creating installation logs
  * installation of full package requires atleast 512 MB free space from TWRP, stop installation if there isn't enough free space

### General

* Installer
  * add support for Magisk 19.0
     * Magisk < 19.0 still supported
  * improved A/B partition scheme support (from Magisk 19.0 @topjohnwu)
  * proper error message when `unzip` fails due to not enough space available
  * improved logging
  * code improvements

* Full package
  * switch to official stable OpenLauncher build (0.6.1)
  * drop Yahoo Weather Provider (they closed their APIs)

* Full, microG package
  * switch from Aurora Store v2 (com.dragons.aurora) to v3 (com.aurora.store) @Vavun

* Patcher
  * support installing patched services.jar into Magisk 19.0+ modules
  * install org.spoofing system pseudo-app after patching @Vavun
     * this is adds ROM wide *cosmetic* information about Signature Spoofing (so it shows up in the App Permissions)

* Uninstaller
  * support uninstalling Magisk 19.0+ modules

* nanodroid-util script
  * add `-r`, `--reset-gms-data` param, resets GMS data (including GCM registration) for given app (or all, if none) @ale5000

* nanodroid-perm script
  * will now also set required permissions for uNlp backends

* sysconfig
  * improved sysconfig for better uNlp Pie support @oF2pks, @Vavun

### Updates

* automatic
  * AnySoftKeyboard (1.10.364)
  * Tor Browser (60.6.1)
  * Simple Calendar (6.4.3)
  * Simple Gallery (6.6.4)
  * OsmAnd+ (3.3.6)
  * NewPipe (0.16.1)
  * Oandbackup (0.3.5-universal)
  * Bromite System WebView (73.0.3683.107)
  * F-Droid (1.6)
  * Aurora Store (3.0.4)
  * nlpBackend Déjà Vu (1.1.11)
  * QKSMS (3.6.4)
  * Termux (0.68)
  * Substratum (1020)

* manual
  * Play Store (14.7.50)
  * microG GmsCore (0.2.6.15181-79)

* tools
  * GNU Nano (4.0)
  * Busybox (1.30.1) [installer only]

## 20.7.20190310 "749 Mark 148"

### Bug Fixes

* nanodroid-perm
  * fix typo prevent some permissions to be set

* Installer
  * fix resizing magisk.img failing due it being dirty
  * fix GApps removal in certain cases
  * fix compatibility with LineageOS for microG
     * certain components now only get removed if NanoDroid's replacements are actually going to be installed
  * fix storing library installation information in System Mode installation for APKs installed to an alias path
     * fixes addon.d being unable to restore libraries after ROM update
     * affects microG GmsCore and Bromite WebView

### General

* Installer
  * re-use already unpacked framework-res when checking for native sigspoof more than once
  * more verbose GApps removal logging
  * make `unzip` less noisy to prevent twrp.log pollution

* Patcher
  * update Haystack patches to 20190308 by @Lanchon
     * improved patches
     * official Android Pie support

* build-package Script
  * update to new OpenGApps host URL

### Updates

* automatic
  * Simple Gallery (6.5.5)
  * Simple Calendar (6.3.2)
  * Bromite System WebView (73.0.3683.61)
  * Odyssey (1.1.17)
  * NewPipe (0.16.0)
  * Termux (0.66)
  * Blokada (3.7.022000)
  * AnySoftKeyboard (1.9.2629)
  * Open Camera (1.45.2)
  * QKSMS (3.6.3)

* manual
  * microG GmsCore (0.2.6.15090-167-dirty)
  * Play Store (13.8.16)

## 20.6.20180126 "Malachowski"

### Bug Fixes

* Uninstaller
  * ensure restored backups (System Mode) have proper permissions

* NanoDroid-Overlay
  * when listing non-overriden apps in Magisk Mode, skip NanoDroid's own packages
  * fix adding overlays to configuration if a similarly named app already is in the configuration

* Push Messages
  * GsfProxy needs the same signature as GmsCore in order for Push Messages to fully work
  * when using NanoDroid's GmsCore a re-signed GsfProxy with the NanoDroid key will be installed
     * it's the official GsfProxy apk only re-signed with that different key
  * when using official GmsCore the official GsfProxy will be installed
  * thanks to @Vavun for pointing this out

### General Changes

* Scripts
  * nanodroid-overlay
     * store backups in System Mode per ROM in /sdcard/nanodroid_backups/${ro.build.flavor}_${ro.build.id}

* Uninstaller
  * improved System Mode uninstallation routine
  * look for per ROM backups

### Updates

* automatic
  * Bromite WebView
     * arm, arm64: 72.0.3626.68
     * x86: 72.0.3626.73

* manual
  * Google Play Store (13.3.16)
  * microG GmsCore (0.2.6.14847-dirty-163 [NanoDroid])

## 20.5.1.20190116 "USS T'Plana-Hath"

### Bug fixes

* Installer
  * add privapp-permission files for Fake Store, Yalp Store and Aurora Store
     * fixes bootloops on some Android Pie ROMs
     * applies to: Full, microG packages

* Unified Nlp
  * improve default sysconfig whitelists by @oF2pks
     * fixes unified Nlp not registering on some Pie ROMs
     * applies to: Full, microG packages

### General Changes

* Installer
  * improve App Store installation routine

* Signature Spoofing Permission
  * add permission files to tell ROMs with native signature spoofing to enable it by default for microG GmsCore and Play Store or Fake Store
     * applies to: Full, microG packages

* Bromite WebView
  * update repository URL
     * applies to: Full, F-Droid packages, build-package script

### Updates

* automatic
  * F-Droid Priviledged Extension (0.2.9)
  * Simple Gallery Pro (6.2.2)
  * Simple Calendar Pro (6.2.1)

## 20.5.20190113 "T'Plana-Hath"

### Bug Fixes

* Installer
  * fix migration from AdAway to Blockada (for old versions)
     * applies to: Full package
  * ensure `/system` is always mounted read-write
     * applies to: Full, microG, F-Droid, BromiteWebView, OsmAnd packages

* Magisk Modules
  * fix installing DroidGuard helper as user app
     * applies to: Full, microG packages
  * fix installing Bromite WebView as user app
     * applies to: BromiteWebView package
  * don't try to start `permissions` init script, removed since ages
     * applies to: Full package

* Unified Nlp
  * some (old) versions of `com.qualcomm.location` conflict with unified Nlp, but recent versions reportedly don't, thus it no longer gets auto-removed
  * use `nanodroid-overlay -a com.qualcomm.location` to remove it, if it's installed and unified Nlp doesn't work
     * applies to: Full, microG packages

* Patcher, Patcher addon.d
  * fix detection whether ROM has native signature spoofing

* SetupWizard
  * if user has choosen to store configuration on `/external_sd`, but it doesn't exist, fallback to `/sdcard`

* Scripts
  * nanodroid-overlay
     * mount `/system` read-write on System Mode installations

### General Changes

* Installer
  * improve GApps removal list
     * applies to: Full, microG packages
  * when searching for System WebView, also look for `WebViewStub`
  * replace System WebView with Bromite WebView in-place
  * no longer try to replace GoogleWebView (different package name)
     * applies to: BromiteWebView package

* Magisk Modules
  * improve post-boot tasks by waiting for `sys.boot_completed`
     * applies to: Full, microG, F-Droid, Bromite WebView, OsmAnd packages
  * define additonal priv-app permissions by default
     * applies to: Full, microG packages

* Unified Nlp backends
  * add Radiocell location backend
     * can be used online and offline (by downloading the database for your country)
     * by default not installed
     * changed setting nanodroid_nlpbackend
         * before: nanodroid_nlpbackend=ABC (A: Déjà Vu, B: Ichnaea, C: Apple)
         * now: nanodroid_nlpbackend=ABCD (A: Déjà Vu, B: Ichnaea, C: Apple, D: Radiocell)
     * your setup file will be auto-migrated
     * applies to: Full, microG packages

* SetupWizard
  * update AROMA (taken from ElementalX by @flar2)
  * various changes, improvements, cosmetic changes
  * update to include Radiocell uNlp backend

* Play Store
  * the Play Store is now also patched to prevent self-updates @Vavun

* Scripts
  * nanodroid-overlay
     * various minor improvements
     * support debloating applications from `/system/reserve`

* Uninstaller
  * update A/B partition scheme mount code
  * minor improvements

* Documentation
  * added additional instructions for Stock ROMs
  * re-structured Issues section
  * added several more issues (and their fixes / workarounds)

### Updates

* automatic
  * BromiteWebView (71.0.3578.123)
  * QKSMS (3.6.1)
  * Tor Browser (60.4.0)
  * Simple Calendar Pro (6.2.0)
  * Simple Gallery Pro (6.2.0)
  * F-Droid (1.5.1)
  * nlpBackend Radiocell (0.2.9)

* manual
  * Play Store (13.1.33)
  * microG GmsCore (0.2.6.14847-dirty-155)
  * OpenLauncher (0.6.1-nightly-190106)
    * this is the last custom build of OpenLauncher, official builds will be used in the future.

* tools
  * GNU Bash (5.0-0)
  * GNU Nano (3.2)

## 20.4.20181230 "Constitution"

### Notes

* Starting with build 0.2.6.14799-dirty-134 the custom microG build of NanoDroid will show an icon
  * in the app launcher (any Android version)
  * in the System Settings (on Android 6 or newer)
  * in the App overview (Settings > App > microG Services Core (on Android 7 or newer))

### Bug Fixes

* SetupWizard
  * fix selection for unified Nlp backends not properly created

### General Changes

* Installer
  * if the ROM has native signature spoofing support include that permission in the default permission files
     * solves incompatibility with LineageOS for microG @Vavun
     * function to detect whether ROM is pre-patched @ale5000
         * applies to: Full, microG packages
  * if the ROM includes a SetupWizard (mostly on stock), properly disable it (in Magisk Mode)
     * solves incompatibility with stock ROM SetupWizard and microg @DoR3M3
     * for System Mode installation, check the Issues section of the README on how to solve this
         * applies to: Full, microG packages
  * add ConfigUpdater to GApps removal list
     * applies to: Full, microG packages
  * improved version of the `external_sd` init script @Vavun
     * applies to: Full package
  * when detecting system properties also look if /vendor/build.prop exists
     * applies to: all packages
  * support both /data/adb/magisk and /data/magisk
     * applies to: all packages
  * remove old code regarding Magisk
     * applies to: all packages

* addon.d
  * sync GApps removal list with Installer
     * applies to: Full, microG packages

* Patcher
  * when detecting system properties also look if /vendor/build.prop exists
  * support both /data/adb/magisk and /data/magisk
  * remove old code regarding Magisk
  * when creating a backup of `services.jar` append `ro.build.flavor` and `ro.build.id`
  * if the ROM has native signature spoofing support don't do anything
     * function to detect whether ROM is pre-patched @ale5000
  * re-add UnifiedNlp patch by Tom Vincent

* Patcher addon.d
  * if the ROM has native signature spoofing support don't do anything
     * function to detect whether ROM is pre-patched @ale5000

* SysTest
  * test ROM for native signature spoofing support
    * function to detect whether ROM is pre-patched @ale5000
  * when detecting system properties also look if /vendor/build.prop exists
  * support both /data/adb/magisk and /data/magisk
  * use busybox for tests

* Uninstaller
  * when restoring a backup of `services.jar` look for new-style named backup

* Scripts
  * improve check whether Magisk is installed or not
     * applies to: nanodroid-font, nanodroid-prop

### Updates

* automatic
  * Simple Calendar Pro (6.1.2)
  * Simple Gallery Pro (6.1.3)
  * Bromite WebView (71.0.3578.110)
  * Amaze (3.3.2)
  * Orbot (16.0.5-RC-2-tor-0.3.4.9)
  * F-Droid (1.5)
  * Substratum (1015)
  * nlpBackend Déjà Vu (1.1.10)
  * QKSMS (3.6.0)

* manual
  * Play Store (12.9.12)
  * microG GmsCore (0.2.6.14799-dirty-145)
  * Open Launcher (0.6.1-nightly-181023)

## 20.3.20181208 "Shenzhou"

### Notes

* (Simple) Calendar is now replaced by Simple Calendar Pro. While the app is still Open Source, code available on github and free on F-Droid, the Play Store release is now paid ([see this post by the developer](https://medium.com/@tibbi/some-simple-mobile-tools-apps-are-becoming-paid-d053268f0fb2)), thus the change. NanoDroid-wise the transistion is done in-place, but you will have to re-setup the application.

* nanodroid_play setup variable has changed
  * old: nanodroid_play=[0|1] (default: nanodroid_play=1)
  * new: nanodroid_play=[0|1|2|3][0|1] (default: nanodroid_play=10)
    * 1st element
         * 0 = no App Store
         * 1 = Play Store
         * 2 = Yalp Store
         * 3 = Aurora Store
    * 2nd element
         * 0 = without Fake Store
         * 1 = with Fake Store
  * your existing .nanodroid-setup file will be migrated

* nanodroid_nlpbackend setup variable has changed
  * old: nanodroid_nlpbackend=[0|1|2|3] (default: nanodroid_nlpbackend=1)
  * new: nanodroid_nlpbackend=[0|1][0|1][0|1] (default: nanodroid_nlpbackend=100)
    * 1st element = whether to install Déjà Vu location backend
    * 2nd element = whether to install Ichnaea (Mozilla) location backend
    * 3rd element = whether to install Apple location backend
         * reportedly better coverage in eastern europe than Ichnaea
  * your existing .nanodroid-setup file will be migrated

### Bug Fixes

* build-package Script
  * Prevent error `(23) Failed writing body` while piping cURL's output in some cases @Vavun

* CommonInstaller
  * fix `nanodroid_swipe` not being properly honoured @Vavun

### General Changes

* Full, F-Droid packages
  * improve F-Droid vendor repository settings
  * add official microG Repository to vendor repositories

* Full, microG packages
  * move microG DroidGuard Helper from /system/priv-app to /system/app
  * add Apple location backend optionally @Vavun
  * add Aurora Store optionally @Vavun

* CommonInstaller
  * GApps removal mechanism improvements
     * also check for PrebuiltGmsCorePix, PrebuiltGmsCorePi, GCS and GoogleConnectivityServices
     * remove pre-existing Google Accounts @Vavun
     * expand check for runtime-permissions to all users, not just user 0

* Bromite WebView package
  * also check for Webview and WebViewGoogle when trying to get rid of stock WebView

* OsmAnd package
  * new package including OsmAnd+ (OpenStreetMap) and the Contour Lines plugin
  * thanks to @Vavun for most of the work

* SetupWizard
  * update for updated variables as noted above

* Uninstaller
  * don't remove configuration files

### Updates

* automatic
  * Simple Gallery Pro (6.0.4)
  * Simple Calendar Pro (6.0.1)
  * Oandbackup (0.3.4-universal)
  * Bromite WebView (71.0.3578.85)
  * Aurora Store (2.0.5-beta)
  * nlpBackend Apple (1.2.3)
  * Amaze (3.3.1)
  * OsmAnd+ (3.2.6)
  * Orbot (16.0.5-RC-1-tor-0.3.4.9)

* manual
  * Play Store (12.8.23)
  * microG GmsCore (0.2.6.14797-dirty-113)
  * OpenLauncher (0.6.1-nightly-181208)

## 20.2.20181122 "Cardenas"

### Notes

* (Simple) Gallery is now replaced by Simple Gallery Pro. While the app is still Open Source, code available on github and free on F-Droid, the Play Store release is now paid ([see this post by the developer](https://medium.com/@tibbi/some-simple-mobile-tools-apps-are-becoming-paid-d053268f0fb2)), thus the change. NanoDroid-wise the transistion is done in-place, but you will have to re-setup the application.

### Bug Fixes

* CommonInstaller
  * fix installing APK libraries for non-multilib APKs

* Uninstaller
  * fixed Uninstaller failing if no overlayed apps from System Mode exist
  * fixed Uninstaller failing to remove Patcher artifacts and restore original services.jar

### General Changes

* SysTest package
  * new package for providing several ROM informations
     * device profile (ROM, manufacturer, device, ABI, builddate, security patch date)
     * detected LD_LIBRARY_PATH
     * DalvikVM binary and it's architecture
     * mounted partitions, whether device is A/B
     * list of installed GApps
     * file list of /system/app and /system/priv-app
  * log is created in /sdcard/NanoDroid-SysTest.log

* Full, microG packages
  * new setup variable `nanodroid_gmscore`, selects which microG GmsCore to install
     * 0 = install NanoDroid's [custom microG GmsCore](https://github.com/Nanolx/android_packages_apps_GmsCore)
     * 1 = install [official microG GmsCore](https://github.com/microg/android_packages_apps_GmsCore)

* CommonInstaller
  * NanoDroid installation log now contains whether install was successful or not
  * Installer now prints a message where it stored the logs

* Patcher package
  * drop unlp patch, not required on most ROMs and is suspected to cause issues on some ROMs
  * improve DalvikVM architecture detection
  * improve calling DalvikVM to prevent using patch2oat
    * (which may have a different bitness (32 vs. 64 bit) as DalvikVM itself)

* Uninstaller
  * now also uninstalls the BromiteWebView package

* SetupWizard
  * add new `nanodroid_gmscore` variable

* build-package Script
  * move to stable Amaze build

* Documentation
  * more detailed information about custom APKs

### Updates

* automatic
  * Bromite WebView (70.0.3538.107)
  * Odyssey (1.1.16)
  * Amaze (3.3.0)
  * Simple Gallery Pro (6.0.0)

* manual
  * microG GmsCore (0.2.6.14796-dirty-112)
  * Play Store (12.6.11)

## 20.1.20181112 "Miranda"

### Bug Fixes

* CommonInstaller
  * fix GSync Adapters installation

### General Changes

* Bromite WebView package
  * change apk path from /system/app/webview to /system/app/BromiteWebView
  * disable /system/app/webviewstub (some ROMs use that instead of /system/app/webview)
  * get rid of webview updates, aswell, if it's a fresh NanoDroid installation

* Uninstaller
  * in System Mode restore all debloated apps upon uninstallation, not just GApps

## 20.0.20181111 "Nimitz"

### Important Notes

```
NanoDroid can no longer be flashed through Magisk Manager!

While flashing through Magisk Manager worked for most users
in most cases, it did not always, if it failed it caused
major headache, thus the change.

The following packages now require flashing through TWRP:
- NanoDroid (Full)
- NanoDroid-microG
- NanoDroid-FDroid
- NanoDroid-BromiteWebView

The following packages always required flashing through TRWP:
- NanoDroid-Uninstaller
- NanoDroid-SetupWizard

The following package can still be flashed trough Magisk Manager:
- NanoDroid-Patcher

Of course installation as Magisk Module is not effected.
```

### General Changes

* CommonInstaller, CommonAddon
  * drop YouTube from list of applications to get rid as part of GApps removal
  * improve and unify GSync installation code
  * several internal changes and improvements

* Full, microG packages
  * `nanodroid_microg` setting is now a triplette
     * 0 = don't install microG at all (like before)
     * 1 = install microG GmsCore, GsfProxy and DroidGuard Helper and Nominatim Geocoder Backend (like before)
     * 2 = install microG GmsCore and Nominatim Geocoder Backend (new)

* Full, microG, F-Droid, Bromite WebView packages
  * if custom Magisk migration was done, ensure Magisk Manager is installed, aswell
     * if you clean flash Magisk and NanoDroid in one go, without booting into ROM in-between, this code is triggered

* Bromite WebView package
  * new module which replaces Android System WebView with [Bromite WebView](https://www.bromite.org/system_web_view)
  * Bromite WebView needs to be installed both as system app and user app, else several apps won't work
     * the module handles system app installation in all cases
     * in Magisk Mode it is auto-installed as user-app 30 seconds after Magisk initialized after boot
     * in System Mode run `pm install -r /system/app/webview/webview.apk` as root to do so manually

* Full, F-Droid packages
  * add Bromite F-Droid repository to default repositories
     * only applied on fresh installations
     * see [Bromite F-Droid Repo](https://www.bromite.org/fdroid)

* SetupWizard
  * update for `nanodroid_microg` change
  * move selection of uNlp backend before selection of Play Store

* NanoDroid-Overlay
  * don't forcefully create configuration when none exists
     * the user should do it manually using `nanodroid-overlay -g` if desired

* build-package Script
  * download TorBrowser from Guardian Project Repository
  * remove pre-existing zips when creating a new one

### Updates

* automatic
  * KeePass DX (2.5.0.0beta18)
  * Amaze (3.3.0RC12)
  * Substratum (1010)
  * TorBrowser (60.3.0)

* manual
  * Play Store (12.5.15)

## 19.1.1.20181103 "Bonaventure Refit"

### Bug Fixes

* Full, microG packages
  * unify privapp permission handling since Android ROMs behave differently

## 19.1.20181102 "Bonaventure"

### Bug Fixes

* Full, microG packages
  * add READ_RUNTIME_PROFILES to Play Store priv-app permissions

* Commoninstaller
  * improve microG DroidGuard Helper installation
  * fix swipe feature by providing SDK-specific libraries

### General Changes

* Full, microG packages
  * split privapp-permissions-google.xml into
     * privapp-permissions-microg.xml for microG GmsCore permissions
     * privapp-permissions-phonesky.xml for Play Store permissions
  * split microg-permissions.xml into
     * microg-permissions.xml for microG GmsCore and uNlp permissions
     * phonesky-permissions.xml for Play Store permissions
  * add privapp-permissions-gsync.xml for BackupTransport permissions

* CommonInstaller
  * make GApps removal mechanism less brutal

### Updates

* automatic
  * New Pipe (0.14.2)
  * Blokada (3.6.101900)
  * OpenVPN (0.7.6)
  * (Simple) Gallery (5.1.2)

* manual
  * MPV (20181102-nightly)
  * OpenLauncher (20181029-nightly)
  * Play Store (12.4.14)
  * microG GmsCore (0.2.6.14369-dirty-103)

## 19.0.20181027 "Crossfield"

### Bug Fixes

* build-package script
  * fix downloading APKs from apkmirror.com
    * NanoDroid packages can now be created from scratch again

* CommonInstaller
  * fix x86_64 support [Gia90]

* CommonPatcher
  * improve dalvikvm arch detection
    * should improve ROM compatibility
  * provide static `zip` binary for x86 [Gia90]
  * use `smali`/`baksmali` version 2.1.3 below Nougat [Gia90]

* CommonAddon
  * addon.d now properly honours `nanodroid_overlay` setup variable
  * fix x86_64 support [Gia90]

* Full, microG packages
  * switch to official Fake Store build
    * fixes F-Droid repository conflict with custom Play Store
  * fix Google Sync Adapters permissions file being installed in the wrong directory

* SetupWizard
  * fix selecting OmniClock doesn't work

### General Changes

* build-package script
  * packages will now be created with SHA256 checksum and GPG signature
  * download repo indices once per session, speeds up download and package creation time
  * check whether all files are in place is now dynamic
  * minor internal changes

* Full package
  * migrate from Adaway to Blokada
    * users that had Adaway installed, will be auto-migrated to Blokada
    * VPN users can't use Blokada, but can still install Adaway from F-Droid
  * add a standalone build for OmniJAWS
    * Weather Service and Widget from OmniROM
    * OpenWeatherMap is currently not supported, use Yahoo!-Backend for now

* Full, F-Droid packages
  * automatically add NanoDroid F-Droid repository on fresh installations
    * needs to be manually added on updated installations (see below)

* Full, microG packages
  * improve GApps removal mechanism

* CommonPatcher
  * code improvements [Gia90]

* NanoDroid-UPD script
  * removed in favour of NanoDroid F-Droid Repository

* NanoDroid F-Droid Repository
  * added, contains custom NanoDroid snapshot builds for
    * microG GmsCore
    * microG DroidGuard Helper
    * Google Play Store
    * MPV
    * OmniJAWS
    * OpenLauncher
  * see http://nanolx.org/fdroid/repo/
  * automatically added to F-Droid on fresh installations
    * needs to be manually added on updated installations

### Updates

* automatic
  * (Simple) Calendar (5.1.1)
  * (Simple) Gallery (5.1.1)
  * Oandbackup (0.3.2)
  * Amaze (3.3RC10)
  * Open Camera (1.44.1)
  * F-Droid (1.5-alpha0)
  * Blokada (3.6.101401)
  * AnySoftKeyboard (1.9.2445)
  * TorBrowser (1.0a2)

* manual
  * microG GmsCore (0.2.6.14366-dirty-102)
  * MPV (20181009-nightly)
  * OpenLauncher (20181024-nightly)
  * Play Store (12.3.19)
  * OmniJAWS (1.1-standalone)

* shell utilities
  * bsdmainutils (11.1.2)
  * util-linux (2.32.1)
  * less (487)
  * GNU Nano (3.1)

* tools
  * Busybox (1.29.3)
    * internal busybox only used by the installer!
  * zip (x86)
    * static build for x86/x86_64
  * smali/baksmali (2.1.3)
    * used by Patcher on pre-Nougat ROMs

## 18.3.1.20180921

### General Changes

* Full, microG package
  * move GsfProxy from /system/app to /system/priv-app

### Updates

* automatic
  * QKSMS (3.5.4)
  * Amaze (3.3RC5)

* manual
  * microG GmsCore (0.2.5.13280-dirty)
  * Play Store (11.8.09)

## 18.3.20180920

### Bug Fixes

* Patcher
  * during installation get rid of old addon.d

* CommonInstaller
  * switch back mode detection to 17.x behaviour

### General Changes

* On-PC framework-patcher
  * removed for now, broken beyond Oreo and does not work on odexed ROMs
  * a better implemenation will follow

* Force-Debloat script
  * removed as NanoDroid-Overlay works in System Mode, aswell now

* Patcher
  * add unifiednlp patch [by Tom Vincent](https://github.com/tlvince/haystack/commit/3194226568901ac6c2111e6d1cd6be91a5d96254)

### Updates

* automatic
  * Substratum (1006)

## 18.2.20180916

### Bug Fixes

* NanoDroid-Overlay
  * fixed a bug that caused GApps Removal and Overlay Creation to fail

### General Changes

* Full package, SetupWizard, CommonInstaller
  * switch from Orfox to TorBrowser
     * if user opted-in to install Orfox CommonInstaller will auto-migrate setup to TorBrowser

* Patcher
  * move addon.d from 999 to 70 (fixes conflicts with Magisk addon.d)

* CommonInstaller
  * improve custom Magisk migration code
  * install microG DroidGard Helper as user app, aswell

* build-package
  * dynamically check whether NanoDroid is correctly populated with APKs prior building packages
  * when downloading APKs only updated the indices once per session instead for each individual APK
     * drastically reduces time and bandwith required to populate NanoDroid with APKs

### Updates

* automatic
  * F-Droid (1.4)
  * (Simple) Calendar (4.2.0)
  * (Simple) Gallery (4.6.2)
  * NewPipe (0.14.1)
  * nlpBackend Déjà Vu (1.1.9)
  * QKSMS (3.5.3)
  * Substratum (1004)

* manual
  * microG GmsCore (0.2.5.12879-194-custom)
  * Play Store (11.7.11)

* tools
  * Dexpatcher (1.6.2)

## 18.1.20180909

### Bug Fixes

* CommonInstaller
  * fix installer not detecting upgrade when flashing through Magisk Manager

* CommonAddon
  * fix crashes during addon.d post-restore action
  * fix printing messages

* PatcherAddon
  * fix DalvikVM crash
  * fix printing messages

* NanoDroid-Overlay
  * fix (re-)creating overlays when flashing through Magisk Manager

* Uninstaller
  * fix error in error-printing (sic!)

### General Changes

* CommonInstaller
  * code simplifications
  * ROMs with build-type userdebug are treated as Custom ROMs

* CommonAddon
  * during post-restore action create NanoDroid-Overlay

* CommonPatcher
  * tell DalvikVM to be more verbose
  * remove ancient, unused files from addon.d
  * for binary files only install the current-arch ones into addon.d
  * ROMs with build-type userdebug are treated as Custom ROMs
  * remove duplicated '!!' in error messages

* PatcherAddon
 * clean-up addon.d environment every time addon.d is fired up

* Uninstaller
  * remove duplicated '!!' in error messages

### Updates

* automatic
  * New Pipe (0.14.0)
  * QKSMS (3.5.1)

* manual
  * microG GmsCore (0.2.5.12879-152-custom)

## 18.0.3.20180908

### Bug Fixes

* CommonPatcher
  * don't register services.jar in uninstaller information for System Mode installation
     * fixes logical interferences with CommonInstaller

* CommonInstaller
  * migrate /data/adb/.nanodroid-list to /data/adb/NanoDroid_FileList

### General Changes

* CommonInstaller, Uninstaller
  * update for CommonPatcher changes

## 18.0.2.20180908

### Bug Fixes

* Full, microG packages
  * improve microg-permissions.xml to fix bootloops on some Pie ROMs

* CommonPatcher
  * try to detect whether we are on a Custom or Stock ROM
     * should fix linking issues on Stock ROMs

### Updates

* manual
  * Play Store (11.6.18)

## 18.0.1.20180907

### Bug Fixes

* CommonInstaller
  * fix microG GmsCore, PlayStore and microG Services Framework Proxy loosing data and permissions after upgrade
  * if System Mode installation is detected, exit the installer if run from Magisk Manager

### General Changes

* CommonInstaller
  * minor code improvements
  * fix doubled "!!" in error strings

## 18.0.20180907

### Bug Fixes

* CommonInstaller
  * cleanup TWRP environment when an installation error occurs during System Mode installation
     * regression from 17.9
  * remove `GoogleExtServices` from GApps removal list, as it is required for ROMs using `GooglePackageManager`
  * remove `GooglePartnerSetup` from GApps removal list, as some ROMs require it
  * on fresh installations, also get rid of possible user-installed version of Play Services
  * fix installation in Magisk Mode when ROM was never booted
  * when /data/adb/NanoDroid_FileList exists, assume System Mode installation, even if Magisk exists
  * error-out if /data couldn't be mounted

CommonInstaller, Uninstaller, Patcher
  * add busybox build by osm0sis (used during installation only)
     * fixes possible installation issues with Stock ROMs from TWRP

* Uninstaller
  * fix restoring GApps from /system/app in System Mode installations
  * fix removing NanoDroid-Patcher installfile

* On-PC Patcher
  * fix creating uninstaller information for System Mode

* CommonInstaller, Patcher
  * mount /vendor partition, increases compatibility with several ROMs
  * if there's no /vendor partition, but /system/vendor exists, create a compatibility link, which is required on some ROMs

* NanoDroid-Overlay
  * fix System Mode support

### General Changes

* CommonInstaller
  * extend GApps debloat blacklist to filter out more stuff
  * don't set progressbar when flashing from Magisk Manager
  * when migrating from Play Store to Fake Store or vice versa during new installs get rid of that store's app data, too
  * code simplifications
  * minor string change

* CommonAddon
  * declare addon.d version 2 support
  * code simplifcations

* CommonInstaller, CommmonAddon, Uninstaller
  * move installer information for System Mode from /data/adb/.nanodroid-list to /data/adb/NanoDroid_FileList
    * CommonAddon and Uninstaller support both
  * simplify code for the creation of the installer information

* Patcher, CommonInstaller, Uninstaller
  * move patcher installfile from /data/adb/.nanodroid-patcher to /data/adb/NanoDroid_Patched

* CommonInstaller, Uninstaller
  * remove support for old NanoMod modules

* CommonInstaller, Patcher
  * log all mounted paritions in the recovery.log

* Uninstaller
  * display correct version number
  * exit when flashing from Magisk Manager without doing anything
  * remove support for ancient versions (< 12.0)
  * code simplifications

* Patcher
  * if ROM's odex method is VDEX, **try** to automatically deodex it
     * bundle vdexExtractor (0.5.1)
  * if ROM's odex method is ODEX, **try** to automatically deodex it
     * bundle baksmali and smali
         * SDK <= 25 version 2.2.2
         * SDK >= 26 version 2.2.5
  * if ROM's services.jar already contains classes.dex, skip deodexing
  * update dexpatcher (1.6.1)
  * simplify code
  * remove old code

* Full, microG packages
  * add Google Sync Adapters for Android P
  * improve Google Sync Adapters permission file
  * update microg-a5k permissions file to latest upstream version

### Updates

* automatic
  * QKSMS (3.4.5)
  * F-Droid (1.4-alpha1)
  * (Simple) Gallery (4.6.1)
  * Amaze (3.3RC2)
  * Substratum (1001)
  * K9-Mail (5.600)

* manual
  * microG GmsCore (0.2.5.12879-149-477b244-custom)
  * Play Store (11.6.15)

* tools
  * vdexExtractor (0.5.1)
  * smali/baksmali (2.2.2 [SDK <= 25])
  * smali/baksmali (2.2.5 [SDK <= 26])
  * dexpatcher (1.6.1)

## 17.9.20180818

### Bug Fixes

* CommonInstaller
  * fix System Mode installation in several cases, caused by linking issues

### General Changes

* CommonInstaller
  * value `2` for `nanodroid_play` will now only install Yalp Store
  * value `3` for `nanodroid_play` will now check if Play Store is installed and will get rid of it in favour of Fake Store
  * value `1` for `nanodroid_play` will now check if Fake Store is installed and will get rid of it in favour of Play Store
  * simplify App Store installation routine
* CommonInstaller, SetupWizard
  * new value `4` for `nanodroid_play`, will install Yalp Store and Fake Store
  * new setting `nanodroid_override`, whether to override an existing app
     * `0` means that a ROM app is preferred against a NanoDroid app, where `1` means the NanoDroid apps is prefered.

### Updates

* manual
  * Play Store (11.3.15)

## 17.8.20180811

### Bug Fixes

* CommonInstaller
  * improve GApps removal mechanism (most noticable: fix Play Store data loss during upgrade)
* CommonAddon
  * improve GApps removal mechanism (most noticable: fix Play Store data loss during upgrade)
* force-debloat.sh
  * fix support for A/B partition scheme
* on-pc framework-patcher
  * fix support for A/B partition scheme

### General Changes

* NanoDroid-Font (nanodroid-font)
  * add `Splatoon` and `SuperMarioOdyssey` fonts
  * in Sytem Mode only backup original font, if the requested custom font exists
* README
  * add weblinks in the Credits section

### Updates

* automatic
  * F-Droid (1.3.1)
  * QKSMS (3.4.4)
  * KeePass DX (2.5.0.0beta17-libre)
  * (Simple) Gallery (4.5.2)

## 17.7.20180809

### Bug Fixes

* CommonPatcher
  * fix for A/B partition scheme support
* Uninstaller
  * fix for A/B partition scheme support
* CommonInstaller
  * fix upgrade-detection for System Mode
* NanoDroid-Upgrade (nanodroid-upd)
  * improve check for proper wget implementation

### General Changes

* force-debloat.sh
  * support A/B partition scheme
* on-pc framework-patcher
  * support A/B partition scheme
* Full package
  * remove Lock/Unlock sounds
* NanoDroid-Upgrade (nanodroid-upd)
  * add `mg`, `microG` parameter to update microG GmsCore custom build
  * add `dg`, `DroidGuard` parameter to update microG DroidGuard Helper custom build
  * remove `bt`, `Bucket` parameter as it no longer supported

### Updates

* automatic
  * (Simple) Calendar (4.1.3)
  * F-Droid (1.3)

* manual
  * Play Store (11.2.14)
  * MPV (20180806)
  * GNU Bash (4.4.23)

## 17.6.20180805

### Bug Fixes

* CommonInstaller
  * fix creating uninstaller information for GSync adapters (System Mode)
  * fix permission setting for GSync adapters (System Mode effected)
  * fix for A/B partition scheme support
  * fix for upgrade-detection mechanism when upgrading from Magisk Manager

## 17.5.20180803

### Bug Fixes

* CommonInstaller
  * fixed installation from TWRP with Magisk 16.6 (or newer) if device was never booted into ROM once
  * (possibly) fixed support for devices with A/B partition scheme

### Updates

* automatic
  * (Simple) Gallery (4.4.1)

* manual
  * microG GmsCore (0.2.4-127)
     * bumps spoofed Play Services Version to 12.8.74
  * mpv (20180802)
     * new upstream snapshot
  * Google Play (11.0.50)

## 17.4.20180731

### Bug Fixes

* CommonInstaller
  * fixed a bug that caused NANODROID_UPGRADE to be wrongly set to 0
     * causing issues with permissions for Play Store and microG GmsCore

### Updates

* automatic
  * Google Play (11.0.20)

## 17.3.20180730

### Bug Fixes

* CommonInstaller
  * improve permissions-resetting during GApps removal
      * now ensured to be only triggered on fresh NanoDroid installations
* Full, microG packages
  * fix Google Play issues due to missing privapp-whitelisted permissions
  * likewise for microG GmsCore

### Updates

* automatic
  * Substratum (999)
  * (Simple) Gallery (4.4.0)
  * OpenKeychain (5.2)
  * QKSMS (3.4.2)
  * NewPipe (0.13.7)
  * F-Droid (1.3-alpha5)
  * KeePass DX (2.5.0.0beta15-libre)
  * (Simple) Calendar (4.1.2)
  * Face Slim (3.4.0)

* manual
  * Google Play (10.5.80)

## 17.2.20180714

### Bug Fixes

* CommonInstaller
  * fix installation through Magisk Manager
* nanodroid-overlay Script
  * fix `-r` parameter not working

### General Changes

* Full package
  * switch from Bucket/LibreSubstratum to Substratum App
     * Bucket was abandoned
     * if the user had Bucket in the lists of applications to install, NanoDroid will auto-migrate to Substratum
  * add OmniClock and pseudo/debloat DeskClock by default
     * OmniClock allows to disable that brain-dead pre-alerts
     * if OmniClockOSS is installed, OmniClock is not installed
  * switch from stable Amaze build to official beta build
* Full, microG packages
  * custom builds for microG GmsCore and microG DroidGuard Helper
     * fix Safety Net attestation, Play-Services update-nag
     * more information below
  * by default install Déjà Vu and Mozilla nlp Backends
  * improve GApps uninstallation routine
     * properly remove data for GApps, aswell, but only it's a fresh NanoDroid installation
* CommonInstaller, CommonPatcher, Uninstaller
  * improved A/B device support code taken from Magisk 16.6
* CommonInstaller
  * move installation log destinations
     * /data/adb/.nanodroid_MODID >> /data/adb/MODID_log_DATE
     * /data/adb/.recovery_MODID >> /data/adb/MODID_twrp_DATE
  * where DATE has %Y%m%D_%H.%M.%S format (eg: 20180709_20.34.14)
  * where MODID is either NanoDroid, NanoDroid_microG or NanoDroid_FDroid
* Uninstaller
  * also remove installation logs upon uninstallation

### Updates

* automatic
  * Orbot (16.0.2-RC1)
  * (Simple) Calendar (4.1.1)
  * (Simple) Gallery (4.3.3)
  * OpenKeychain (5.1.4)
  * QKSMS (3.3.3)
  * Yalp Store (0.43)
  * AnySoftKeyboard (1.9.1944)
  * NewPipe (0.13.5)
  * KeePassDX (2.5.0.0beta11-libre)
  * Substratum (997)
  * OmniClock (2.0.14)
  * K9-Mail (5.503)
  * nlpBackend Déjá Vu (1.1.8)
  * FDroid (1.3-alpha3)
  * Termux (0.64)
  * nlpBackendIchnaea (1.4.0)
  * Kernel Adiutor (0.9.11.1)
  * AnySoftKeyboard (1.9.2055)
  * Amaze (3.3.0RC1)
  * GNU Nano (2.9.8)
  * Odyssey (1.1.15)

* manual
  * Play Store (10.8.23)
  * microG GmsCore (0.2.4-126_custom)
     * bumped spoofed Play Services version
         * fixes 'update your Play Services' nag
     * built as priviledged module
     * including 'null check for issue 560', see [this pull request](https://github.com/microg/android_packages_apps_GmsCore/pull/561)
     * including 'temporarly whitelist app upon high-priority GCM messages', see [this repo](https://github.com/ale5000-git/android_packages_apps_GmsCore/commits/master)
  * microG DroidGuard Helper (0.1.0-17_custom)
     * fixes SafetyNet attestation with microG
     * see [this pull request](https://github.com/microg/android_packages_apps_RemoteDroidGuard/pull/19)
  * MPV (20180627_custom)
     * latest upstream snapshot (with additional pull requests)

## 17.1.20180507

### Bug Fixes

* CommonInstaller
  * fix installation on ROMs that don't have /system/xbin

### Updates

* automatic
  * OpenKeychain (5.0.1)
  * NewPipe (0.13.3)
  * KeePassDX (2.5.0.0beta9-libre)
  * QKSMS (3.1.1)
  * Yalp Store (0.40)
  * F-Droid Privileged Extension (0.2.8)
  * Bucket (0.2.1-beta-1253)

* manual
  * Play Store (9.9.21)

## 17.0.20180430

### Bug Fixes

* CommonInstaller
  * System Mode
     * fix creating Uninstaller/Addon information
     * fix auto-debloating conflicting GApps when already done before
     * create /data/adb if it does not exist
     * honour nanodroid_overlay=1 due to new NanoDroid-Overlay
  * Magisk Mode
     * fix that conflicting GApps were not overlayed if nanodroid_overlay=0
         * now this part of CommonInstaller ignores nanodroid_overlay to ensure conflicting GApps are always overlayed
* CommonPatcher
  * move addon.d from 75 to 999 (should now be executed after Magisk (99))
* Full, microG packages
  * minor fix in default microG permissions file
* Uninstaller
  * System Mode
     * fix uninstallation if a previously moved-out GApp exists already in ROM, instead remove the backup

### General Changes

* CommonInstaller
  * System Mode
     * improve creation of Uninstaller/Addon information
     * install addon.d (CommonAddon)
  * System Mode, Magisk Mode
     * simplify routine to overlay conflicting GApps due to new NanoDroid-Overlay
* CommonAddon
  * System Mode
     * Addon for OTA survival
     * restore NanoDroid-Font settings after OTA update
     * re-remove conflicting GApps after OTA update
     * shares file list with Uninstaller
* NanoDroid-Overlay
  * when an app is installed in /system/app **and** /system/priv-app it was only pseudo-debloated from /system/app, now the script does not stop if an requested app was found in /system/app, thus pseudo-debloating both instances
     * this is a rare corner case
  * System Mode support
     * apps will be moved from /system to /sdcard/nanodroid_backups
     * can be restored
     * .nanodroid-overlay configuration file is honoured
  * no longer requires aapt utility
  * no longer requires column utility
  * faster, cleaner, better overall code
* NanoDroid-UPD
  * support updating Bucket (LibreSubstratum) beta
* NanoDroid-Prop
  * no longer requires column utility
* Full package
  * switch to QKSMS 3
  * switch from Substratum (app) to Bucket (beta; former LibreSubstratum)
     * if the user had Substratum in their .nanodroid-apps it will be auto-migrated
  * column is now optional (only installed with nanodroid_utils=1)
* microG package
  * removed aapt as it's no longer required
  * removed column as it's no longer required
* Uninstaller
  * System Mode
     * sync list of GApps with CommonInstaller
     * restore System font if altered using NanoDroid-Font upon uninstallation
     * update for new addon.d changes
* SetupWizard
  * update for Substratum > Bucket change
  * string changes
* Documentation
  * updated Debloat Feature section regarding System Mode support
  * updated to reflect Addon.d support for System Mode installation
  * other minor updates

### Updates

* automatic
  * QKSMS (3.0.9)
  * NewPipe (0.13.2)
  * Orfox (1.5.2-RC1)
  * F-Droid (1.3-alpha0)
  * Face Slim (3.3.0)
  * Odyssey (1.1.14)
  * (Simple) Gallery (3.8.2)
  * Yalp Store (0.39)
  * (Simple) Calendar (3.4.2)
  * OpenLauncher (0.5.12)
  * OpenKeychain (5.0)
  * Open Camera (1.43.3)
  * Bucket (0.2.1-beta-1236)

* manual
  * Play Store (9.8.07)
  * MPV (20180421+merges)

## 16.5.20180402

### Bug Fixes

* CommonInstaller
  * fix microG GsfProxy not installed in System Mode
  * fix restoration tasks during NanoDroid update when upgrading from Magisk Manager
     * restore NanoDroid-Font settings
     * restore NanoDroid-Prop settings
     * restore patched `services.jar` (if applicable)

### General Changes

* CommonInstaller
  * Full, microG packages
     * improve GApps removal mechanism
     * improve some installer messages
     * new value 3 for nanodroid_play variable will install Fake Store only
* Full, microG packages
  * move microG GsfProxy from /system/priv-app to /system/app
* Full package
  * download Orbot and Orfox from Guardian Project F-Droid repo instead from the release mirror
  * revert to stable QKSMS build (2.7.3)
* SetupWizard
  * update for nanodroid_play value 3

### Updates

* Automatic
  * GNU Nano 2.9.5
  * F-Droid (1.2-alpha0)
  * (Simple) Calendar (3.4.1)
  * (Simple) Gallery (3.6.3)
  * KeePass DX (2.5.0.0-beta7)
  * microG GmsCore (0.2.4-111)

* Manual
  * Play Store (9.4.18)
  * MPV (20180402+merges)

### Downgrades

* Automatic
  * QKSMS (2.7.3)

## 16.4 20180328

### Bug Fixes

* CommonInstaller
  * fix magisk.img handling when an installation error occurs
  * fix storing recovery.log in /data/adb/ after installation
* Full Package
  * MPV build from 16.3 crashed on x86_64 and arm64, fixed build included

### General Changes

* CommonInstaller
  * programmatic /system/xbin handling
     * if /system/xbin exists in ROM use it for installing utilities and scripts
     * if /system/xbin does not exist in ROM, use /system/bin instead
  * progressbar functions
     * stuff taken from osm0sis' busybox installer
* Full, F-Droid, microG packages
  * don't unmount /system at the beginning of the installation process, just to re-mount it later during mount_partitions()
  * utilize CommonInstaller progressbar functions for proper progressbar display

### Software Updates

* Automatic
  * GNU Nano (2.9.4)

## 16.3.20180327

### Bug Fixes

* CommonInstaller
  * on devices with A/B partition scheme System Mode installation did not mount /system read-write in all cases
* SetupWizard
  * fix creating setup value for location backend

### General Changes

* Documentation
  * updated
* Common Installer
  * Full, microG, F-Droid packages
     * improved A/B partition scheme support
  * Full, microG packages
     * move binaries from /system/xbin to /system/bin
         * some stock ROMs no longer have /system/xbin, which will cause bootloops if Magisk creates it nonetheless
     * remove conflicting GApps during installation, list by ale5000
         * in Magisk Mode they will be pseudo-debloated
         * in System Mode they will be moved to /sdcard/nanodroid_backup
     * also see SetupWizard changes for now more flexible Full and microG package setups
  * Full package
     * if the user has KeePassDroid in their list of applications to install, install KeePass DX instead
  * Full, F-Droid packages
     * include default permissions file for F-Droid Privileged Extension
* Full package
  * switch from stable to beta build for QKSMS
  * switch to official OpenLauncher F-Droid build as it was finally™ updated
  * switch to custom build for MPV from latest upstream and the following merge-requests
     * [hwdec_surfacetexture support](https://github.com/mpv-android/mpv-android/pull/110)
     * [mpv.conf editing](https://github.com/mpv-android/mpv-android/pull/108)
     * [background playback improvements](https://github.com/mpv-android/mpv-android/pull/104)
     * [audio delay preferences](https://github.com/mpv-android/mpv-android/pull/113)
  * drop KeePassDroid
  * include KeePass DX
     * Material UI
     * Fingerprint support
     * Android Oreo Autofill support
* microG package
  * no longer include GNU Bash
* SetupWizard
  * change default location for configuration files from /data to /sdcard
  * update for KeePassDroid > KeePass DX transistion
  * new setup variables (Full package)
     * nanodroid_bash=[0|1] whether to install GNU Bash, Less pager
     * nanodroid_nano=[0|1] whether to install GNU Nano Editor
     * nanodroid_utils=[0|1] whether to install Shell Utilities
     * nanodroid_fonts=[0|1] whether to install NanoDroid-Fonts script and Nintendo Fonts
  * removed setup variables (Patcher)
     * nanodroid_sigspoofui=[0|1]
* On-Device Patcher, Uninstaller
  * initial A/B parition scheme support
* On-PC Patcher, On-Device Patcher, addon.d
  * drop Sigsppof UI support
* On-Device Patcher, addon.d
  * unify code into CommonPatcher
* Uninstaller
  * restore GApps backup upon uninstallation (System Mode)

### NanoDroid Scripts

* NanoDroid-Overlay Script
  * does not (more precisly: no longer) require Bash, default Shell is enough
  * split into different scripts

* NanoDroid-Overlay Script
  * now only includes overlay (= Pseudo Debloat) related functions
  * shell name: nanodroid-overlay
  * shell name: novl
* NanoDroid-UPD
  * functions to update custom NanoDroid apks
     * PlayStore
     * FakeStore
     * MPV
  * shell name: nanodroid-upd
  * shell name: nupd
* NanoDroid-Prop
  * functions related to resetprop
  * shell name: nanodroid-prop
  * shell name: nprp
* NanoDrod-Perm
  * functions releated to permissions
  * shell name: nanodroid-perm
  * shell name: npem
* NanoDroid-Util
  * remaining functions
     * OTA update fix (non-working navbar et all)
     * Airplane Mode settings
     * Audio Focus Permission management
     * Display Boot Count
     * Clipboard Reading Permission management
  * shell name: nanodroid-util
  * shell name: nutl

* NanoDroid-Font
  * new script to change the system font (Full package only)
  * controlled by nanodroid_fonts setup variable
  * possible fonts:
     * FAST
     * NintendoLabo
     * NintendoSwitch
     * Splatoon2
     * SuperMarioMaker
     * SuperMario
  * example: `nanodroid-font --set Splatoon2` and reboot
  * shell name: nanodroid-font
  * shell name: nfnt

### Software Updates

* Automatic
  * AnySoftKeyboard (1.9.1117)
  * Déjà Vu nlpBackend (1.1.5)
  * Open KeyChain (4.9.1)
  * XDA Labs (1.1.6b)
  * F-Droid (1.1)
  * (Simple) Gallery (3.6.2)
  * QKSMS (3.0-beta7)
  * K-9 Mail (5.502)
  * KeePass DX (2.5.0.0.beta6)
  * Kernel Adiutor (0.9.10.3)
  * OpenLauncher (0.5.10)
  * AdAway (3.3)
  * Oandbackup (0.2.13)
  * Orfox (1.5.1-RC1)
* Manual
  * GNU Bash (4.4.19)
  * Play Store (9.3.14)
  * MPV (20180318+merges)

## 16.2.20180302

* Bug Fixes
  * Full, microG, F-Droid packages
     * fix storing recovery.log in /data/adb/ after installation
* General Changes:
  * Full, microG, F-Droid packages
     * use modified Magisk mount code to support of devices with A/B partion scheme
  * Full, microG packages
     * install microG permission settings file by ale5000
         * updated Credits section in README
         * extended by FAKE_SIGNATURE permission for microG Gms Core and Play Store
         * removed NewPipe from microG permissions file
     * install DroidGuard Helper as system app
         * fixes SafetyNet attesting CTS-Profile on several devices
         * in Magisk Mode Droid Guard Helper crashes as system app, thus it will be re-installed as user app upon first boot
  * Full package
     * logcat init script removes all logcats older than 7 days upon reboot to prevent pollution
  * nanodroid-overlay Script
     * add `-U`, `--update-apks` switch to nanodroid-overlay script, downloads and installs latest versions of custom NanoDroid apks, requires Busybox to be installed (for wget applet)
         * Fake Store
         * Play Store
         * OpenLauncher
* Updates (automatic)
  * KeePassDroid (2.2.1)
  * F-Droid (1.1-alpha3)
  * Odyssey (1.1.13)
  * (Simple) Calendar (3.3.0)
  * (Simple) Gallery (3.5.2)
  * Kernel Adiutor (0.9.74.3)
  * K-9 Mail (5.501)
  * OpenKeychain (4.9)
  * MPV (20180222)
     * switch from custom to official build
* Updates (manual)
  * Play Store (9.0.15)

## 16.1.20180209
* Bug Fixes:
  * Full, microG packages
     * when becoming su from GNU Bash the default sh instead of GNU Bash would become the active shell
         * this is fixed now by always passing `--shell /system/xbin/bash.bin` to su when it is invoked from with a running GNU Bash instance
     * fix ${TMPDIR} for GNU Bash is set to a non-writable directory
         * create ${TMPDIR} for GNU Bash if it does not exist
         * defaults to /sdcard/.bash_tmp
     * fix ${HISTFILE} for GNU Bash not being set, thus history functionality not working
         * defaults to /sdcard/.bash_history
* General Changes
  * Full, microG packages
     * when starting GNU Bash cd into /sdcard
     * make /sdcard ${HOME} for non-root users in GNU Bash
     * export ${SHELL} set to GNU Bash when it is invoked in interactive mode
     * only clear and resize the buffer on start for interactive GNU Bash sessions
     * nicer ${PS1} for interactive GNU Bash sessions
     * ensure GNU Bash uses our version of the less pager, even if busybox' version is installed
     * make ls use colors, if possible when in GNU Bash
     * make grep use colors, if possible when in GNU Bash
  * Full packages
     * record logcat in /data/adb/logcat/${CURDATE}
         * e.g.: /data/adb/logcat/20180208-07.05.18
* Updates (automatic)
  * XDA Labs (1.1.4b)
  * (Simple) Calendar (3.2.4)
  * F-Droid (1.1~alpha2)
  * (Simple) Gallery (3.4.0)
  * Déjà Vu nlpBackend (1.1.1)
  * Termux (0.60)
  * Yalp Store (0.35)
  * Odyssey (1.1.12)
* Updates (manual)
  * PLay Store (8.9.23)
  * GNU Nano (2.9.3)
  * GNU Bash (4.4.18)

## 16.0.20180130
* Important Notes
  * this release changes the name from 'NanoMod' to 'NanoDroid'
     * the module IDs will change as follows
         * NanoMod		NanoDroid
         * NanoModmicroG	NanoDroid_microG
         * NanoModfdroid	NanoDroid_FDroid
     * the nanomod-overlay script is now nanodroid-overlay
         * the novl shortcut is unchanged
     * the installers will take care of getting rid of the old modules
* Bug Fixes:
  * nanodroid-overlay script
     * fix `-p`, `--permission` switch not working in System Mode
  * Full, microG package
     * fix Google Sync Adapters installation
  * microG package
     * fix aapt not installed
  * Common Installer
     * fix system environment detection bugs
     * improve installation mode detection
     * fix installation through Magisk Manager
     * fix creating system overlays when installing through Magisk Manager
     * fixed the most A-N-C-I-E-N-T NanoDroid bug (TMANB™)
         * fix installation through Magisk Manager does not reach end properly
  * Uninstaller
     * fix that Patcher addon.d was only removed in System Mode
     * remove Patcher lockfile aswell
* General Changes:
  * Downloads
     * as before all files are available from AFH (including archive)
         * short-links renamed from NanoMod to NanoDroid
     * additionally the latest stable and beta releases are now mirrored on Nanolx
         * Stable Downloads [> Nanolx](https://downloads.nanolx.org/NanoDroid/Stable)
         * Beta Downloads [> Nanolx](https://downloads.nanolx.org/NanoDroid/Beta)
  * Common Installer
     * take care of getting rid of old-named module upon installation
     * generalize function showing the NanoDroid banner
     * improve and revise several code segments
  * Full, microG, F-Droid packages
     * move banner displaying into Common Installer
     * update Magisk module.props for name change
     * improve Magisk module.props description
     * further code simplification
  * Patcher:
     * remove old addon.d setups when installing new
  * Configuration Files
     * the installers will auto-rename configuration files if necessary
         * .nanomod-setup	.nanodroid-setup
         * .nanomod-apps	.nanodroid-apps
         * .nanomod-overlay	.nanodroid-overlay
     * the installers will migrate the variable names to the new ones if necessary
  * Uninstaller
     * support all installations (NanoMod <15.0, NanoMod <16.0 and NanoDroid)
     * code revision and simplification
* Updates (automatic)
  * Substratum (953)
  * NewPipe (0.11.5)
  * BeHeKeyboard (1.1.2)
  * (Simple) Gallery (3.2.4)
  * Yalp Store (0.34)
  * K-9 Mail (5.403)
* Updates (manual)
  * Play Store (8.8.12)

## 15.1.20180119
* Bug Fixes:
  * Patcher package, addon.d
     * fix architecture detection
     * mount /system read-write if required
  * Uninstaller
     * fix restoring Settings.apk backup (if any)
* General Changes:
  * Full, microG, F-Droid packages
     * split out common installer functions (~ 95 %) into separate file
  * Common installer
     * contains most installer functions (~ 95 %)
     * code revision to do most stuff with least calls
         * support all Full, microG, F-Droid packages without code duplications
  * Full package
     * provide custom OpenLauncher build from latest sources
  * Uninstaller
     * support both old (<15.0) and new (>=15.0) system mode installations
     * only mount /system read-write if a system mode installation exists
     * revise and simplify the code
* Updates (automatic):
  * nlpBackendDéjàVu (1.0.8)
  * (Simple) Gallery (3.2.3)
  * NewPipe (0.11.4)
  * Odyssey (0.1.11)
  * (Simple) Calendar (3.1.0)
* Updates (manual):
  * MPV (20180118)
  * OpenLauncher (20180118)

## 15.0.20180113

* Important Notes:
  * if using as a Magisk Module the minimum required Magisk version is now 15.0
* General Changes
  * Full package
     * custom MPV build from latest upstream source
  * Full, microG packages
     * add Déjà Vu unified location provider backend
     * custom FakeStore build featuring CHECK_LICENSE permission
     * install SDK 26 (8.0) Google Sync Adapters on SDK 27 (8.1), if requested
  * Full, microG, F-Droid packages
     * installation routines completely rewritten
     * installer now enforces apk and directory name to be equal
     * uninstaller information is now created in /data/adb/.nanomod-patcher
     * uninstaller information is removed prior installation and then re-created during
     * patcher now creates it's lockfile in /data/adb/.nanomod-patcher
     * update to new Magisk paths introduced in 15.0
     * create better error messages
     * several other internal changes
     * save TWRP log in /data/adb/.recovery_MODID
        * where MODID is either NanoMod, NanoModmicroG or NanoModfdroid
     * save additional log data in /data/adb/.nanomod_MODID
        * where MODID is either NanoMod, NanoModmicroG or NanoModfdroid
     * prevent Full and submodules installed at the same time (obviously redundant)
        * Full package will remove microG and F-Droid packages, if found
        * microG or F-Droid packages will abort installation if Full package is found
        * microG and F-Droid packages can still be installed together
  * Patcher package (on-device), addon.d
     * remove restriction for SDK 27 (Android 8.1)
     * don't apply UI patch for sigspoof on SDK 25 or newer
         * was SDK 26 or newer previously
     * add back explicit, improved odex check (for more meaningful error message)
     * install addon.d into /data/adb/nanomod_patcher
     * create patcher file as /data/adb/.nanomod-patcher
     * addon.d removes /data/adb/.nanomod-patcher prior patching and re-creates it upon success
     * /system only mounted with read access
     * update to new Magisk paths introduced in 15.0
     * several other internal changes
  * SetupWizard
     * update string to reflect that Sigspoof UI is SDK <25 only
     * add option `nanomod_nlpbackend`, choose microG location backend
         * 0 = no location backend
         * 1 = Déjà Vu location backend
         * 2 = Ichnaea (Mozilla) location backend
         * 3 = Déjà Vu and Ichnaea location backends
   * nanomod-setup configuration file
     * add option `nanomod_nlpbackend`, choose microG location backend
         * 0 = no location backend
         * 1 = Déjà Vu location backend
         * 2 = Ichnaea (Mozilla) location backend
         * 3 = Déjà Vu and Ichnaea location backends
  * Patcher script (on-pc)
     * remove restriction fro SDK 27 (Android 8.1)
     * don't apply UI patch on SDK > 25
         * already the case for Patcher package and addon.d
     * support both old and new Magisk paths
  * nanomod-overlay script
     * don't create system.prop if not actually required
     * update to new Magisk paths introduced in 15.0
  * Uninstaller package
     * update for latest changes
     * supports both old and new Magisk image paths
  * mount-magisk script
     * support both old and new Magisk paths
  * build-package script
     * check for dependencies prior to downloading
* Updates [automatic]
  * NewPipe (0.11.3)
  * (Simple) Calendar (3.0.1)
  * (Simple) Gallery (3.0.2)
  * Termux (0.59)
  * Yalp Store (0.32)
  * nlpBackendIchnaea (1.3.3)
  * nlpBackendDejavu (1.0.7)
  * Open Camera (1.42.1)
  * Odyssey (1.1.10)
  * Twidere (3.7.2)
  * Substratum (931)
  * microG GmsCore (0.2.4-108)
  * Orbot (16.0.0-RC2)
* Updates [manual]
  * FakeStore (0.0.2+CHECK_LICENSE)
  * MPV (20180103)

## 14.9.20171213

* Updates
  * microG GmsCore (0.2.4-107)
  * OpenKeychain (4.8.1)
  * (Simple) Gallery (2.19.0)
  * OpenLauncher (0.5.8alpha)
  * Termux (0.56)
  * Yalp Store (0.31)
  * BeHe Keyboard (1.1.0)
  * (Simple) Calendar (2.12.0)
  * F-Droid (1.1-alpha0)
  * KeePassDroid (2.2.0.9)

## 14.8.20171130
* General Changes
  * Full package
     * use official build for Kernel Adiutor
  * Framework-Patcher package, addon.d
     * update `dexpatcher` to 1.6.0
     * collect additional information from `dexpatcher` for debugging purposes
  * nanomod-overlay/novl Script:
     * check if running as root, if not exit
* Updates
  * KeePassDroid (2.2.0.8)
  * Kernel Adiutor (0.9.73.3)
  * Odyssey (1.1.8)
  * OpenCamera (1.42)
  * GNU Nano (2.9.1)

## 14.7.20171115
* Bug Fixes
  * Full, microG packages
     * fix GNU Bash startup configuration
     * fix GNU Bash wrapper script
  * Full package
     * fix GNU Nano wrapper script
  * build-package script
     * fix downloading Substratum from APK Mirror
* General Changes
  * nanomod-overlay script
     * be more robust against wrong or incomplete user input
  * Full package
     * use official GitHub pre/build for Twidere
     * use official GitHub pre/build for KeePassDroid
* Updates
  * Orbot (15.5.1-RC2)
  * K9-Mail (5.304)
  * Twidere (3.7.3)
  * (Simple) Calendar (2.9.2)
  * (Simple) Gallery (2.17.3)
  * NewPipe (0.11.0)
  * Odyssey (1.1.7)
  * Substratum (914)
  * KeePassDroid (2.2.0.1)
  * Yalp Store (0.29)

## 14.6.20171031
* General Changes
  * Full, microG packages:
     * switch to official microG GmsCore build, modifying Play Store alone is enough for (in-)app purchases to work
     * remove unused variables and aliases from Bash configuration file
     * make bash, nano, less wrappers not throw a message if `resize` command is not available
         * in case your OS does not have a `resize` command, install osm0sis' Busybox
     * nano, less wrappers only set TERMINFO if it actually exists
     * add crDroidFilemanager to list of apps pseudo-debloated by default
         * crDroidFilemanger = Amaze
     * add crDroidMusic to list of apps pseudo-debloated by default
     * if `com.qualcomm.location` is found, only add it to the list of pseudo-debloated applications, if it isn't already
  * Full package:
     * some ROMs call Adaway AdAway instead (not the capital A)
         * let the installer handle that case, so the user does not get a double-installation of Adaway
     * if an application provided by NanoMod is already part of the ROM don't install it
  * nanomod-overlay Script:
     * added `-f`, `--fix-update` parameter, fixes navbar, lockscreen, statusbar issues after OTA update
         * see: https://www.xda-developers.com/broken-navigation-bar-lock-screen-ota-update/
     * added `-P`, `--airplane-mode` parameter, allows to choose which radios are disabled in Airplane Mode
         * those will not be activatable, until Airplane Mode is deactivated
         * user is given instructions when this parameter is called
     * added `-b`, `--boot-count` parameter, show how often the device was booted
         * required Android 7.0 or newer
     * added `-F`, `--audio-focus` parameter, prevent given application from stealing audio focus
         * pass application name as parameter, example: `novl -F com.test.application`
     * added `-B`, `--read-clipboard` parameter, prevent given application from reading the clipboard
         * pass application name as parameter, example: `novl -B com.test.application`
     * `-b|B|f|F|P` paramters are available in both Magisk and System Mode
* Updates (automatic)
  * OpenCamera (1.41.1)
  * (Simple) Calendar (2.9.1)
  * F-Droid (1.0.1)
  * NewPipe (0.10.1)
  * (Simple) Gallery (2.17.2)
  * Orbot (15.5.0.RC1)
  * Termux (0.54)

## 14.5.20171022
* General Changes
  * Full, microG packages:
     * make `sed` shut up when `nanomod-overlay -[A|C|L|R]` is called for the first time
     * add `novl` script as shortcut for `nanomod-overlay` script
  * Full package:
     * switch from APK Mirror build to F-Droid build for Kernel Adiutor
  * Full, microG, F-Droid, Uninstaller, Framework-Patcher package, Framework-Patcher addon.d, force-debloat script, nanomod-overlay script
     * no longer support `/persist` as location for configuration files
* Updates (manual)
  * Play Store (8.3.43.U)
* Updates (automatic)
  * (Simple) Calendar (2.8.2)
  * F-Droid (1.0)
  * Twidere (3.7.1)
  * Yalp Store (0.28)

## 14.4.20171014
* Bug Fixes
  * Full, microG packages:
     * fix patched `services.jar` backup and restore upon update (if any)
* General Changes
  * Framework patcher package, addon.d:
     * don't patch `Settings.apk` on Oreo (regardless of user's choice)
     * update patches to latest versions
     * update `dexpatcher` to version 1.5.0
  * Full package:
     * switch from F-Droid build to Pre-Release build for K-9 Mail
* Updates (manual)
  * Play Store (8.3.42.U)
* Updates (automatic)
  * (Simple) Calendar (2.8.1)
  * Twidere (3.7.0)
  * F-Droid (1.0-alpha5)
  * (Simle) Gallery (2.15.2)
  * Yalp Store (0.27)
  * Kernel Adiutor (0.9.73.1)
  * K-9 Mail (5.300)

## 14.3.20171005
* Bug Fixes
  * Framework-patcher addon.d:
     * prefer TWRP binaries over system binaries
  * nanomod-overlay Script:
     * fix `-A` and `-R` parameters
* General Changes
  * build-package Script:
     * code consolidation and simplification
  * Full, microG packages:
     * Google Sync Adapters for Oreo are now pulled from OpenGApps
  * Framework-patcher addon.d:
     * display version number
* Updates (manual)
  * Play Store (8.3.41.U)
* Updates (automatic)
  * F-Droid (1.0-alpha4)
  * (Simple) Gallery (2.15.1)
  * Face Slim (3.2.1)
  * OpenKeychain (4.7)
  * (Simple) Calendar (2.7.6)
  * OpenLauncher (0.5.5)
  * Substratum (854)

## 14.2.20170925
* Bug Fixes
  * Framework-Patcher addon.d:
     * Fix error when trying to mount magisk.img
     * Use /dev/tmp for custom dalvik-cache to ensure it works in all cases
* General Changes
  * Framework-Patcher package, addon.d:
     * drop odex check (dexpatcher fails on odexed ROMs anyway)
     * drop separate dalvik-cache creation (decreases required time)
     * apply patches in parallel (majorly decreases required time)
     * no longer support `nanomod_forcesystem` setting
     * other minor internal improvements
     * Update dexpatcher to 1.4.0
* Updates (manual)
  * Play Store (8.2.55.T)
     * built with Apktool 2.3.1 for full Oreo/InstantApps support
* Updates (automatic)
  * Substratum (853)
  * New Pipe (0.10.0)
  * (Simple) Gallery (2.14.4)
  * Yalp Store (0.26)
  * F-Droid Privileged Extension (0.2.7)

## 14.1.20170923
* Bug Fixes
  * Framework-Patcher package, addon.d:
     * Fix installation into `/system`
* General Changes
  * nanmod-overlay Script:
     * add `-C, --cast` parameter, fixes cast not working on some custom ROMs
         * uses Magisk to enable `persist.debug.wfd.enable` both on-the-fly and permanently
         * on-the-fly setting may not work, in that case, simply reboot
     * add `-A, --add-prop` parameter, add system property
         * both on-the-fly and permanently
     * add `-R, --remove-prop` parameter, remove a property previously added through `-A, --add-prop`
         * requires reboot to take effect
     * add `-L, --list-props` parameter, list alls properties added through `-A, --add-prop`
  * Full, microG packages:
     * backup and restore `system.prop` generated by `nanomod-overlay`, if any, during update
  * Full package:
     * remove `permissions` init script
* Updates (manual)
  * Play Store (8.2.40.T)
* Updates (automatic)
  * MPV (2017-09-20)

## 14.0a.20170918
* Bug Fixes
  * Framework-Patcher package, addon.d:
     * fix installation path detection
  * force-delobat script:
     * syntax and bug fixes

## 14.0.20170916
* Bug Fixes
  * Full, microG packages:
     * install DroidGuard Helper as user app (fixes it crashing)
     * `com.qualcomm.location` conflicts with microG location backends, so when installing microG
         * in Magisk Mode pseudo-debloat `com.qualcomm.location` (if it exists)
         * in System Mode move `com.qualcomm.location` (if it exists) to /sdcard
  * Full, microG, F-Droid packages:
     * fix that under certain circumstances installation errors don't cause the installer to abort
     * fix that arm libraries are not properly installed on arm64 devices
         * affects applications that have arm libraries, but not arm64 (namely: Play Store)
     * fix that x86 libraries are not properly installed on x86_64 devices
         * affects applications that have x86 libraries, but not x86_64 (namely: Play Store)
     * on x86 / x86_64 try to extract arm libraries, if no x86 / x86_64 libraries are found
     * fix that the installer doesn't clean up if installation of libraries fails in Magisk Mode
     * more verbose recovery.log regarding library installation
     * fix useless recovery.log messages on post-KitKat ROMs
     * Update Magisk functions to Module Template 1400
     * Update Magisk Module template versions to 1400
     * remove TMPDIR after installation
  * Full package:
     * when `.nanomod-apps` contains an application that is not included don't abort
         * instead just print a message
  * Framework-Patcher package:
     * actually patch SecSettings.apk
     * fix backing up SecSettings.apk to /sdcard in System Mode
  * F-Droid package:
     * fix SDK version detection
* General Changes
  * Full, microG, F-Droid packages:
     * minor internal improvements
  * Full package:
     * switch to official F-Droid build for Lightning browser
     * update Magisk Manager module description
  * SetupWizard:
     * updated
  * Uninstaller:
     * if `com.qualcomm.location` was backed up to /scard, restore it
     * restore `SecSettings.apk` or `SecSettings2.apk` if it was backed up to /sdcard
  * Framework-Patcher package:
     * support patching of `SecSettings2.apk` for optional UI patch, aswell
     * big internal code consolidation
  * build-package Script:
     * Fix repo index.xml downloading
  * force-debloat Script:
     * support `.nanomod-overlay` configuration file
         * uses fallback values, if none found, which are in the script itself and can be edited
     * no longer abort when Magisk is installed
     * suggest the user to pseudo-debloat instead when Magisk is installed
     * change the way Magisk is detected
     * add the ability to only test what would be done
     * other minor internal changes
  * Documentation:
     * updated
* Updates (manual)
  * Play Store (8.2.37.T)
* Updates (automatic)
  * F-Droid (1.0-alpha3)
  * F-Droid Privileged Extension (0.2.6)
  * (Simple) Gallery (2.14.2)
  * (Simple) Calendar (2.7.5)
  * Substratum (842)
  * XDA Labs (1.1.3.3b)
  * Yalp Store (0.25)
  * Twidere (3.6.29)
* Removed Applications
  * Hacker Keyboard
* New Applications
  * BeHe Keyboard

## 13.3.20170910
* Bug Fixes
  * Full, microG, F-Droid packages:
     * `magisk.img` is not always created by Magisk 14.0
         * change the way Magisk is detected
         * create `magisk.img` if required
* General Changes
  * build-package Script
     * check SHA256 hash of apks downloaded from
         * F-Droid
         * microG repository
         * APK Mirror
     * other internal improvements
* Updates (manual)
  * Play Store (8.2.36.T)
  * microG GmsCore (0.2.4-105)
* Updates (automatic)
  * (Simple) Calendar (2.7.4)
  * F-Droid (1.0-alpha2)

## 13.2a.20170906
* Bug Fixes
  * Full, microG packages:
     * Fix bootloop with Magisk 13.5 / 13.6 / 14.0

## 13.2.20170906
* Bug Fixes
  * Framework-Patcher package, Framework-Patcher addon.d:
     * include 32 bit paths in `${LD_LIBRARY_PATH}` on 64 bit devices
     * revert back to own magisk.img handling functions
     * other minor fixes
* General Changes
  * Framework-Patcher package, Framework-Patcher addon.d,
  * Framework-Patcher Script:
     * Nougat patches also work on Oreo, remove restriction for SDK 26
  * Full, microG packages:
     * add Oreo Google Sync Adapters (from O DP4)
  * Full, microG, F-Droid packages:
     * remove most apks from GitLab repository
         * instead use `build-package pull` to download latest apks automatically
         * a few apks are still in the repo as `build-package` can't (yet) grab them automatically
         * a few apks are still in the repo as they are self-built or modified
         * thanks to shadow53's `android-zip-builder` [> GitLab](https://gitlab.com/Shadow53/android-zip-builder)
  * `build-package` Script
     * `build-package` now prefers configuration files from `repo/data` over `repo/doc` during package creation
         * `.nanomod-setup`
         * `.nanomod-apps`
         * `.nanomod-overlay`
     * `build-package` now has new switches:
         * `build-package pull` to download all required apks for Full, microG and F-Droid package
         * `build-package u-microg` to update microG
         * `build-package u-fdroid` to update F-Droid
         * `build-package u-apps` to update (most) applications
         * `build-package u-swipe` to update swipe libraries
         * `build-package u-gsync` to update Google Sync Adapters
         * `clean` remove any untracked files from the repo (e. g. from `build-package pull`)
     * `build-package` script no longer surpresses `zip` error messages
  * Documentation:
     * updated for recent changes
     * minor changes
* Updates
  * Yalp Store (0.24)
  * Simple Gallery (2.13.4)
  * K9-Mail (5.208)
  * OpenKeychain (4.6)
  * Play Store (8.1.73.S)
  * GNU Nano (2.8.7)

## 13.1.20170829
* Bug Fixes
  * F-Droid package:
     * Fix installation issue in `nanomod_libs`
  * Full, microG packages:
     * Downgrade Google Sync Adapters for LL to 5.0
* General Changes:
  * Framework-Patcher package:
     * update `dexpatcher` to 1.3.1
     * remove unused dexpatcher.jar file
     * no longer requires booting into ROM before patching
     * more reliably catch `dexpatcher` errors
     * patching signature spoofing UI now supports
         * LineageOS/AOSP Settings.apk
         * Samsung TouchWiz SecSettings.apk
     * update to use Magisk v13 functions when Magisk is utilized
     * do all `dexpatcher` operations in `BASEDIR`, not `TMPDIR`
     * clean-up environment before doing anything
     * update to new Haystack patches
     * addon.d support (auto repatch after ROM update)
  * on-pc Framework-Patcher script:
     * exit if not in TWRP immediately, not late in process
     * add `--gui` parameter to patch Signature Spoofing toggle in UI
     * clean-up previously patched files on start (if any)
  * build-package:
     * add `dalvik` option, prepares a jar file for use with DalvikVM
  * Uninstaller:
     * also remove Framework-Patcher addon.d upon uninstallation
* Updates
  * Play Store (8.1.73.S)
  * Substratum (823)
  * Amaze (3.2.1)
  * Yalp Store (0.23)
  * Kernel Adiutor (0.9.72)
  * Simple Gallery (2.13.1)
  * Lightning (4.5.1+snapshot20170813)
  * Open Camera (1.40)

## 13.0.20170817
* Bug fixes
  * Full, microG, F-Droid, Framework-Patcher packages:
     * use `/dev/tmp` instead of `/tmp`, fixes several bugs when installing from Magisk Manager
  * Full, microG packages:
     * fix back-up and restore of `services.jar` when installing from Magisk Manager
     * fix `nanomod_substitute` not creating expected result when installing from Magisk Manager
     * fix pseudo-debloat feature not enabled when installing from Magisk Manager
     * many fixes in `nanomod-overlay` Script
     * call `nanomod-overlay --create` during installation, instead of `nanomod-overlay --update`
     * fixed that directory for nlpBackendNominatim was nlpBackendNomiantim
     * install binaries in `/system/xbin`, not `/system/bin`
  * Full, microG, Framework-Patcher packages:
     * fix `/system/.nanomod-patcher` handling when installing from Magisk Manager
  * Framework-Patcher package:
     * properly install `services.jar` into merge-pending NanoMod Magisk Modules
     * don't mount `/system` twice and don't try to unmount it, when installing through Magisk Manager
  * Full, microG, F-Droid packages:
     * fix that uninstaller information for System Mode is not correctly recorded in all cases
     * fix that permissions were not properly set on non-binary files
  * F-Droid package:
     * when looking for `.nanomod-setup` file `ZIPDIR` has higher priority than `/data`
  * Full package:
     * fixup init scripts installation
* General Changes:
  * Full, microG, F-Droid packages:
     * ignore `nanomod_forcesystem` when installing through Magisk Manager
     * deeper indent `nanomod_libs` output, makes recovery.log easier to read
     * print a warning message on pre-KitKat ROMs that compatibility is not garantueed
     * improve and simplify `nanomod_install` and `nanomod_libs` routines
     * more detailed  and better indented log messages
     * add support for KitKat (Android 4.4)
  * Full, microG packages:
     * update swipe libraries for x86_64
     * provide separate Google Sync Adapters for KK, LL, MM and N, install correct version
         * on pre-KitKat ROMs print a message that Google Sync Adapters are not supported
     * first print messages then do installation of the given component, not the over way round
         * makes it easier to understand the recovery.log
     * `nanomod-overlay` has new `-x`, `--create` parameter, to create overlays without removing them before
  * Framework-Patcher package:
     * check for `.nanomod-setup` and respect `nanomod_forcesystem` setup variable
     * add `nanomod_sigspoofui` setup variable
         * whether to add toogle to Developer Settings to globally enable or disable signature spoofing
     * include vendor libraries in adjusted `LD_LIBRARY_PATH`
  * Setup Wizard:
     * verbose output during setup file creation
  * Uninstaller package:
     * [System Mode] remove empty directories from:
         * /system/app
         * /system/priv-app
         * /system/share
  * Documentation:
     * add various additional links
     * fully document `nanomod-overlay` script
     * other minor improvements
  * build-package:
     * `swipe` parameter updates swipe libraries using shadow53's website
     * `gsync` parameter updates gsync apks using shadow53's website
* Updates
  * Orfox (1.4-RC3)
  * Simple Gallery (2.13.0)
  * Twidere (3.6.24)
  * Yalp Store (0.22)
  * Play Store (8.1.29.S)
  * Substratum (819)

## 12.1.20170807
* Bug Fixes
  * Full, microG, F-Droid packages:
     * make `nanomod_libs` installer routine actually fail, when an error occurs
         * filter out error code 11 (apk does not have libs to install)
     * when an error occurs in Magisk Mode installation perform cleanup when `error` is called
         * run Magisk's `recovery_cleanup` to ensure TWRP is in usable state (without reboot)
         * remove partially installed Magisk Module
         * unmount Magisk image
         * shrink Magisk image's size
  * microG, F-Droid packages:
     * fix that `unzip` was not bundled
* General Changes
  * Full, microG packages:
     * merge all nanomod-overlay sub-scripts into the main script
  * SetupWizard:
     * print Yet Another Message(tm) that the SetupWizard is *only* the SetupWizard
  * on-pc framework-patcher:
     * update hook patch name to reflect Haystack update
     * if Haystack repo is already downloaded, update it, instead of re-cloning it
* New
  * Orbot (15.4.2-RC1)
  * Orfox (1.4-RC2)
* Updates
  * Anysoft Keyboard (1.8.1333)
  * Substratum (815)
  * Yalp Store (0.21)
  * Odyssey (1.1.6)
  * OpenKeychain (4.5)
  * Play Store (8.1.25.S)
  * GNU Nano (2.8.6)
  * Lightning (4.5.1+snapshot20170806)

## 12.0.20170723
* Bug Fixes
  * Full package:
     * fixed that GNU Nano didn't work properly when ther terminal only had a few lines
  * microG package:
     * fixed that `column` was not bundled
  * Full, microG packages:
     * fixed that Swipe libraries where not properly installed in Magisk Mode
     * fixed that GNU Bash did not read `/etc/bashrc`
     * fixed that the fallback `/data/.nanomod-overlay` did not get removed
     * further fixes to `nanomod-overlay -g`
     * remove `nanomod_reinstall` parameter for `.nanomod-setup` configuration file (Magisk-only)
         * `services.jar` will now be auto backed up and restored during NanoMod Magisk Module update when `/system/.nanomod-patcher` exists, print a message to the user accordingly
         * `services.jar` will be removed from NanoMod Magisk Module when `/system/.nanomod-patcher` is missing (which indicates ROM update), print a message to the user accordingly
         * if `services.jar` is missing but `/system/.nanomod-patcher` exists, assume Magisk was (temporarily) uninstalled, print a message to the user accordingly
  * Full, microG, F-Droid packages:
     * workaround a rare issue where Magisk's own resize functions fail by manually using `resize2fs` in that case
* General Changes
  * Improved Documentation
  * Configuration Files:
     * `.nanomod-apps` layout simplified, now only one app per line, nothing else
         * existing configuration files will be migrated to new format
     * `.nanomod-overlay` layout simplified, now only one app per line, nothing else
         * existing configuration files will be migrated to new format
  * Full package:
     * provide more tools from  `bsdmainutils`
         * col, colcrt, colrm, hexdump, look, ncal
     * provide more tools from `util-linux`
         * findfs, findmnt, lsblk, lscpu, lsipc, lslocks, lsns, setterm, whereis
     * provide `less` pager with `lessecho` and `lesskey` utils
     * make `less` the default `PAGER` for GNU Bash
     * make default `TERM` for GNU Nano `xterm`
  * Setup Wizard:
     * AROMA based Setup Wizard to create the configuration files in either
         * `/sdcard`
         * `/external_sd`
         * `/data` (fallback)
  * renamed `mod.sh` to `build-package`
     * revised code, removed cruft
     * add multi-param support, for example `build-package fdroid microg` will create those two package in one go
  * renamed `force-debloat.sh` to `force-debloat`
     * improved code
  * renamed `magisk-mount.sh` to `magisk-mount`
     * improved code
  * renamed `framework-patcher.sh` to `framework-patcher`
     * renamed helper script `remote.sh` to `framework-patcher-remote`
     * improved code
* Downgrades
  * Google Backup Transport (7.1.1 > 6.0.1)
* Updates
  * Substratum (811)
  * Amaze (3.1.2-rc4)
  * Yalp Store (0.19)
  * Simple Gallery (2.12.2)
  * OpenVPN (0.6.73)
  * NewPipe (0.9.10)
  * Lightning (4.5.1+snapshot20170720)
  * F-Droid (0.100-alpha1)
  * Play Store (8.0.73.R)

## 11.1.201707714
* Bug Fixes
  * Full, microG, F-Droid packages:
     * provide standalone `unzip` binary (resolves installation issues with 11.0)
  * Full, microG packages:
     * fix `nanomod-overlay -s` not working
* General Changes
  * Full, microG, F-Droid packages:
     * Magisk Mode installer is now closer to magisk-module-template v4 ()
  * Full, microG packages:
     * provide `column` binary
     * let `nanomod-overlay -s` use `column` to prettify the output
     * let the user know `nanomod-overlay -s` actually does something as it can be slow on old devices

## 11.0.20170713
* Bug Fixes
  * uninstaller:
     * fixed restoring unpatched `services.jar`
  * on-device framework-patcher:
     * fixed that it accidently backed up the patched `services.jar` instead of vanilla
  * external_sd init script:
     * higher compatibility, should now work for most (if not all) devices
* General Changes
  * Full, microG, F-Droid package
     * if using fallback configuration during installation print the information accordingly
     * change syntax for `.nanomod-apps` file
         * existing configuration files will be migrated to new format
     * change syntax for `.nanomod-setup` file
         * existing configuration files will be migrated to new format
     * simplify handling fallback configuration
     * update module template to something v4-ish, modified to match NanoMod requirements/features
  * Full, microG package
     * if using fall back `nanomod-overlay` configuration remove it after installation
         * the `nanomod-overlay` script will create it during runtime, if required
     * remove all launchers from list of pseudo-debloated apps by default
     * several fixes to `nanomod-overlay` script
     * add optional `Swipe` libraries, controlled by `nanomod_swipe=[0|1]`
     * make `/data` the very last directory to look for configuration files
     * when patched `services.jar` exists before installing/updating, remove `/system/.nanomod-patcher`
* Updates
  * Play Store (8.0.26.R)
  * Simple Gallery (2.12.1)
  * Simple Calendar (2.5.7)
  * Open Camera (1.39)
  * New Pipe (0.9.9)
  * GNU Nano (2.8.5)
  * OpenLauncher (0.5.3)
  * Kernel Adiutor (0.9.71.1)
  * F-Droid (1.0-alpha0)
  * Amaze (3.1.2-beta12)

## 10.0.20170701
* Bug Fixes
  * Full, microG package
     * fixup `nanomod-overlay.genconfig` syntax error
     * fixup `nanomod-overlay.permission` not properly working
     * install GoogleBackupTransport into `/system/priv-app`, not `/system/app`
  * on-device framework-patcher
     * stop process if `/system/.nanomod-patcher` file exists
     * fixup missing function in on-device framework-patcher
     * fixup architecture detection in on-device framework-patcher
  * on-pc framework-patcher
     * stop process if `/system/.nanomod-patcher` file exists
  * force-debloat.sh remove Launchers from list of apps to remove
     * PixelLauncher
     * NexusLauncher
     * Trebuchet
  * zipalign microG Gms Core
* General Changes
  * Full, microG, F-Droid package
     * migrate to shiny new installation mechanism
     * improved printed information
     * add support to enforce installation in System Mode using `nanomod.forcesystem` setup variable
  * on-device framework-patcher
     * code improvements
     * better error messages when dalvikvm fails
     * when installing patched `services.jar` to ROM back it up to `/sdcard`
     * print somewhat more useful information
  * on-pc framework-patcher
     * when installing patched `services.jar` to ROM back it up to `/sdcard`
  * uninstaller
     * code improvements
     * remove `/system/.nanomod-patcher` regardless wether Magisk is installed
     * support uninstalling NanoMod when installed in system mode
* Updates
  * Simple Calendar (2.5.6)
  * Simple Gallery (2.11.4)
  * XDA Labs (1.1.2.3)
  * MPV (2017-06-25)
  * Substratum (803)
  * Termux (0.53)
  * Anysoft Keyboard (1.8.844)
  * OpenLauncher (0.5.2)
  * Lightning (4.5.1)
  * Yalp Store (0.18)

## 9.3.20170623
* Bug Fixes
  * Full, F-Droid, microG packages: fix installation in System Mode
  * microG package: bundle `aapt` (required for `nanomod-overlay`)
* Installer Changes
  * Full package: remove app libraries not required for device architecture
     * example: on ARM the libraries for ARM64, x86 and x86_64 are removed
  * add `nanomod.gsync=[0|1]` setup variable
     * defines whether to install Google Sync Adapters
* General Changes
  * x86/x86_64 support (work-in-progress)
     * currently working in System Mode, but not as Magisk Module
  * add `Jelly` to the list of pseudo-debloated apps by default
  * `nanomod-overlay -p` now checks for proper permissions of system apps
     * FAKE_PACKAGE_SIGNATURE for microG Gms Core and Play Store
     * READ_CALENDAR and WRITE_CALENDAR For Google Calendar Sync
     * READ_CONTACT, WRITE_CONTACTS and GET_ACCOUNTS for Google Contacts Sync
  * add `permissions` init script that runs `nanomod-overlay -p`
     * Full package only
     * for microG package manully run `nanomod-overlay -p` as before
  * added force-debloat script (for system mode!)
     * script that can be run from recovery to debloat the system
     * the list of applications resides in the script itself
     * the default settings equal to the pseudo-debloat settings of `nanomod-overlay` script
     * needs to be run from TWRP, requires explicit user acceptance
  * re-signed microG GmsCore and Phonesky with my own key instead of debug key
  * microG package: don't install terminfo files as GNU Nano is not included
  * on-pc framework-patcher: only do actual work if in TWRP
* Removed Applications
  * Magisk Manager (now bundled with Magisk itself
* Replaced Applications
  * VLC replaced with MPV
* Added Applications
  * OpenWeatherMap Provider (1.0)
  * add optional Google Calendar Sync and Google Contacts Sync
     * not installed by default
     * bundled with Full and microG package
* Updated Applications
  * GNU Nano (2.8.2)
  * microG Gms Core (0.2.4-103)
  * Substratum (782)
  * Yalp Store (0.17)
  * Simple Calendar (2.5.3)
  * Simple Gallery (2.10.10)
  * Termux (0.52)
  * Twidere (3.6.21)
  * Play Store (7.9.80.Q)
  * New Pipe (0.9.8)
  * Kernel Adiutor (0.9.70.3)
  * Yahoo Weather Provider (1.0)
  * Lightning (4.5.0~snapshot)
  * F-Droid (0.104)

## 9.2.20170610
* Internal Changes
  * no longer require `Busybox` for `sqlite` init script
  * install init scripts in `MODDIR/init.d` when in Magisk Mode
     * prevents double execution of init scripts if the ROM already has init.d support
     * when in system mode init scripts will be installed to `/system/etc/init.d` as before
  * ensure `external_sd` init script is always given executable bit
  * All installers: force `magisk.img` resize operations, perform `fsck` afterwards
  * Full and microG installers: fix a `sed` substitution
  * On-device framework-patcher: fix `magisk.img` resize operations
  * make `nanomod-overlay`'s `-p`, `--permission` parameter work when
     * installed in system mode
     * no `.nanomod-overlay` configuration file was found
  * add `-g`, respectively `--genconfig` parameter to `nanomod-overlay` script
     * creates `.nanomod-overlay` configuration file in `/data`
     * `genconfig` will be automatically run when `nanomod-overlay` is run and NanoMod is installed in Magisk Mode, but no `.nanomod-overlay` configuration file exists
  * rewrite most parts of the `nanomod-overlay` script
  * modularize the `nanomod-overlay` script
  * rewrite most parts of the documentation

## 9.1.20170607
* Internal Changes
 * move init script execution from `post-fs-data` to `late-start`
 * run init scripts in parallel instead one by one
 * fixup init scripts possibly not finding `Busybox` when installed as Magisk Module
 * as a side-effect Magisk Log is now properly recorded and no longer imcomplete
 * save init scripts logs in `/magisk/NanoMod/.logs/${script}.log.${curdate}`
   * `curdate` is the time `services.sh` is run by Magisk in `YYYYMMDD-HH.MM.SS` format
 * add `external_sd` init script which will symlink your external SD Card's mount directory to `/external_sd`
   * known path from TWRP, makes it easier to `adb push` files to the SD Card
   * SD Card needs to be inserted upon boot, else `/external_sd` won't be created
   * it might take up to 30 seconds after boot up until `/external_sd` becomes available
 * make `logscleaner` init script less aggressive
 * let `sqlite` init script first check whether `sqlite3` is available
 * make `nanomod-overlay` script use `grep` and `sed` instead of `awk`
   * makes `nanomod-overlay` script work in case `Busybox` is not installed
 * add `nanomod.init` setup variable to make it possible to not install the init scripts
 * fixed that `nanomod-overlay` had `--permission` parameter documented, but was expecting `--permissions`
 * the full and microG package installers now set the path for `GNU Bash` in `nanomod-overlay` script
   * fixes the issue that `nanomd-overlay` script does not work when installed in system mode
* Updates
  * F-Droid (0.103.2)
  * VLC (2.1.10~beta)
  * Simple Gallery (2.10.8)
  * Play Store (7.9.30.Q)
  * XDA Labs (1.1.2.2b)
  * Twidere (3.6.16)
  * Open Camera (1.38.2)

## 9.0.20170528
* Internal Changes
  * shiny new installer
     * cleaner and easier maintainable code
     * several improvements to `/system` mode installation
     * for microG, F-Droid and full packages
  * fix **GNU Bash** installation in microG package
  * drop Launchers from list of pseudo-debloated applications in microG package
  * disable pseudo-debloat feature in the microG package by default
  * NanoMod installers for full and microG package support configuration files located in the same directory as the zip, make the `nanomod-overlay` script remember that path
     * also fixes bug that `nanomod-overlay` does not work outside of the installer
  * better error message in `nanomod-overlay` script if configuration file does not exist
  * install Maps API version 1 by default
  * add an **uninstaller** zip which will uninstall any NanoMod Magisk Module
     * checks for all three (full, F-Droid and microG) packages and removes them if found
     * does not work for system mode installation (and there won't be an uninstaller for that)
* Updates
  * Simple Calendar (2.5.1)
  * Simple Gallery (2.10.6)
  * NewPipe (0.9.7)
  * Nominatim Nlp Backend (1.2.2)
  * Termux (0.50)
  * PlayStore (7.8.74.P)
  * VLC (2.1.8~beta)
  * Yalp Store (0.15)
  * Twidere (3.6.15)
  * OpenLauncher (0.5.1)
  * Open Camera (1.38.1)

## 8.0.20170521
* Internal Changes
  * if `Magisk` is not installed, the installer will install everything into `/system` directly
  * provide broken-out libraries for all provided applications
     * fixes issues with them, for example `Magisk Manager` not being able to install zips
  * fix `nanomod-overlay` script to support all `.nanomod-overlay` configuration file locations
  * fix `nanomod-overlay` script not properly working with **NanoMod-microG** module
  * the on-device and on-pc framework patchers now create the file `/system/.nanomod-patcher` after successful patching
     * can be used to check whether the patcher was already run or not
  * **NanoMod-microG** now also includes `GNU Bash`
  * fix `VLC` directory not matching apk file name
     * fix `VLC` getting installed, even if user requested not to do so
  * update default `.nanomod-overlay` to pseudo-debloat the following apps
     * Pixel Launcher
     * Via Browser
     * Phonograph (Music Player)
     * Sound Recorder (additional overlay path)
* Updates
  * Substratum (760)
  * OpenLauncher (0.5.0)
  * NewPipe (0.9.6)
  * Twidere (3.6.14)
  * Kernel Adiutor (0.9.7.2)
  * F-Droid Privileged Extension (0.2.5)
  * Yalp Store (0.14)
     * This release allows installation of applications without having to enable `Unknown Sources`
         * go to Yalp Store > Settings > Installation Method > `Using system permissions`
  * (Simple) Calendar (2.3.4)
  * Open Camera (1.38)
  * OpenVPN (0.6.66)
  * (Simple) Gallery (2.9.1)
  * Termux (0.49)
  * microG DroidGuard Helper (0.1.0-10)
  * VLC (2.1.7~beta)
  * Odyssey (1.1.5)

## 7.2.20170508
* Internal Changes
  * full package: replace `spaces` with `underscores` in Zelda ringtone names
  * full package: minor fix in installer
  * framework-patcher package: grow and shrink `magisk.img` if required
     * fixes issue where patched `services.jar` could not be installed, because not enough space was left in `magisk.img`
  * framework-patcher package: show error message to user if `/system` fails to re-mount read-write
  * framework-patcher package: unmount `/system` and `/data` after work is done
  * framework-patcher package: less verbose output from `dexpatcher` and `zip`
  * framework-patcher package: note the user to post `/tmp/recovery.log` if something fails
  * framework-patcher package: use static `zip` binary, fixes possbile `zip` failure older ROMs
  * framework-patcher package: change the way `LD_LIBRARY_PATH` is determined
  * framework-patcher package: check if ROM is `odexed` and exit if so
  * framework-patcher package: code clean-up
  * framework-patcher script: grow and shrink `magisk.img` if required
     * fixes issue where patched `services.jar` could not be installed, because not enough space was left in `magisk.img`
  * framework-patcher script: fix installation path for patched `services.jar` when NanoMod is not installed
* Updates:
  * GNU Bash (4.4[012])
  * Substratum (721)
  * OpenKeyChain (4.4.1)
  * OpenLauncher (0.3.2.1)
  * Twidere (3.5.36)
  * F-Droid (0.103)
  * Play Store (7.7.40.N)
  * Kernel Adiutor (0.9.7.1beta)

## 7.1.20170501
* Internal Changes
  * full and microG package: the `.nanomod-overlay` , `.nanomod-apps` and `.nanomod-setup` configuration files can now be stored in the following directories
     * `/data` (default)
     * `/sdcard` (internal storage)
     * `/persist`
     * `/external_sd` (special path in TWRP for external SD-Card if not used as adoptable storage)
     * directory containing the zip file
  * full package: init scripts no longer remount rootfs (not required)
  * full package: installer now makes init scripts actually executable
  * framework-patcher package: fix detection of device architecture
* Updates
  * Twidere (3.5.33)
  * (Simple) Calendar (2.3.4)
  * OpenKeyChain (4.3)
  * Substratum (706)
  * (Simple) Gallery (2.9.0)
  * NewPipe (0.9.4)
  * Amaze (3.1.2~RC3)
  * microG GmsCore (0.2.4-92)
  * Magisk Manager (4.3.3)

## 7.0.20140725
* Internal Changes
  * some ROMs don't have a `zip` binary which is required for the on-device `framework-patcher` to work
     * it now provides arm and arm64 `zip` binaries as fallback
  * all packages: let the installers fails if device has x86/x86_64 architecture (NanoMod only supports arm/arm64)
  * full and microG-only packages: if the installers create default configuration files because no user-defined exist, those files get removed after installation
     * this is to ensure the users who don't care about them always get the default configuration
     * obvioulsy, if you opt-in to create your own setup, it won't be affected by this
  * full and microG-only package: if the setup file is incomplete, add the missing properties with default values
  * microG-only package: set default value of `nanomod.overlay` to `0`
  * microG-only package: create the application overrides if `nanomod.overlay` is `1`
* Fixes
  * fix regression from 6.1 which prevented (in-)app-purchases
  * fix the microG only package by default installs no app store
     * now defaults to Play Store
* Updates
  * GNU Nano (2.8.1)
  * GNU Bash (4.4)
  * F-Droid (0.103-alpha3)
  * F-Droid Privileged Extension (0.2.4)
  * NewPipe (0.9.3)
  * Twidere (3.5.25)
  * Substratum (703)
  * VLC (2.1.6~beta)
* New
  * Application
     * (Simple) Calendar (2.3.3)
  * Override
     * Calendar

## 6.1.20170421
* Internal Changes
  * minor fix in `mod.sh`
  * minor improvements to README
  * minor improvements in `mount-magisk.sh`
  * make on-pc `framework-patcher` auto-detect install path for modified `services.jar`
     * like on-device framework-patcher it supports installing `services.jar` to
         * NanoMod (full)
         * NanoMod (microG)
         * ROM (directly to /system)
  * add support for `nanomod-apps` configuration file to let the user control what apps to provide when `nanomod.apps=1` is set (default)
     * refer to the README for more details
  * fix provided `microG GmsCore` not being installable as user-app
* Updates
  * (Simple) Gallery (2.8.6)
  * OpenLauncher (0.3.1)
  * Play Store (7.7.31.O)
  * VLC (2.1.5~beta)
  * Substratum (672)
  * XDA Labs (1.1.1.1)

## 6.0.20170418
* Internal Changes
  * there's now an F-Droid only variant
  * there's now an on-device framework-patcher
     * Note: it is suggested to boot into the ROM once, else the dalvik-cache might not exist (or is not up-to-date in case of incremental ROM update) and the patching process takes ages or fails
  * ensure all binaries installed by NanoMod (full package) are executable
  * minor fix in `nanomod-overlay` script
  * added `fdroid` parameter to `mod.sh`, to create the F-Droid only package from git
  * added `patcher` parameter to `mod.sh`, to create the on-device framework-patcher package from git
  * revised `mod.sh` (cleaner code)
  * revised `mod.sh` (should now be fully functional on Mac OSX)
  * added `nanomod.mapsv1` setup variable to `nanomod-setup` configuration file
  * the location of the `.nanomod-setup` file was changed from `/data/media/0/.nanomod-setup` to `/data/.nanomod-setup`
     * if the old file is found, the installer will move it to the new location
     * this is in order to ensure the file is usable when users have adoptable storage in use
  * the location of the `.nanomod-overlay` file was changed from `/data/media/0/.nanomod-overlay` to `/data/.nanomod-overlay`
     * if the old file is found, the installer will move it to the new location
     * this is in order to ensure the file is usable when users have adoptable storage in use
  * also install the `nanomod-overlay` script in the microG only package
     * so that `nanomod-overlay -p` is available
  * revised README in many places
  * README now features many graphical links for most things featured in full package, pointing to F-Droid pages, github repos, or the-like, to make it much easier to get additional information
* Updates
  * F-Droid (0.103.alpha2)
  * AnySoftKeyboard (1.8.735)
  * NewPipe (0.9.2)
  * Play Store (7.7.17.O)
  * Amaze (3.1.2~beta10)
  * Substratum (671)
  * Twidere (3.5.18)
  * K9-Mail (5.207)
  * (Simple) Gallery (2.8.4)

## 5.2.20170413
* Internal Changes
  * no longer copy DroidGuard.apk to /sdcard
  * add `nanomod.fdroid` setup variable defines whether to install F-Droid or not
  * add `-p`, respectively `--permission` parameter to `nanomod-overlay`, which will grant fakesign permission to microG GmsCore and Play Store, aswell as ignore battery optimization permission to microG GmsCore
  * `framework-patcher.sh` revised to support Mac OSX thanks to @victor141516
* Updates:
  * F-Droid Privileged Extension (0.2.3)
  * Yalp Store (0.13)
  * Substratum (632)

## 5.1.20170408
* Internal Changes
  * only copy DroidGuard.apk to /sdcard if `nanomod.microg` is `1` in `nanomod-setup` configuration file
  * add new option `nanomod.zelda` to `nanomod-setup` configuration file, allows to control whether to install or not install Zelda ringtones and sounds
  * `nanomod.play=0` now actually works and does not install any app store
* Variants
  * full package: microG, F-Droid & apps, pseudo-debloat feature, Zelda ringtones & sounds, GNU Bash, GNU Nano, aapt utility
  * microG package: microG only
  * `framework-patcher.sh` updated to support both modules
* Removed files / features
  * Effect_Tick Zelda sound
     * I admit, that one was too annoying
  * Magisk installation
  * unsu Script
     * Read: NanoMod is now only the Module, no longer includes Magisk itself
* nanomod-overlay Script Changes
  * parameter `-l`, respectively `--list` now has properly formatted output
  * parameter `-r`, respectively `--remove` now only removed exact matches from config file
  * parameter `-a`, respectively `--add` now properly formats config file
  * new parameter `-s`, respectively `--show` which shows all non pseudo-debloated system applications
  * new paramter `-d`, respectively `--delete` which will remove all overrides and thus re-enable all applications, unlike `-r` / `--remove` this will not change the config file, so you can re-debloat using `-u` / `--update` again
* Updates
  * Play Store (7.7.09.O)
  * VLC (2.1.4~beta)
  * GNU Nano (2.7.5)
  * Substratum (631)
* Added applications
  * F-Droid Privileged Extension (0.2.2)
     * allows installation of apps using F-Droid without enabling 'Unknown Sources' in the security settings of your device

## 5.0.20170405
* Internal Changes
  * NanoMod is now (mostly) an Magisk Module
     * referrenced to as "Overlay"
  * Nano-Init merged into NanoMod Overlay
  * AROMA installer removed
     * the list of applications to override is now in the file `.nanomod-overlay` in the internal data storage. See the README for more information.
     * you can alter the setup process to some degree by editing the file `.nanomod-setup` in the internal data storage. See the file README for more information.
  * Updated `framework-patcher.sh` to install files modified by haystack directly into the NanoMod Overlay
     * `framework-patcher.sh` needs to be re-run everytime you install NanoMod
     * it's suggested to re-run `framework-patcher.sh` on every ROM update, too, so that you get to patch your ROMs current framework files
  * microG GmsCore and Play Store are modified to allow in-app purchases
* Updates
  * Kernel Adiutor (0.9.6.11)
  * microG GmsCore (0.24-81)
  * Substratum (627)
  * Twidere (3.4.48)
  * Magisk Manager (4.3.1)
  * VLC (2.1.3~beta)
  * Amaze (3.1.2~rc1)
  * Play Store (7.7.08.O)
  * NewPipe (0.9.0)
  * F-Droid (0.103-alpha1)
* Replaced Applications
  * LeafPic => (Simple) Gallery [2.8.0]
     * (Simple) Gallery allows changing the wallpaper (unlike LeafPic)
* Removed Magisk Modules
  * Nano-Miitomo (ro.debuggable is now disabled by Magisk by default)
  * Nano-Init (merged in the Overlay)
* New Applications
  * OpenLauncher [alpha3]

## 4.1.20170321
* Updates
  * AnySoft Keyboard (1.8.585)
  * VLC (2.1.2~beta)
  * Magisk (11.6)
  * MagiskManager (4.2.7)
  * microG GmsCore (0.24-79)
  * F-Droid (0.102.2)
  * K9-Mail (5.206)
  * Odyssey (1.1.4)
  * Substratum (604)
  * PlayStore (7.6.08.N)
  * Termux (0.48)
  * Kernel Adiutor (0.9.6.7)
  * NewPipe (0.8.12)
  * Nano-init (4)
     * let's several more Samsung devices pass SafetyNet (though, not all)
  * Twidere (3.4.39)
* Added applications
  * OpenKeyChain (4.2.4)
  * YalpStore (0.11)
  * FakeStore (0.0.2)
* Other Changes
  * unsu.sh: only re-flash boot image backup if it is a SuperSU backup
  * installer: let the user choose whether to install microG with official PlayStore or with unofficial YalpStore
  * When YalpStore is installed, also install FakeStore, so that apps that expect PlayStore still work. This also ensures SafetyNet responses work as they should.
  * installer: when installing PlayStore, remove FakeStore and YalpStore, or remove PlayStore, before installing YalpStore, makes it much more easy to try out both variants without having to manually remove system apps or re-flashing ROM

## 4.0.20170223
* Updates
  * update Nominatim Nlp Backend (1.2.1)
  * update microG (0.2.4-76)
  * update Twidere (3.4.29)
  * update Face Slim (3.1.0)
  * update NewPipe (0.8.10)
  * update Open Camera (1.37)
  * update Lightning (4.4.2)
  * update Magisk (12~beta.20170218)
  * update MagiskManager (4.2.6)
* Added applications
  * AnySoftKeyboard (1.8.503)
  * KeePassDroid (2.0.6.4)
  * OpenVPN (0.6.64)
* Other Changes
  * non-debug build for microG GsfProxy
  * Remove Nano-Selinux-Senforce Magisk Module
  * some ROMs have AdAway pre-installed, remove that version if NanoMod provided version is choosen to be installed
  * include customized version of osm0sis' unSU script to fully remove any existing root
     * re-flashes boot image backup in case system less SuperUser was installed
     * only unSU if Magisk is to be installed
  * drop option to remove Nexus Launcher

## 3.1.20170207
* Updates
  * update NewPipe (0.8.9)
  * update Twidere (3.4.26)
  * update PlayStore (7.5.08.M)
  * update Magisk (11.1)
  * update Magisk Manager (4.1)
* Fixes
  * fix permissions for GNU Bash installation
  * fix permissions for GNU Nano installation
* Other Changes
  * Remove SuperUser application (now handled by Magisk Manager)
  * Don't install Nano-Selinux-Enforce Magisk Module by default (Magisk 11 features an pseudo-enforcing Selinux Mode)
* Notes:
  * If updating from 3.0 remove the SuperUser app from /system/app/SuperUser before the first boot after flashing 3.1, as Magisk Manager does the SuperUser handling now

## 3.0.20170204
* initial AROMA release
