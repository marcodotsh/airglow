#!/bin/sh

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Keyboard Configuration

# Configure keyboard layout to support scroll lock for backlight keyboard
sed -i 's/key <SCLK> {\[  Scroll_Lock  \]};/&\n    \/\/ Enable led on Kit Devastator Keyboard\n    modifier_map Mod3 { Scroll_Lock };/' /usr/share/X11/xkb/symbols/pc
