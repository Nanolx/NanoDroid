
Table of Contents
=================

   * [Applications](#applications)
      * [Provided Applications](#provided-applications)
      * [Alter provided Applications](#alter-provided-applications)

Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc)

# Applications

## Provided Applications

The applications provided by NanoDroid will be
* magic-mounted as system applications when installed as Magisk Module
* directly installed as system applications when installed in System Mode

Note:
  * the name inside `{}` brackets is the one you need to put in your `.nanodroid-apps` configuration file, if you want to install that app
     * it must be an **exact** match (case sensitive!)

Full list of included applications:
* Alarmio (Alarm Clock) {Alarmio} [> F-Droid](https://f-droid.org/packages/me.jfenn.alarmio)
* Amaze (File Manager) {Amaze} [> F-Droid](https://f-droid.org/packages/com.amaze.filemanager)
* AnySoftKeyboard {AnysoftKeyboard} [> F-Droid](https://f-droid.org/packages/com.menny.android.anysoftkeyboard)
* Blokada {Blokada} [> F-Droid](https://f-droid.org/en/packages/org.blokada.alarm)
* FreeOTP+ (Two Factory Auth) {FreeOTPPlus} [> F-Droid](https://f-droid.org/en/packages/org.liberty.android.freeotpplus)
* Frost (Facebook client) {Frost} [> F-Droid](https://f-droid.org/en/packages/com.pitchedapps.frost)
* Hacker's Keyboard {HackersKeyboard} [> F-Droid](https://f-droid.org/de/packages/org.pocketworkstation.pckeyboard)
* K-9 Mail {K9Mail} [> F-Droid](https://f-droid.org/packages/com.fsck.k9)
* KeyPassDX (Password Safe) {KeePassDX} [> F-Droid](https://f-droid.org/en/packages/com.kunzisoft.keepass.libre)
* MPV (Video Player) {MPV} [> GitHub](https://github.com/mpv-android/mpv-android)
* New Pipe (YouTube client) {NewPipe} [> F-Droid](https://f-droid.org/packages/org.schabi.newpipe)
* OAndBackupX (App backup and restore) {OAndBackupX} [> F-Droid](https://f-droid.org/de/packages/com.machiav3lli.backup/)
* Odyssey (Audio player) {Odyssey} [> F-Droid](https://f-droid.org/packages/org.gateshipone.odyssey)
* OpenCamera {OpenCamera} [> F-Droid](https://f-droid.org/packages/net.sourceforge.opencamera)
* OpenKeyChain (GPG for use with K-9 Mail and others) {OpenKeyChain} [> F-Droid](https://f-droid.org/packages/org.sufficientlysecure.keychain)
* OpenLauncher {OpenLauncher} [> F-Droid](https://f-droid.org/packages/com.benny.openlauncher)
* OpenVPN {OpenVPN} [> F-Droid](https://f-droid.org/packages/de.blinkt.openvpn)
* Privacy Browser {PrivacyBrowser} [> F-Droid](https://f-droid.org/de/packages/com.stoutner.privacybrowser.standard)
* QKSMS {QKSMS} [> F-Droid](https://f-droid.org/packages/com.moez.QKSMS)
* Simple Calendar Pro {SimpleCalendar} [> F-Droid](https://f-droid.org/packages/com.simplemobiletools.calendar.pro)
* Simple Gallery Pro {SimpleGallery} [> F-Droid](https://f-droid.org/packages/com.simplemobiletools.gallery.pro)
* SmartPack-Kernel-Manager {SmartPackKernelManager} [> GitHub](https://github.com/SmartPack/SmartPack-Kernel-Manager)
* Termux (Terminal Emulator) {Termux} [> F-Droid](https://f-droid.org/packages/com.termux)
* TorBrowser {TorBrowser} [> Tor](https://www.torproject.org/projects/torbrowser.html.en)
* Twidere (Twitter client) {Twidere} [> F-Droid](https://f-droid.org/packages/org.mariotaku.twidere)
* Warden (Disable Services and Trackers) {Warden} [> GitLab](https://gitlab.com/AuroraOSS/AppWarden)
* XDA Labs (XDA Forum and App Store) {XDALabs} [> XDA](https://forum.xda-developers.com/android/apps-games/labs-t3241866)
  * source not (yet) available

## Alter provided Applications

You can control what applications to install using the file

`.nanodroid-apps`

on your device, in one of the following directories


* `/data/media/0` (internal storage (TWRP))
* `/sdcard1` (internal storage (ORANGEFOX))
* `/external_sd` (TWRP path to SD Card (if any))
* `/data` (fallback)
* `/system/addon.d/` (fallback if TWRP can't mount `/data`)
* `/tmp` (fallback if TWRP can't mount `/data`)

All applications listed in that file will be installed. See the [default configuration](.nanodroid-apps), which is used when no `.nanodroid-apps` configuration file was found.

The syntax is pretty simple:

* one app per line
* name must be an exact match (case sensitive!)
  * see names in `{}` brackets above
* commented out lines (starting with #) will be ignored

applications managed by other setup variables (F-Droid, microG, PlayStore) are not effected by this file.
