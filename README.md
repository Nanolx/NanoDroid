# NanoMod

## Current Stable Release

5.2.20170413

* Stable Downloads [![Androidfilehost Link](images/afh.png)](https://www.androidfilehost.com/?a=show&w=files&flid=150729)
* Archived Downloads [![Androidfilehost Link](images/afh.png)](https://www.androidfilehost.com/?w=files&flid=156387)

# Description

* install **NanoMod** or **NanoMod-microG** Magisk-Module
  * actually **NanoMod** is an **Overlay** to `/system` which holds the apps
  * allows for a user-defined list of system apps to be made unavailable (let's call this pseudo-debloat feature)
  * disabling the **NanoMod** module in **Magisk** will revert everything, as it's not actually doing any changes to `/system`
  * boot process may take a bit longer as **NanoMod** is a pretty big **Magisk** Module
  * for more information on **Magisk** [![XDA Link](images/xda.png)](https://forum.xda-developers.com/apps/magisk)
* install **microG** [![Web Link](images/microg.png)](http://microg.org/)
  * with **Mozilla** location provider backend [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=mozilla&fdid=org.microg.nlp.backend.ichnaea)
  * with **Nominatim** adress provider backend [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=nominatim&fdid=org.microg.nlp.backend.nominatim)
  * with **microG** GsfProxy [![GitHub Link](images/github.png)](https://github.com/microg/android_packages_apps_GsfProxy)
  * with **microG** DroidGuard Helper [![GitHub Link](images/github.png)](https://github.com/microg/android_packages_apps_RemoteDroidGuard)
  * choose between official **Play Store** [![APK Mirror Link](images/apkmirror.png)](https://www.apkmirror.com/apk/google-inc/google-play-store/) or unofficial **Yalp Store** [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=yalp&fdid=com.github.yeriomin.yalpstore)
  * **microG** GmsCore [![GitHub Link](images/github.png)](https://github.com/microg/android_packages_apps_GmsCore) and **Play Store** modified to allow (in-)app-purchases
  * support for Maps API version 1 optionally available (see **Alter Installation** below)
  * both on-pc and on-device framework-patchers available (see **Variants** and **Installation** below)
* install **F-Droid** and many OpenSource applications
  * including the privileged extension, so you don't need to enable 'Unkown Sources' to use F-Droid
  * for more information on F-Droid visit [![F-Droid Link](images/fdroid.png)](http://www.fdroid.org)
* install GNU **Bash** Shell [![GNU Link](images/gnu.png)](https://www.gnu.org/software/bash/)
* install GNU **Nano** Shell Editor [![GNU Link](images/gnu.png)](https://www.nano-editor.org/)
* install **The Legend of Zelda** rintones and sounds [![Nintendo Link](images/zelda.png)](http://www.zelda.com/)
  * it's dangerous to root alone

# Why was this created?

Because I wanted to have a simple way to achieve my desired setup on any device or any ROM. That's it, basically. And since it already exists, I thought I'd push it to XDA aswell. Actually this is the generic version of my NanoROM for Galaxy S6, where I basically made the same changes to the ROM (except NanoMod is for LOS/AOSP based ROMs, not TouchWiz).

# Support

XDA Support Thread [![XDA Link](images/xda.png)](https://forum.xda-developers.com/apps/magisk/module-nanomod-5-0-20170405-microg-t3584928)

# Details

## ChangeLog

ChangeLog.md [![GitHub Link](images/github.png)](ChangeLog.md)

## License

Each provided application under it's original license. My own work (NanoMod itself) is licensed under the GNU General Public License version 3 or newer [![GNU Link](images/gnu.png)](https://www.gnu.org/licenses/gpl-3.0.txt)

## Variants

* Full package contains **everything** mentioned above
* microG package **only** contains microG, it's companions and `nanomod-overlay` script
  * don't flash this, if you already have the Full package
* F-Droid package **only** contains F-Droid and it's Privileged Extension
  * don't flash this, if you already have the Full package
* patcher package use **in addition** to Full or microG package to patch the framework to support fake signature spoofing (required for microG to work)

## Installation

* Download release build [![Androidfilehost Link](images/afh.png)](https://www.androidfilehost.com/?a=show&w=files&flid=150729)
* or create zip file from this repository
  * on GNU/Linux or BSD you can use the provided mod.sh script, either
    * `mod.sh zip` for the full package
    * `mod.sh microg` for the microg only package
    * `mod.sh fdroid` for the F-Droid only package
    * `mod.sh patcher` for the on-device framework-patcher package
* perform full wipe
  * recommended, but not required
* install desired ROM
  * make sure it does **not** include GApps
* install desired Kernel (if any)
* install **Magisk**
* install **NanoMod**
  * for **microG** to work, your ROM needs to have fake signature spoofing enabled
  * to achieve that either
    * flash the on-device framework-patcher zip after flashing NanoMod (or a ROM update) this will directly patch the framework for fake signature spoofing support from TWRP
      * Note: after **full wipe** this does not work on all devices directly, so it's highly recommended to boot the ROM normaly once and go back to TWRP for patching
        * This is not required when dirty flashing / updating the ROM
    * use the supplied `framework-patcher.sh` from your PC / laptop. This shell script for GNU Bash (and compatible shells) works on Unixoid operating systems like GNU/Linux, BSD or Mac OSX. It automizes the process of downloading Haystack [![GitHub Link](images/github.png)](https://github.com/Lanchon/haystack), pulling files from phone, patching and populating them in the **NanoMod** Magisk Module.
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

`/data/.nanomod-setup`

on your phone, populate it with the following content for the **full package**

```
nanomod.microg=1
nanomod.fdroid=1
nanomod.apps=1
nanomod.play=1
nanomod.reinstall=0
nanomod.overlay=1
nanomod.zelda=1
nanomod.mapsv1=0
```

the **microg only package** only supports the following options

```
nanomod.play=1
nanomod.reinstall=0
nanomod.mapsv1=0
```

where `1` means `on` and `0` means `off`. Description:

`nanomod.fdroid=[0|1]`

whether to populate **F-Droid**.

`nanomod.apps=[0|1]`

whether to populate FOSS apps (see below).

`nanomod.microg=[0|1]`

whether to populate **microG**.

`nanomod.mapsv1=[0|1]`

whether to provide **microG** Maps API v1.

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

If no `/data/.nanomod-setup` is found, the default one will be installed (equals to the example above).

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

`/data/.nanomod-overlay`

on your device. See the default settings [![GitHub Link](images/github.png)](.nanomod-overlay). The syntax is pretty simple:

* one item per line
* name must be an exact match
* applications in `/system/app` inside `APPS=( ... )`
* applications in `/system/priv-app` inside `PRIV_APPS=( ... )`

After you've made your changes, issue the following command on your phone, either using `adb shell` or **Termux** as root:

`nanomod-overlay --update`

This needs to be done in normal environment. If you're in **TWRP** you'll have to manually mount `/magisk`. For this you can use the supplied `mount-magisk.sh` script, connect phone to PC while in **TWRP** and run the following commands

```
adb push mount-magisk.sh /tmp/
adb shell
chmod 0755 /tmp/mount-magisk.sh
/tmp/mount-magisk.sh
```

afterwards you can call `nanomod-overlay` like

`/magisk/NanoMod/system/bin/nanomod-overlay --update`

from **TWRP**, aswell. Issue

`/tmp/mount-magisk.sh`

again to unmount `/magisk`. Reboot for your changes to get applied. For more options, check:

`nanomod-overlay --help`

respectively

`/magisk/NanoMod/system/bin/nanomod-overlay --help`

from **TWRP**.

### Applications provided by NanoMod

The following applications are magic-mounted as `/system` applications

* AdAway [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=adaway&fdid=org.adaway)
* Amaze (File Manager) [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=amaze&fdid=com.amaze.filemanager)
* AnySoftKeyboard [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=anysoftkeyboard&fdid=com.menny.android.anysoftkeyboard)
* Face Slim (Facebook client) [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=face+slim&fdid=org.indywidualni.fblite)
* F-Droid (FOSS app store) [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=f-droid&fdid=org.fdroid.fdroid)
  * F-Droid Privileged Extension [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=f-droid&fdid=org.fdroid.fdroid.privileged)
* Hacker's Keyboard [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=hacker&fdid=org.pocketworkstation.pckeyboard)
* K-9 Mail [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=k9&fdid=com.fsck.k9)
* Kernel Adiutor [![GitHub Link](images/github.png)](https://github.com/Grarak/KernelAdiutor)
* KeyPassDroid (Password Safe) [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=keepass&fdid=com.android.keepass)
* (Simple) Gallery [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=gallery&fdid=com.simplemobiletools.gallery)
* Lightning (Browser) [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=lightning&fdid=acr.browser.lightning)
* Magisk Manager [![GitHub Link](images/github.png)](https://github.com/topjohnwu/MagiskManager)
* New Pipe (YouTube client) [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=newpipe&fdid=org.schabi.newpipe)
* Oandbackup (App backup and restore) [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=Oandbackup&fdid=dk.jens.backup)
* Odyssey (Audio player) [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=odyssey&fdid=org.gateshipone.odyssey)
* OpenCamera [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=open+camera&fdid=net.sourceforge.opencamera)
* OpenKeyChain [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=Oandbackup&fdid=org.sufficientlysecure.keychain)
* OpenLauncher [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=openlauncher&fdid=com.benny.openlauncher)
* OpenVPN [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=openvpn&fdid=de.blinkt.openvpn)
* QKSMS [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=qk&fdid=com.moez.QKSMS)
* Substratum (App and Compiler) [![GitHub Link](images/github.png)](https://github.com/substratum/substratum)
  * will run in legacy mode on non-OMS ROMs
* Termux [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=termux&fdid=com.termux)
* Twidere (Twitter client) [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=twidere&fdid=org.mariotaku.twidere)
* VLC (Audio/Video Player) [![GitLab Link](images/gitlab.png)](https://code.videolan.org/videolan/vlc-android)
* XDA Labs [![XDA Link](images/xda.png)](https://forum.xda-developers.com/android/apps-games/labs-t3241866)
  * source not (yet) available
* Yahoo Weather Provider [![GitHub Link](images/github.png)](https://github.com/CyanogenMod/android_packages_apps_YahooWeatherProvider)

### Issues

List of known issues

* microG DroidGuard Helper or Play Store crashing
  * there's currently an issue with **Magisk** that prevents microG DroidGuard Helper or Play Store from properly working when magic-mounted as `/system` application, see Magisk Issue 155 [![GitHub Link](images/github.png)](https://github.com/topjohnwu/Magisk/issues/155)
  * this does not happen on all devices
  * if you are affected of this issue, instead install them as an user app, by installing the apk from
    * `/system/priv-app/DroidGuard/DroidGuard.apk` for microG DroidGuard Helper
    * `/system/priv-app/Phonesky/Phonesky.apk` for Play Store
* Play Store lacks fake sign permission
  * on ROMs like **crDroid** or **OmniROM**, that have built-in fake signing and don't require running `framework-patcher.sh`, in some cases the Play Store is not granted fake sign permission, to fix this issue one of the following commands as root on your phone
    * `nanomod-overlay --permission`
    * `pm grant com.android.vending android.permission.FAKE_PACKAGE_SIGNATURE`

## Magisk & root

**Magisk** allows modifying the ROM in system less fashion, it also brings it's own root solution (**MagiskSU**, which apparently is a fork of **PHH SuperUser**) and an companion application.

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
