# NanoDroid-Overlay Script

## Purpose

The `nanodroid-overlay` Script, respectively it's shortcut `novl` is used by NanoDroid to handle the Pseudo Debloat Feature.

Full details on the Pseudo Debloat feature [> Details](doc/PseudoDebloat.md)

## Invocation

From within a terminal on your device, for example `adb shell` or `Termux` invoke the script using either

`nanodroid-overlay [switch] [parameter(s)]`

or

`novl [switch] [parameter(s)]`

## Overview

`-a`, `--add` [app]

add Overlay for **app** (if it exists) and add it to the config file; [app] is the name of the app's directory in `/system/app` or `/system/priv-app`

`-r`, `--remove` [app]

remove Overlay for **app** (if it exists) and remove it from the config file; [app] is the name of the app's directory in `/system/app` or `/system/priv-app`

`-s`, `--show`

show all apps that **don't** have an Overlay (slow)

`-l`, `--list`

show all apps that **do** have an Overlay

`-x`, `--create`

create Overlays from config file

`-u`, `--update`

remove existing Overlays and re-create them from the config file

`-c`, `--clear`

remove existing Overlays

`-g`, `--genconfig`

(re-)create config file from existing Overlays
