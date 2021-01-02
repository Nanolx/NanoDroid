Table of Contents
=================

   * [NanoDroid](#nanodroid)
   * [Table of Contents](#table-of-contents)
      * [Current Release](#current-release)
      * [Downloads](#downloads)
         * [Primary Mirror](#primary-mirror)
         * [SHA256 Checksum and GPG Signature](#sha256-checksum-and-gpg-signature)
         * [Snapshots](#snapshots)
      * [Custom builds](#custom-builds)
      * [Supported Android Versions](#supported-android-versions)
      * [Recommended Thirdparty Projects](#recommended-thirdparty-projects)
      * [Support](#support)
      * [ChangeLog](#changelog)
      * [Summary](#summary)
      * [Packages](#packages)
         * [F-Droid Repository](#f-droid-repository)
      * [Details](#details)
      * [Installation](#installation)
      * [microG Setup](#microg-setup)
      * [Issues](#issues)
      * [License &amp; Credits](#license--credits)
      * [TODO](#todo)
      * [FAQ](#faq)

Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc)

# NanoDroid

NanoDroid is a installer for various OpenSource related things, most noticably microG and F-Droid. It supports direct /system installation, both devices with or without A/B partition scheme or system-as-root, aswell as Magisk Mode (module) installation. It also includes several tools (eg. GNU Bash, tools from util-linux/bsdmainutils and more) and additional features (system debloating, init scripts, automatic logcat creation), aswell as a companion F-Droid Repository.

Furthermore it allows the user to do fine-graded installations using configuration files, which allow to choose what to install, or if several alternatives are available, which of them, see [Installation](#installation) below.

In order for full microG experience NanoDroid contains a modified Play Store which allows (in-)app-purchases with microG, which would normally not be possible. It also tries to remove all previously installed GApps on it's own. For ROMs without builtin signature spoofing support NanoDroid includes an on-device Patcher which tries to patch your ROM from either TWRP or Magisk Manager.

Versions until 15.1 were called **NanoMod**, starting with 16.0 they're called **NanoDroid**.

## Current Release

* Stable: 23.0.1.20201029 "[FCK 2020](https://www.discogs.com/de/Scooter-FCK-2020/release/16102123)"
* Beta: ---

## Downloads

### Primary Mirror

On Nanolx the latest stable and current beta releases are available, no previous releases.

* Stable Downloads [> Nanolx](https://downloads.nanolx.org/NanoDroid/Stable)
* Beta Downloads [> Nanolx](https://downloads.nanolx.org/NanoDroid/Beta)

### SHA256 Checksum and GPG Signature

Since version 18.3.1 all releases hosted on nanolx.org contain a SHA256 checksum and GPG signature to check their validity. AFH does provide the SHA256 checksum on the downloads summary page, but does not allow to upload a GPG signature.

You can obtain the public part of my GPG key from:

* download the public key from [photonic.asc](https://downloads.nanolx.org/NanoDroid/Stable/photonic.asc)
  * import it using `gpg --import photonic.asc`
* download and import using `gpg` from pgp.mit.edu:
  * `gpg --keyserver pgp.mit.edu --recv B0ABCE622A077B584B81339E340FD70EFFC52B26`

You can verify the checksum and signature like:

```
gpg --verify NanoDroid-19.0.20181027.zip.sha256.sig
sha256sum -c NanoDroid-19.0.20181027.zip.sha256
```

Additionally you may want to ensure the signing date is close to the release date.

### Snapshots

You can create snapshots from this repository using the `build-package` script.

See the [build-package documentation](doc/BuildPackage.md) for more information.

## Custom builds

The following applications are custom builds (see [F-Droid Repository](#f-droid-repository) below):

* Play Store (reason: re-signed and modified to support (in-)app-purchases with microG GmsCore)
* MPV (reason: infrequent updates)

The git repository as central place/navigational point for all custom builds from NanoDroid is located here:

* https://gitlab.com/Nanolx/nanodroid-patches

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
* 9.0 / SDK 28 (Pie)
  * Patcher works if your ROM's services.jar already contains classes.dex
     * [> Deodex Instructions](doc/DeodexServices.md)
* 10.0 / SDK 29 (Q)
  * Patcher works if your ROM's services.jar already contains classes.dex
     * [> Deodex Instructions](doc/DeodexServices.md)
* 11.0 / SDK 30 (R)
  * Patcher does not work from TWRP
  * Patcher works from Magisk if your ROM's services.jar already contains classes.dex
     * [> Deodex Instructions](doc/DeodexServices.md)

Earlier versions will never officially be supported (you may still report bugs, though). Future versions will be officially supported, eventually.

## Recommended Thirdparty Projects

* [busybox](https://forum.xda-developers.com/showthread.php?t=2239421) by Osm0sis (highly recommended for all NanoDroid scripts properly working)
* [GNU Nano editor](https://forum.xda-developers.com/showthread.php?t=2239421) by Osm0sis (simple, powerful commandline editor)

## Support

[> XDA](https://forum.xda-developers.com/apps/magisk/module-nanodroid-5-0-20170405-microg-t3584928) Support Thread

## ChangeLog

Full, user-readible [> ChangeLog](ChangeLog.md)

## Summary

**NanoDroid** can be installed as a Magisk Module or directly to /system, most functionality is available, in System Mode, too.

More information about Magisk [> XDA](https://forum.xda-developers.com/apps/magisk)

NanoDroid includes

* microG and it's companions
  * GApps are auto-removed during installation
     * using [> NanoDroid-Overlay](doc/NanoDroidOverlay.md)
     * the Uninstaller will restore them in System Mode (or re-flash the ROM)
     * see the [> GApps Removal List](doc/GAppsRemoval.md)
  * location packages conflicting with unified Nlp will be auto-removed during installation
     * using [> NanoDroid-Overlay](doc/NanoDroidOverlay.md)
     * the Uninstaller will restore them (or re-flash the ROM)
     * see the [> GApps Removal List](doc/GAppsRemoval.md#list-of-removed-location-providers)
* [> F-Droid](https://f-droid.org) and it's privileged extension
  * alternatively you can install [> Aurora Droid](https://f-droid.org/en/packages/com.aurora.adroid) and it's services extension
* modified Play Store to allow (in-)app-purchases with microG
  * this required the Play Store to be modified, see the [> patch](https://gitlab.com/Nanolx/microg-phonesky-iap-support)
  * alternatively [> Aurora Store](https://f-droid.org/en/packages/com.aurora.store) and it's services extension can be installed instead
* custom init scripts
* pseudo-debloat feature (Magisk Mode)
  * disables applications systemless-ly
  * pre-configured [> default settings](doc/NanoDroidOverlay.md)
* force-debloat feature (Sytem Mode)
  * moves applications out of the way to /data/media/0/nanodroid_backup/
  * pre-configured [> default settings](doc/NanoDroidOverlay.md)
* several Open Source applications
  * include replacements for the pseudo-debloated applications
  * full list of [> included applications](doc/Applications.md)
* on-device framework-patcher for microG support (signature spoofing)
  * with automatic de-odexing up to Android 8.1
* additional components
  * GNU Bash shell (with Less pager)
  * Addon.d support for System Mode installation
     * restores NanoDroid after ROM update
     * re-debloates GApps, if required

## Packages

See the [Packages](doc/Packages.md) summary for information about the available packages.

### F-Droid Repository

In order to ease updating NanoDroid's custom application builds you can use it's companion [F-Droid Repository](https://www.nanolx.org/fdroid/repo)

## Details

See the [> Detail information](doc/Details.md) for full details on microG, F-Droid, features and utilities included with NanoDroid.

## Installation

See the [Installation](doc/Installation.md) docs for instructions

## microG Setup

See the [microG setup](doc/microGsetup.md) documentation

## Issues

See [the list of known issues](doc/Issues.md) and their respective fixes or workarounds.

## License & Credits

My own work (NanoDroid itself) is licensed under the GNU General Public License version 3 or newer [> GNU](https://www.gnu.org/licenses/gpl-3.0.txt)

For more details (including authors and license) on every provided application or Software press the link next to it.

Additional credits go to

* Mar-V-In for microG
  * https://github.com/microg
* topjohnwu for Magisk
  * https://github.com/topjohnwu/Magisk
* Lanchon for dexpatcher and haystack
  * https://github.com/dexpatcher
* osm0sis for GNU Nano and Busybox
  * https://forum.xda-developers.com/showthread.php?t=2239421
* shadow53 for automatic apk grabbing base code
  * https://shadow53.com/android/no-gapps/
* ale5000 for GApps Removal list and native signature spoofing detection
  * https://github.com/micro5k
* anestisb for vdexExtractor
  * https://github.com/anestisb/vdexExtractor
* JesusFreke for smali/baksmali
  * https://github.com/JesusFreke/smali
* Zackptg5 for zstd binaries
  * https://github.com/Zackptg5/Cross-Compiled-Binaries-Android

Special Thanks to the contributors (starting with most recent contribution)

* TanyaEleventhGoddess
  * various improvements and fixed for `build-package`
* Gia90
  * Android 6.0 support for Patcher
  * fixes for x86_64 support
* Vavun
  * OsmAnd package
  * several contributions to NanoDroid (and it's former microG GmsCore fork)

Special Thanks to the beta testers

* xenithorb
* ShapeShifter499

## TODO

## FAQ

```
Q: will there be a GApps version, instead of microG?
A: no. but you can choose not to populate microG.

Q: what devices is this tested on?
A: OnePlus 5T, OnePlus 3T, Nexus 6

Q: what ROMs was this tested on?
A: AICP, OmniROM, NitrogenOS; should work on any LineageOS / AOSP based ROM and most Stock ROMs.
```
