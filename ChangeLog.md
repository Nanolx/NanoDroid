# ChangeLog

## 14.8 in-dev
* General Changes
  * Full package
     * use official build for Kernel Adiutor
     * use official GitHub pre/build for OpenLauncher
  * Framework-Patcher package, addon.d
     * update `dexpatcher` to 1.6.0
* Updates
  * KeePassDroid (2.2.0.6)
  * OpenLauncher (0.5.8)
  * Kernel Adiutor (0.9.73.1)
  * Odyssey (1.1.8)

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
