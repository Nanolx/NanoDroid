
Table of Contents
=================

   * [build-package](#build-package)
      * [Basic Instructions](#basic-instructions)
      * [Additional Features](#additional-features)
      * [Sideloading custom APKs](#sideloading-custom-apks)
      * ["Secret" parameters](#secret-parameters)

Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc)

# build-package

You can create snapshots from this repository using the `build-package` script.

## Basic Instructions

On GNU/Linux, MacOS or xBSD clone this repository and use the provided `build-package` script like

download required files:
* `build-package pull` to download all required apks and libraries for the Full, microG and F-Droid packages

For apks downloaded from F-Droid repositories or from APK Mirror, `build-package` checks the SHA256 hash.

update required files:
* `build-package u-microg` to update microG
* `build-package u-fdroid` to update F-Droid
* `build-package u-apps` to update applications
* `build-package u-swipe` to update swipe libraries
* `build-package u-gsync` to update Google Sync Adapters
* `build-package u-bromite` to update Bromite WebView
* `build-package u-osmand` to update OpenStreetMap (OsmAnd)
* `build-package u-patch` to update Haystack patches
  * currently disabled as NanoDroid uses new patches from [this pull request](https://github.com/Lanchon/haystack/pull/34)
* `build-package pull` to update/re-download everything

build packages:
* `build-package full` to create the Full package
* `build-package microg` to create the microG only package
* `build-package fdroid` to create the F-Droid only package
* `build-package patcher` to create the on-device framework-patcher package
* `build-package uninstaller` to create the uninstaller package
* `build-package bromitewebview` to create the Bromite WebView package
* `build-package osmand` for the OpenStreetMap (OsmAnd) package
* `build-package systest` to create the SysTest package
* `build-package google` to create the Google (Sync Adapters & Swipe libraries) package
* `build-package all` to create all packages at once

## Additional Features

The `build-package` script additionally supports the following parameters:

* `check` check if all files were properly downloaded
* `report` create a package report
* `clean` remove any untracked files from the repo (e. g. from `build-package pull`)
* `dalvik [.jar]` prepare a jar file for use with DalvikVM (requires Android SDK)
* `ver [version] [date]` change project version (if no date is given `99999999` will be used)
* `bump` increment Magisk module version by 1

## Sideloading custom APKs

If you want to use custom APKs in your build, place them into the `local` directory in the root of the NanoDroid tree.

The name of your APK must match the targetname in the NanoDroid package, e.g. `GmsCore` for a custom microG build or `Phonesky` for a custom Play Store build.

See the `file_database` in [build-package.database](../data/build-package.database).

**Note:** sideloading libraries is currently not supported!


## "Secret" parameters

* `export BP_DEBUG=1` allows seeing debug messages when repos are fetched and APKs are downloaded
* `export BP_USE_WGET=1` tells the script to use wget for downloading indices and APKs
