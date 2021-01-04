Table of Contents
=================

   * [Installation](#installation)
      * [Installation Setup](#installation-setup)
      * [Parallel Installations](#parallel-installations)
      * [Installation on Stock ROM without GApps, custom ROM with/without OpenGApps](#installation-on-stock-rom-without-gapps-custom-rom-withwithout-opengapps)
      * [Installation on Stock ROM with GApps](#installation-on-stock-rom-with-gapps)
      * [Upgrading NanoDroid](#upgrading-nanodroid)
      * [Installation Logfiles](#installation-logfiles)

Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc)

# Installation

## Installation Setup

* Create the setup configuration, if you don't want to stick with the default setup
   * see [> Alter Installation](AlterInstallation.md) for configuration settings (all packages)
   * see [> Applications](Applications.md) for which appliations to install (only Full package)
   * see [> NanoDroid-Overlay](NanoDroidOverlay.md) for which applications to (pseudo-)debloat (only Full and microG packages)
      * note: all GApps that conflict with microG will be (pseudo-)debloated regardless of your choice here
      * see [> GApps Removal List](GAppsRemoval.md) to see which GApps are auto-destroyed
   * the above links contain information on how to create the configuration files and links to the default configuration files
      * so you can use those to edit the configuration to your liking instead of starting from scratch
          * alternatively you can grab the configuration files from your downloaded (or created) zip and edit those
   * your configuration files can be the placed in the following location on your device:
      * `/data/media/0` (internal storage)
      * `/external_sd` (TWRP path to SD Card (if any))
      * `/sdcard1` (internal storage (ORANGEFOX Recovery only!))
      * `/data` (fallback)
* Download pre-built zip or create one from this repository

## Parallel Installations

Since the microG and F-Droid packages are subsets of the Full NanoDroid package, they can't be installed alongside.

The microG and F-Droid packages however can be installed in parallel, as they complement each other.

## Installation on Stock ROM without GApps, custom ROM with/without OpenGApps

OpenGApps and GApps-less ROMs don't need further measurements, the Installer takes care of required steps.

* perform full wipe (/system, /data, /cache, Dalvik/ART cache)
  * recommended, but not required
* install desired ROM
  * make sure it does **not** include GApps if you want to use microG
     * NanoDroid tries to get rid of GApps on it's own, but it may not always work, try without any warranty
* install **Magisk**
  * recommended, but not required
  * if **Magisk** is installed, NanoDroid will be installed as Magisk-Module, else it will install into `/system` directly
* install desired Kernel (if any)
* boot into ROM (for **Magisk** module installation only)
* boot into TWRP again (for **Magisk** module installation only)
* install **NanoDroid**
  * if you want to use microG make sure the ROM is either pre-patched with signature spoofing support or **deoxeded** so you can patch yourself [see here](DeodexServices.md)
     * you can use the Patcher package to de-odex (up to Android 8.1) and/or patch services.jar (up to Android 10.0)
* reboot into ROM

## Installation on Stock ROM with GApps

Stock ROMs with GApps may not allow to switch from Google GmsCore to microG GmsCore in-place, thus the installation is slightly different.

* perform full wipe (/system, /data, /cache, Dalvik/ART cache)
  * recommended, but not required
* install desired ROM
  * make sure it does **not** include GApps if you want to use microG
     * NanoDroid tries to get rid of GApps on it's own, but it may not always work, try without any warranty
* install **Magisk**
  * recommended, but not required
  * if **Magisk** is installed, NanoDroid will be installed as Magisk-Module, else it will install into `/system` directly
* install desired Kernel (if any)
* mount `/system` read-write and remove the following folders
  * GApps GmsCore (which can have multiple paths, depending on the ROM):
     * `/system/priv-app/GmsCore`
     * `/system/priv-app/GmsCore_update`
     * `/system/priv-app/PrebuiltGmsCore`
     * `/system/priv-app/PrebuiltGmsCorePi`
     * `/system/priv-app/PrebuiltGmsCorePix`
  * `/system/priv-app/GoogleServicesFramework`
  * `/system/priv-app/Phonesky`
* boot into ROM (ignore all those complaints that Play Services are missing)
  * this is step is required!
* reboot to TWRP
* install **NanoDroid**
  * if you want to use microG make sure the ROM is either pre-patched with signature spoofing support or **deoxeded** so you can patch yourself [see here](DeodexServices.md)
     * you can use the Patcher package to de-odex (up to Android 8.1) and/or patch services.jar (up to Android 10.0)
* reboot into ROM

## Upgrading NanoDroid

When upgrading NanoDroid you may just:

* boot into TWRP
* install **Magisk**
  * recommended, but not required
  * if **Magisk** is installed, NanoDroid will be installed as Magisk-Module, else it will install into `/system` directly
* install **NanoDroid**
* reboot

## Installation Logfiles

The recovery log and installation configuration is stored after installation, regardless with it succeeded or failed.

You'll find the files in

* `/data/media/0/nanodroid_logs/MODID_log_INSTALLDATE 
* `/data/media/0/nanodroid_logs/MODID_twrp_INSTALLDATE`

where `MODID` is either

* NanoDroid
* NanoDroid_microG
* NanoDroid_FDroid
* NanoDroid_BromiteWebView
* NanoDroid_OsmAnd
* NanoDroid_Google

and `INSTALLDATE` is the date of installation in `%Y%m%D_%H.%M.%S` format (eg: `20180709_20.34.14`).

In case of installation errors, issues or questions provide these files in your report for easier debugging.
