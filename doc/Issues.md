Table of Contents
=================

   * [Issues](#issues)
      * [microG](#microg)
         * [Battery Drain](#battery-drain)
         * [microG lacks features](#microg-lacks-features)
         * [permissions not granted on Android 10 or newer](#permissions-not-granted-on-android-10-or-newer)
         * [can't login to Google account on KitKat](#cant-login-to-google-account-on-kitkat)
         * [can't login to Goggle account with version 74.x of Chrome/WebView](#cant-login-to-goggle-account-with-version-74x-of-chromewebview)
      * [Google Play Services are missing](#google-play-services-are-missing)
      * [SafetyNet](#safetynet)
      * [Play Store](#play-store)
         * [Play Store not opening (error RH-01)](#play-store-not-opening-error-rh-01)
         * [Updating Play support libraries#](#updating-play-support-libraries)
         * [Can't install split APKs / extra data](#cant-install-split-apks--extra-data)
         * [Play Store does not show bought apps as bought](#play-store-does-not-show-bought-apps-as-bought)
         * [Play Store web interface can't install apps on my device](#play-store-web-interface-cant-install-apps-on-my-device)
      * [Push Messages](#push-messages)
      * [Unified Nlp](#unified-nlp)
      * [F-Droid](#f-droid)
      * [Aurora Store / Aurora Droid](#aurora-store--aurora-droid)
      * [Google Software](#google-software)
      * [Other](#other)
         * [Alarm Clock not ringing](#alarm-clock-not-ringing)
         * [Issues with ROM Sup Wizard](#issues-with-rom-sup-wizard)
         * [Applications crash with Bromite WebView](#applications-crash-with-bromite-webview)
         * [ROM lags after applying signature spoofing patch](#rom-lags-after-applying-signature-spoofing-patch)
         * [Applications can't access storage / permission issues](#applications-cant-access-storage--permission-issues)

Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc)

# Issues

## microG

### Battery Drain

* microG fails to register applications to GCM/FCM (Cloud Messaging) if they were installed **before** microG, but the apps keep trying to register and that causes the battery drain, all apps installed **after** microG are properly registered, to fix the battery drain issue the following command as root on your device (or via adb shell):
  * `find /data/data/*/shared_prefs -name com.google.android.gms.*.xml -delete`
      * alternatively `nutl -r`
      * this will force un-register all your applications from GCM/FCM and they'll re-register on next start

### microG lacks features

* if you use AppOps, PrivacyGuard or the like you have to grant microG GmsCore **all** permissions, if you prevent some permissions, some apps or features might not work as expected or not at all. Note: some APIs/features are stubs in microG GmsCore, meaning they exist that apps don't complain, but they do nothing - thus blocking microG GmsCore is pretty much of no benefit.

### permissions not granted on Android 10 or newer

* in Magisk Mode it might happen on some ROMs that microG is not granted the `RECEIVE_SMS` and `ACCESS_BACKGROUND_LOCATION` permissions, the fix is to install microG as user-app addtionally to system-app, this is done automatically starting with version 23.0 of NanoDroid (and **not** required in System Mode installation), to do so issue the following command on-device as root (via adb shell or Termux):
  * Full package: `pm install -r /data/adb/modules/NanoDroid/system/priv-app/GmsCore/GmsCore.apk`
  * microG package: `pm install -r /data/adb/modules/NanoDroid_microG/system/priv-app/GmsCore/GmsCore.apk`
* see [microG issue #1100](https://github.com/microg/android_packages_apps_GmsCore/issues/1100#issuecomment-711088518) and [microG issue #1100](https://github.com/microg/android_packages_apps_GmsCore/issues/1100#issuecomment-711141077) for background information

### can't login to Google account on KitKat

* updating microG to (at least) 0.2.7.17455 will fix the issue

### can't login to Goggle account with version 74.x of Chrome/WebView

* updating microG to (at least) 0.2.7.17455 will fix the issue

## Google Play Services are missing

* This misleading error message actually means 'Something is wrong with Play Store'
  * ensure as mentioned above you properly [setup microG](#microg-setup) and reboot
  * install either Fake Store or Play Store
     * grant signature spoofing permission to Fake Store or Play Store
         * go to System Settings > Apps > Permissions > Signature Spoofing for that
         * on some ROMs you have to tap on the 3-dot-menu `Show System Apps` to see Fake Store
             * or manually using `pm grant com.google.gms android.permission.FAKE_PACKAGE_SIGNATURE` as root on-device
             * likewise `pm grant com.android.vending android.permission.FAKE_PACKAGE_SIGNATURE` for Phonesky

## SafetyNet

**Note:** microG's Droid Guard Helper is currently _not_ able to perform SafetyNet Attestation.

* SafetyNet check complain with `Google Play Services are missing`
  * see [Google Play Services are missing](#google-play-services-are-missing) above
* SafetyNet check fails after upgrading Magisk to version 18.0
  * go to Magisk Manager > Magisk Hide and activate it for `microG DroidGuard Helper`
* Applications crash during SafetyNet check
  * install microG DroidGuard Helper as user-app (required on some ROMs), as root, on-device, issue:
      * `pm install -r /system/app/DroidGuard/DroidGuard.apk`
      * this is done automatically in Magisk Mode (as of version 20.5)

## Play Store

### Play Store not opening (error RH-01)

* Play Store giving error RH-01
  * ensure you rebooted after [microG setup](#microg-setup)
  * ensure Play Store has signature spoofing permission
      * go to Settings > Apps > Permissions > Signature Spoofing and grant it
  * go to Settings > Apps > Play Store > Permissions and grant at least the `Phone`  and `Storage` permission
  * force close Play Store and open it again

### Updating Play support libraries#

* Play Store tries to update itself or the Play Services, both updates fail because you have microG and a modified Play Store installed
  * you can disable the `GMSCoreUpdateService` service of the Play Store to prevent it from updating

### Can't install split APKs / extra data

* several huge applications (mostly games) have a rather small base APK and additional addon-data downloaded, if Play Store fails to install those
  * go to Settings > Apps > Play Store > Permissions and grant at least the `Phone`  and `Storage` permission
  * force close Play Store and open it again

### Play Store does not show bought apps as bought

If your Play Store doesn't show already bought apps as bought, you need to register the device ID to your Google Account, doing so will eliminate the "uncertified" status of Play Store and thus will allow you to re-download your already bought apps. Also remote installations using `https://play.google.com` will be working again afterwards.
* Go to microG Settings > Google Device Registration and note the `Android ID`
* Navigate to `https://www.google.com/android/uncertified/` and login using your Google Account
* Enter the ID shown in microG settings into the `Android ID` box and tap register
* Clean Play Store Cache (Settings > Apps > Play Store > Storage > Clean Cache)
* Reboot your device - the status of your bought apps is now restored

### Play Store web interface can't install apps on my device

See "Play Store does not show bought apps as bought" above, same fix.

## Push Messages

* Apps are not receiving Push messages
  * go to microG Settings / Google Cloud Messaging and check if it is connected
  * ensure you don't have an adblocker blocking the domain `mtalk.google.com` it is required for GCM to work
  * when using Titanium Backup or OAndBackupX first install the app only (without data) and start it, this will register the app, afterwards restore it's data
  * when restoring the ROM from a TWRP backup GCM registration for apps is sometimes broken. You may use the following command to reset GCM/FCM connection(s). App(s) will re-register when launched afterwards:
     * `nutl -r APPID` (eg.: APPID = `com.nianticlabs.pokemongo`) or `nutl -r` (for all applications)
  * if you can't make any app registering for Google Cloud Messaging, try the following
     * open the Phone app and dial the following: `*#*#2432546#*#*` (or ` *#*#CHECKIN#*#*`)

## Unified Nlp

**Note:** unified Nlp has known issues on Android 10.

* unified Nlp is not registered in the system
  * some ROMs with native signature spoofing don't look for `com.google.android.gms` as location provider
  * tell the developer (or maintainer) of the ROM to fix this
  * some versions of `com.qualcomm.location` conflict with uNlp, if it's installed and unified Nlp doesn't work, try the following command to get rid of it, as root, on-device:
     * `novl -a com.qualcomm.location`
* unified Nlp is registered in the system, but fails to get location
  * issue the following commands as root, on-device:
     * `pm grant com.google.android.gms android.permission.ACCESS_FINE_LOCATION`
     * `pm grant com.google.android.gms android.permission.ACCESS_COARSE_LOCATION`
     * for Android 10 and newer, additionally: `pm grant com.google.android.gms android.permission.ACCESS_BACKGROUND_LOCATION`
  * some versions of `com.qualcomm.location` conflict with uNlp, if it's installed and unified Nlp doesn't work, try the following command to get rid of it, as root, on-device:
     * `novl -a com.qualcomm.location`
* Ichnaea (Mozilla) location backend doesn't provide location
  * if you use Blockada, add the location backend to the whitelist
  * for any other ad-blocker, whitelist the following domain:
     * `https://location.services.mozilla.com`

## F-Droid

* On some ROMs (most noticeably MIUI ROMs) F-Droid can't install applications
  * this is because F-Droid's Priviledged Extension is not compatible with those ROMs, disable it from
      * F-Droid > Settings > Expert Settings > Privileged Extension

## Aurora Store / Aurora Droid

* If Aurora Store or Aurora Droid can't download/install applications check the following things:
  * go to System Settings > Apps > Aurora Store > allow "install unknown apps"
  * go to System Settings > Apps > Aurora Droid > allow "install unknown apps"
  * go to System Settings > Apps > Aurora Services > allow "install unknown apps"
     * if you use Aurora Services as installation method
  * also ensure Storage permission is granted for them

## Google Software

* Maps doesn't work when installed a second time
  * remove your Google Account and re-add it, that'll make Maps work again
  * remove traces from previous insallations, like
     * /sdcard/Android/data/com.google.android.apps.maps
     * /data/system/graphicsstats/1559520000000/com.google.android.apps.maps
         * where `1559520000000` is the Maps version, so may differ

* Hangouts isn't properly working
  * as root, on-device, run the following command:
     * `pm disable com.google.android.talk/com.google.android.apps.hangouts.service.NetworkConnectionCheckingService`

## Other

### Alarm Clock not ringing

* Due to changes in Android, to ensure your Alarm Clock is actually waking you up, you need Android to ignore battery optimization for it, to do so:
  * go to System Settings > Apps > Special Access > Battery Optimization > All Apps
  * tap on your Alarm Clock, for example `Alarmio` and choose `don't optimize`

### Issues with ROM Sup Wizard

* Some Stock ROMs do not properly work after first boot since their SetupWizard is disabled by NanoDroid (because it's incompatible with microG)
  * check `/system/build.prop` or `/vendor/build.prop` if they contain the property `ro.setupwizard.mode` and change it to (you can do this from TWRP via ADB, with the builtin `vi` editor)
      * `ro.setupwizard.mode=DISABLED`
      * in Magisk Mode NanoDroid will do this on it's own using Magisk's `resetprop`
  * if you can access your device via ADB, you can also issue the following command as root, on-device:
      * `nanodroid-util --fix-update`

### Applications crash with Bromite WebView

* install Bromite WebView as user-app, as root, on-device, issue:
  * `pm install -r /system/app/BromiteWebView/BromiteWebView.apk`
  * this is done automatically in Magisk Mode (as of version 20.5)

### ROM lags after applying signature spoofing patch

* some ROMs already have the patch built-in, if you patch those ROMs (again), it results in heavy lags
  * recent Patcher versions check whether the ROM has the patch already applied and disallow double-patching

### Applications can't access storage / permission issues

* if your Applications can't access storage or have other permission issues, do the following:
  * from TWRP remove the file `/data/system/users/0/runtime-permissons.xml`
  * or run the following command as root while in ROM: `pm reset-permissions`
* and reboot

Additional helpful information in the microG [> Wiki](https://github.com/microg/android_packages_apps_GmsCore/wiki/Helpful-Information).
