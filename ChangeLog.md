# ChangeLog

## 9.4 in-dev
* Bug Fixes
  * fixup `nanomod-overlay.genconfig` syntax error
  * on-device framework-patcher
    * modularize code
    * better error messages when dalvikvm fails
    * stop process if `/system/.nanomod-patcher` file exists
    * fixup missing function in on-device framework-patcher
    * fixup architecture detection in on-device framework-patcher
    * when installing patched `services.jar` to ROM back it up to `/sdcard/`
    * print somewhat more useful information
  * zipalign microG Gms Core
* Updates
  * Simple Gallery (2.11.1)
  * XDA Labs (1.1.2.3)
  * MPV (2017-06-25)
  * Substratum (803)

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
