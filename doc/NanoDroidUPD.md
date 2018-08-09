# NanoDroid-UPD Script

## Purpose

The `nanodroid-upd` Script, respectively it's shortcut `nupd` is used by NanoDroid to update NanoDroid's custom apks

  * Fake Store
  * Play Store
  * MPV
  * microG GmsCore
  * microG DroidGuard Helper

Applications are only updated if they are installed already during NanoDroid installation

**`nanodroid-upd` requires Busybox to be installed!**

## Invocation

From within a terminal on your device, for example `adb shell` or `Termux` invoke the script using either

`nanodroid-upd [apk]`

or

`nupd [apk]`

where **apk** can be

`ps`, `playstore`, `fs`, `fakestore`, `mpv`, `MPV`, `mg`, `microG`, `dg` or `DroidGuard`
