# ChangeLog

## 6.1 in-dev
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
