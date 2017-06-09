# Applications

## Provided Applications

The following applications are provided by NanoMod
* magic-mounted as system applications when installed as Magisk Module
* directly installed as system applications when installed in System Mode

* Adaway [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=adaway&fdid=org.adaway)
* Amaze (File Manager) [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=amaze&fdid=com.amaze.filemanager)
* AnySoftKeyboard [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=anysoftkeyboard&fdid=com.menny.android.anysoftkeyboard)
* Face Slim (Facebook client) [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=face+slim&fdid=org.indywidualni.fblite)
* F-Droid (FOSS app store) [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=f-droid&fdid=org.fdroid.fdroid)
  * F-Droid Privileged Extension [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=f-droid&fdid=org.fdroid.fdroid.privileged)
* Hacker's Keyboard [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=hacker&fdid=org.pocketworkstation.pckeyboard)
* K-9 Mail [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=k9&fdid=com.fsck.k9)
* Kernel Adiutor [![GitHub Link](images/github.png)](https://github.com/Grarak/KernelAdiutor)
* KeyPassDroid (Password Safe) [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=keepass&fdid=com.android.keepass)
* (Simple) Calendar [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=calendar&fdid=com.simplemobiletools.calendar)
* (Simple) Gallery [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=gallery&fdid=com.simplemobiletools.gallery)
* Lightning (Browser) [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=lightning&fdid=acr.browser.lightning)
* Magisk Manager [![GitHub Link](images/github.png)](https://github.com/topjohnwu/MagiskManager)
* New Pipe (YouTube client) [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=newpipe&fdid=org.schabi.newpipe)
* Oandbackup (App backup and restore) [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=Oandbackup&fdid=dk.jens.backup)
* Odyssey (Audio player) [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=odyssey&fdid=org.gateshipone.odyssey)
* OpenCamera [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=open+camera&fdid=net.sourceforge.opencamera)
* OpenKeyChain [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=Oandbackup&fdid=org.sufficientlysecure.keychain)
* OpenLauncher [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=openlauncher&fdid=com.benny.openlauncher)
* OpenVPN [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=openvpn&fdid=de.blinkt.openvpn)
* QKSMS [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=qk&fdid=com.moez.QKSMS)
* Substratum (App and Compiler) [![GitHub Link](images/github.png)](https://github.com/substratum/substratum)
  * will run in legacy mode on non-OMS ROMs
* Termux [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=termux&fdid=com.termux)
* Twidere (Twitter client) [![F-Droid Link](images/fdroid.png)](https://f-droid.org/repository/browse/?fdfilter=twidere&fdid=org.mariotaku.twidere)
* VLC (Audio/Video Player) [![GitLab Link](images/gitlab.png)](https://code.videolan.org/videolan/vlc-android)
* XDA Labs [![XDA Link](images/xda.png)](https://forum.xda-developers.com/android/apps-games/labs-t3241866)
  * source not (yet) available
* Yahoo Weather Provider [![GitHub Link](images/github.png)](https://github.com/CyanogenMod/android_packages_apps_YahooWeatherProvider)

## Alter provided Applications

You can remove applications from being magic-mounted by **removing** them from the file

`.nanomod-apps`

on your device, in one of the following directories

* `/data` (default)
* `/sdcard` (internal storage)
* `/persist`
* mount point of your external SD-Card (if any)
* directory containing the zip file

See the default settings [![GitHub Link](images/github.png)](.nanomod-apps). The syntax is pretty simple:

* one item per line
* name must be an exact match

Applications managed by other setup variables (F-Droid, microG, PlayStore) are not effected by this file.
