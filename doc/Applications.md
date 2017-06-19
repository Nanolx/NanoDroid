# Applications

## Provided Applications

The applications provided by NanoMod will be
* magic-mounted as system applications when installed as Magisk Module
* directly installed as system applications when installed in System Mode

Full list of provided applications
* Adaway [![F-Droid Link](fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=adaway&fdid=org.adaway)
* Amaze (File Manager) [![F-Droid Link](fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=amaze&fdid=com.amaze.filemanager)
* AnySoftKeyboard [![F-Droid Link](fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=anysoftkeyboard&fdid=com.menny.android.anysoftkeyboard)
* (Simple) Calendar [![F-Droid Link](fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=calendar&fdid=com.simplemobiletools.calendar)
* Face Slim (Facebook client) [![F-Droid Link](fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=face+slim&fdid=org.indywidualni.fblite)
* F-Droid (FOSS app store) [![F-Droid Link](fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=f-droid&fdid=org.fdroid.fdroid)
  * F-Droid Privileged Extension [![F-Droid Link](fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=f-droid&fdid=org.fdroid.fdroid.privileged)
* (Simple) Gallery [![F-Droid Link](fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=gallery&fdid=com.simplemobiletools.gallery)
* Hacker's Keyboard [![F-Droid Link](fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=hacker&fdid=org.pocketworkstation.pckeyboard)
* K-9 Mail [![F-Droid Link](fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=k9&fdid=com.fsck.k9)
* Kernel Adiutor [![GitHub Link](github.png)](https://github.com/Grarak/KernelAdiutor)
* KeyPassDroid (Password Safe) [![F-Droid Link](fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=keepass&fdid=com.android.keepass)
* Lightning (Browser) [![F-Droid Link](fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=lightning&fdid=acr.browser.lightning)
* MPV (Video Player) [![GitHub Link](github.png)](https://github.com/mpv-android/mpv-android)
* New Pipe (YouTube client) [![F-Droid Link](fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=newpipe&fdid=org.schabi.newpipe)
* Oandbackup (App backup and restore) [![F-Droid Link](fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=Oandbackup&fdid=dk.jens.backup)
* Odyssey (Audio player) [![F-Droid Link](fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=odyssey&fdid=org.gateshipone.odyssey)
* OpenCamera [![F-Droid Link](fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=open+camera&fdid=net.sourceforge.opencamera)
* OpenKeyChain [![F-Droid Link](fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=Oandbackup&fdid=org.sufficientlysecure.keychain)
* OpenLauncher [![F-Droid Link](fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=openlauncher&fdid=com.benny.openlauncher)
* OpenWeatherMap Weather Provider [![GitHub Link](github.png)](https://github.com/LineageOS/android_packages_apps_OpenWeatherMapProvider)
* OpenVPN [![F-Droid Link](fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=openvpn&fdid=de.blinkt.openvpn)
* QKSMS [![F-Droid Link](fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=qk&fdid=com.moez.QKSMS)
* Substratum (App) [![GitHub Link](github.png)](https://github.com/substratum/substratum)
* Termux [![F-Droid Link](fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=termux&fdid=com.termux)
* Twidere (Twitter client) [![F-Droid Link](fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=twidere&fdid=org.mariotaku.twidere)
* XDA Labs [![XDA Link](xda.png)](https://forum.xda-developers.com/android/apps-games/labs-t3241866)
  * source not (yet) available
* Yahoo Weather Provider [![GitHub Link](github.png)](https://github.com/LineageOS/android_packages_apps_YahooWeatherProvider)

## Alter provided Applications

You can prevent applications from being magic-mounted or installed by **removing** them from the file

`.nanomod-apps`

on your device, in one of the following directories

* `/data` (default)
* `/sdcard` (internal storage)
* `/persist`
* mount point of your external SD-Card (if any)
* directory containing the zip file

See the default settings [![GitHub Link](github.png)](.nanomod-apps), which are used when no `.nanomod-apps` configuration file was found. The syntax is pretty simple:

* one item per line
* name must be an exact match

applications managed by other setup variables (F-Droid, microG, PlayStore) are not effected by this file.
