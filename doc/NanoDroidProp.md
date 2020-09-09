Table of Contents
=================

   * [NanoDroid-Prop Script](#nanodroid-prop-script)
      * [Purpose](#purpose)
      * [Invocation](#invocation)
      * [Overview](#overview)

Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc)

# NanoDroid-Prop Script

## Purpose

The `nanodroid-prop` Script, respectively it's shortcut `nprp` is used by NanoDroid to utilize Magisk's `resetprop` feature for on-the-fly and permanently adjusting system properties. Properties set by this script survive NanoDroid updates

## Invocation

From within a terminal on your device, for example `adb shell` or `Termux` invoke the script using either

`nanodroid-prop [switch] [parameter(s)]`

or

`nprp [switch] [parameter(s)]`

## Overview

`-C`, `--cast`

set properties required to enable the cast feature on some custom ROMs

`-A`, `--add-prop` [prop] [value]

add a system property both on-the-fly and permanently by adding it to NanoDroid's `system.prop` file

`-R`, `--remove-prop` [prop]

remove a system property from NanoDroid's `system.prop` file

`-L`, `--list-prop`

list all properties from NanoDroid's `system.prop` file
