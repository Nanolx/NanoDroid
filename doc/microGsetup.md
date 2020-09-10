Table of Contents
=================

   * [microG setup](#microg-setup)
      * [Signature Spoofing Support](#signature-spoofing-support)
      * [microG Setup](#microg-setup-1)

Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc)

# microG setup

## Signature Spoofing Support

For **microG** to work, your ROM needs to have signature spoofing enabled (or a **deodexed** ROM to patch yourself).

If your ROM does **not** have signature spoofing support, you can manually patch it either
  * flashing the on-device Patcher zip
     * it also installs an addon.d script that auto re-patches the ROM upon update

If your ROM is **odexed** read [this instructions](DeodexServices.md) on how to deodex services.jar manually

The Patcher supports installing the patched `services.jar` into the following locations:
  * NanoDroid Magisk Module
  * NanoDroid-microG Magisk Module
  * directly into `/system`

So you can use it regardless whether you're using NanoDroid or not.

## microG Setup

Once your ROM supports signature spoofing, you need to setup microG like this
  * go into **microG settings** and set up everything like:
     * check results in **Self-Check**, grant missing permissions (by tapping on them)
         * especially the **Battery Optimization** item
         * if Phonesky (= Fake Store or Play Store) lacks signature spoofing permissions head to Settings > Apps > Permissions > Signature Spoofing and grant it
             * or manually using `pm grant com.google.gms android.permission.FAKE_PACKAGE_SIGNATURE` as root on-device
             * likewise `pm grant com.android.vending android.permission.FAKE_PACKAGE_SIGNATURE` for Phonesky
     * enable **Google device registration**
     * enable **Google Cloud Messaging** (only if you want to receive push messages from your applications)
     * enable **Google SafetyNet** (required for applications that utilize SafetyNet, for example Pokémon GO, ...)
     * in **UnifiedNlp Settings** choose either any or all of (whichever you've choosen to be installed)
         * **Déjà Vu**, **Mozilla**, **Apple**, **Radiocell** as Geolocation backend
         * **Nominatim** as Address lockup backend
     * after everything is done, reboot
     * if you installed **Play Store** open it, setup account and install your apps
