Table of Contents
=================

   * [Alter Installation](#alter-installation)
      * [Configuration File](#configuration-file)
      * [Detailed Description](#detailed-description)
         * [nanodroid_microg](#nanodroid_microg)
         * [nanodroid_nlpbackend](#nanodroid_nlpbackend)
         * [nanodroid_mapsv1](#nanodroid_mapsv1)
         * [nanodroid_play](#nanodroid_play)
         * [nanodroid_fdroid](#nanodroid_fdroid)
         * [nanodroid_apps](#nanodroid_apps)
         * [nanodroid_overlay](#nanodroid_overlay)
         * [nanodroid_bash](#nanodroid_bash)
         * [nanodroid_init](#nanodroid_init)
         * [nanodroid_gsync](#nanodroid_gsync)
         * [nanodroid_swipe](#nanodroid_swipe)
         * [nanodroid_forcesystem](#nanodroid_forcesystem)

Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc)

# Alter Installation

## Configuration File

To alter the installation you can create the file `.nanodroid-setup` on your device, in one of the following directories:

* `/data/media/0` (internal storage **[TWRP]**)
* `/sdcard1` (internal storage **[ORANGEFOX]**)
* `/external_sd` (TWRP path to SD Card (if any))
* `/data` (fallback)
* `/system/addon.d/` (fallback if TWRP can't mount `/data`)
* `/tmp` (fallback if TWRP can't mount `/data`)

You can use the [default configuration file](.nanodroid-setup) as a starting point. Below follows its detailed description. If a required entry is missing from your configuration file, the default setting will be added to your configuration file.

## Detailed Description

### nanodroid_microg

**microG** installation

**supported packages:** *Full package*, *microG package*

**Syntax:** `nanodroid_microg=1`, value can be 0, 1 or 2:

* 0 = don't install microG at all (Note: does not effect NanoDroid-microG package)
* 1 = install microG GmsCore, GsfProxy, DroidGuard Helper and Nominatim Geocoder Backend
* 2 = install microG GmsCore and Nominatim Geocoder Backend only
  * note: OpenSource purists setting; this will leave you without
      * Push Messaging support through GCM
      * SafetyNet attestation

### nanodroid_nlpbackend

what uNlp backends to install

**supported packages:** *Full package*, *microG package*

**Syntax:** `nanodroid_nlpbackend=1000`

this setting is four digits long, each digit represents one uNlp backend:
* 0 = don't install the backend
* 1 = install the backend

digits represent the following backends:
* 1st digit = `Déjà Vu` backend
* 2nd digit = `Ichnaea` (Mozilla) backend
* 3rd digit = `Apple` backend
* 4th digit = `Radiocells.org` backend

examples:
* nanodroid_nlpbackend=1000 = install `Déjà Vu backend` only
* nanodroid_nlpbackend=1010 = install `Déjà Vu` and `Apple` backends

### nanodroid_mapsv1

**microG** Maps API v1 support

**supported packages:** *Full package*, *microG package*

**Syntax:** `nanodroid_mapsv1=1`

* 0 = don't install Maps v1 API support
* 1 = install Maps v1 API support

### nanodroid_play

what app store to install

**supported packages:** *Full package*, *microG package*

**Syntax:** `nanodroid_play=21`, the first digit declares the app store, the second whether to install Fake store alongside:

* 00 = install no app store
* 10 = install Google Play (patched with microG (in-)app-purchase support)
* 01 = install Fake Store
* 20 = install Aurora Store (alongside Aurora Services addon)
* 21 = install Aurora Store (alongside Aurora Services addon) and Fake Store
* 30 = install Google Play (patched with microG (in-)app-purchase support) and Aurora Store (alongside Aurora Services addon)

Note:
* if `nanodroid_play=11` or `nanodroid_play=31` it will be silently treated as `10` or `30`
  * you can't install both Play Store and Fake Store at the same time

### nanodroid_fdroid

**F-Droid** installation

**supported packages:** *Full package*, *F-droid package*

**Syntax:** `nanodroid_fdroid=1`, value can be 0, 1, 2 or 3:

* 0 = don't install F-Droid at all (**Note:** does not effect NanoDroid-FDroid package)
* 1 = install official F-Droid client (alongside priviledged extension)
* 2 = install unofficial Aurora F-Droid client (alongside Aurora Services addon)
* 3 = install both official and Aurora F-Droid clients (alongside their addons)

### nanodroid_apps

Apps installation

**supported packages:** *Full package*

**Syntax:** `nanodroid_apps=1`, value can be 0 or 1:

* 0 = don't install applications
* 1 = install all applications listed in .nanodroid-apps file

see [> Applications](Applications.md) for detailed information

### nanodroid_overlay

whether to utilize the NanoDroid-Overlay to pseudo-debloat `/system` applications in Magisk Mode, or force-debloat on System Mode

**supported packages:** *Full package*, *microG package*

**Syntax:** `nanodroid_overlay=1`, value can be 0 or 1:

* 0 = don't utilize NanoDroid-Overlay
* 1 = utilize NanoDroid-Overlay

see [> NanoDroid-Overlay](NanoDroidOverlay.md) for detailed information

### nanodroid_bash

GNU Bash (alongside the less pager) installation

**supported packages:** *Full package*

**Syntax:** `nanodroid_bash=1`, value can be 0: 1:

* 0 = don't install GNU Bash
* 1 = install GNU Bash

### nanodroid_init

init scripts installation

**supported packages:** *Full package*

**Syntax:** `nanodroid_init="10_sqlite 20_fstrim"`

This setting is a list of init scripts, each listed item will be installed, possible values

```
10_sqlite
20_fstrim
30_logcat
40_external_sd
50_logscleaner
```

Leave an empty quote (`nanodroid_init=""`) to not install any init script

see [init-scripts](../README.md#init-scripts) for more information

### nanodroid_gsync

Google Sync Adapters installation

**supported packages:** *Google*

**Syntax:** `nanodroid_gsync=1`, value can be 0 or 1:

* 0 = don't install Google Sync Adapters
* 1 = install Google Sync Adapters

### nanodroid_swipe

Swipe libraries installation

**supported packages:** *Google*

**Syntax:** `nanodroid_swipe=1`, value can be 0 or 1:

* 0 = don't install Swipe libraries
* 1 = install Swipe libraries

### nanodroid_forcesystem

Force `/system` installation instrad of Magisk Module installation (if Magisk available)

**Note:** You shouldn't touch this settings unless you really know what you are doing.

**supported packages:** *Full*, *miroG*, *F-Droid*, *Bromite System WebView*, *OSM Android*, *Google*

**Syntax:** `nanodroid_forcesystem=0`, value can be 0 or 1:

* 0 = auto detect installation mode (default)
* 1 = force /system installation
