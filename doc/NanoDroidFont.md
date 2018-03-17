# NanoDroid-Font Script

## Purpose

The `nanodroid-font` Script, respectively it's shortcut `nfnt` is used to change the System UI font (reboot required to take effect), this feature exists in Magisk Mode only

The Font is not saved during NanoDroid Updates, thus needs to be re-applied after an update; restoration support during updates is a planned feature

## Invocation

From within a terminal on your device, for example `adb shell` or `Termux` invoke the script using either

`nanodroid-font [switch] [font]`

or

`nfnt [switch] [parameter]`

## Overview

`s`, `--set` [font]

set System UI font to [font], which is one of

  * FAST			FAST RMX Game Font
  * NintendoLabo		NintendoLabo Logo/Packaging Font
  * NintendoSwitch		NintendoSwitch OS Font
  * Splatoon2			Splatoon2 Game Font
  * SuperMarioMaker		Super Mario Maker Game Font
  * Super Mario			Super Mario (World) Game Font

`r`, `--reset`

reset to original font
