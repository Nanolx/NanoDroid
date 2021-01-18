Table of Contents
=================

* [GApps Removal](#gapps-removal)
    * [List of removed GApps](#list-of-removed-gapps)
    * [List of removed location services](#list-of-removed-location-services)

Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc)

# GApps Removal

GApps and several location services conflict with **microG** and **unified Nlp**. Thus they are removed during NanoDroid installation
using **[NanoDroid-Overlay](NanoDroidOverlay.md)**. The Uninstaller will restore them (or re-flash the ROM)

List of applications by @ale5000

## List of removed GApps

The following GApps are removed during installation:

* BlankStore
* ConfigUpdater
* FDroidPriv
* GCS
* GmsCoreSetupPrebuilt
* GmsCore_update
* GmsDroidGuard
* GoogleFeedback
* GoogleLoginService
* GoogleOneTimeInitializer
* GoogleServicesFramework
* GoogleTTS
* MarketUpdater
* MarkupGoogle
* PlayGames
* PlayStore
* PrebuiltGmsCore
* PrebuiltGmsCorePi
* PrebuiltGmsCorePix
* Velvet
* Vending
* WhisperPush

If the installation of NanoDroid is not an upgrade from a previous version, the following **data** will also be cleared:

* com.android.vending
* com.google.android.gms
* com.google.android.gsf
* com.google.android.gsf.login
* com.google.android.feedback
* com.mgoogle.android.gms

## List of removed location services

The following location services are removed during installation:

* AMAPNetworkLocation
* BaiduNetworkLocation
* LegacyNetworkLocation
* NetworkLocation
* UnifiedNlp
* DejaVuBackend
* DejaVuNlpBackend
* IchnaeaNlpBackend
* MozillaNlpBackend
* NominatimGeocoderBackend
* NominatimNlpBackend

If the installation of NanoDroid is not an upgrade from a previous version, the following **data** will also be cleared:

* com.amap.android.location
* com.baidu.location
* com.google.android.location
* org.microg.nlp
* org.microg.unifiednlp
