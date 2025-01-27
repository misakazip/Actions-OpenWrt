#!/bin/bash

# ======================================================
# OpenWrt Configuration Script
# Purpose: Automatically set up .config for OpenWrt builds
# Usage: Execute this script in your build environment
#        after initializing with "make menuconfig".
# ======================================================

# Stop script on error
set -e

CONFIG_FILE="$BUILD_ROOT/.config"

curl -fsSL -o $CONFIG_FILE https://raw.githubusercontent.com/misakazip/Actions-OpenWrt/refs/heads/master/.config
