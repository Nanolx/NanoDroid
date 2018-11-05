# GApps Removal

GApps and several location services conflict with microG and unified Nlp. Thus they are removed during NanoDroid installation

  * using [> NanoDroid-Overlay](doc/NanoDroidOverlay.md)

the Uninstaller will restore them (or re-flash the ROM)

List of applications by ale5000

## List of removed GApps

The following GApps are removed during installation:

* BlankStore
* FDroidPriv
* GmsCoreSetupPrebuilt
* GmsCore_update
* GmsDroidGuard
* GoogleFeedback
* GoogleLoginService
* GoogleOneTimeInitializer
* GooglePartnerSetup
* GoogleServicesFramework
* GoogleTTS
* MarketUpdater
* MarkupGoogle
* PlayGames
* PlayStore
* PrebuiltGmsCore
* Velvet
* Vending
* WhisperPush

If the installation of NanoDroid is not an upgrade from a previous version, the following **data** will also be cleared:

* com.google.android.feedback
* com.google.android.gsf.login
* com.google.android.location
* com.google.android.youtube
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
* com.qualcomm.location

If the installation of NanoDroid is not an upgrade from a previous version, the following **data** will also be cleared:

* com.qualcomm.location
* com.amap.android.location
* com.baidu.location
* com.google.android.location
* org.microg.nlp
* org.microg.unifiednlp
* com.google.android.maps
* org.fitchfamily.android.dejavu
* org.microg.nlp.backend.ichnaea
* org.microg.nlp.backend.nominatim
