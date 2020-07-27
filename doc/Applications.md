# Applications

## Provided Applications

The applications provided by NanoDroid will be
* magic-mounted as system applications when installed as Magisk Module
* directly installed as system applications when installed in System Mode

Full list of provided applications
* Alarmio (Alarm Clock) [> F-Droid](https://f-droid.org/packages/me.jfenn.alarmio)
* Amaze (File Manager) [> F-Droid](https://f-droid.org/packages/com.amaze.filemanager)
* AnySoftKeyboard [> F-Droid](https://f-droid.org/packages/com.menny.android.anysoftkeyboard)
* Blokada [> F-Droid](https://f-droid.org/en/packages/org.blokada.alarm)
* Frost (Facebook client) [> F-Droid](https://f-droid.org/en/packages/com.pitchedapps.frost)
* Hacker's Keyboard [> F-Droid](https://f-droid.org/de/packages/org.pocketworkstation.pckeyboard)
* K-9 Mail [> F-Droid](https://f-droid.org/packages/com.fsck.k9)
* KeyPassDX (Password Safe) [> F-Droid](https://f-droid.org/en/packages/com.kunzisoft.keepass.libre)
* MPV (Video Player) [> GitHub](https://github.com/mpv-android/mpv-android)
* New Pipe (YouTube client) [> F-Droid](https://f-droid.org/packages/org.schabi.newpipe)
* OAndBackupX (App backup and restore) [> F-Droid](https://f-droid.org/de/packages/com.machiav3lli.backup/)
* Odyssey (Audio player) [> F-Droid](https://f-droid.org/packages/org.gateshipone.odyssey)
* OpenCamera [> F-Droid](https://f-droid.org/packages/net.sourceforge.opencamera)
* OpenKeyChain [> F-Droid](https://f-droid.org/packages/org.sufficientlysecure.keychain)
* OpenLauncher [> F-Droid](https://f-droid.org/packages/com.benny.openlauncher)
* OpenVPN [> F-Droid](https://f-droid.org/packages/de.blinkt.openvpn)
* Privacy Browser [> F-Droid](https://f-droid.org/de/packages/com.stoutner.privacybrowser.standard)
* QKSMS [> F-Droid](https://f-droid.org/packages/com.moez.QKSMS)
* Simple Calendar Pro [> F-Droid](https://f-droid.org/packages/com.simplemobiletools.calendar.pro)
* Simple Gallery Pro [> F-Droid](https://f-droid.org/packages/com.simplemobiletools.gallery.pro)
* SmartPack-Kernel-Manager [> GitHub](https://github.com/SmartPack/SmartPack-Kernel-Manager)
* Termux [> F-Droid](https://f-droid.org/packages/com.termux)
* TorBrowser [> Tor](https://www.torproject.org/projects/torbrowser.html.en)
* Twidere (Twitter client) [> F-Droid](https://f-droid.org/packages/org.mariotaku.twidere)
* XDA Labs [> XDA](https://forum.xda-developers.com/android/apps-games/labs-t3241866)
  * source not (yet) available

## Alter provided Applications

You can control what applications to install using the file

`.nanodroid-apps`

on your device, in one of the following directories

* `/data/media/0` (internal storage)
* `/external_sd` (TWRP path to SD Card (if any))
* directory containing the zip file
* `/data` (fallback)

All applications listed in that file will be installed. See the [default settings](.nanodroid-apps), which are used when no `.nanodroid-apps` configuration file was found. 

Alternatively you can also use the Setup Wizard instead of manual creation of the configuration file (if you've got an arm/arm64 device).

The syntax is pretty simple:

* one app per line
* name must be an exact match

applications managed by other setup variables (F-Droid, microG, PlayStore) are not effected by this file.
