#!/bin/sh

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Keyboard Configuration

# Configure it keyboard layout to support scroll lock for backlight keyboard
sed -i '0,/.*include "level3(ralt_switch).*/s/.*include "level3(ralt_switch).*/    \/\/ Enable led on Kit Devastator Keyboard\n    modifier_map Mod3 { Scroll_Lock };\n\n&/' /usr/share/X11/xkb/symbols/it
