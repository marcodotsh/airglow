#!/bin/sh

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/${FEDORA_MAJOR_VERSION}/x86_64/repoview/index.html&protocol=https&redirect=1

# Install sunshine from pre built package with DMA-BUF sharing for VAAPI support (pull #2053)
# binary artifact has expired, rebuilding for now and adding this package manually
rpm-ostree install Sunshine 
systemctl enable sunshine-workaround.service

# Install kdenetwork-filesharing to enable network share in dolphin
rpm-ostree install kdenetwork-filesharing samba-usershares

# Install goldwarden
rpm-ostree install https://github.com/quexten/goldwarden/releases/download/v0.2.16/goldwarden-0.2.16-1.el7.x86_64.rpm

# Install Papirus Icon Theme
cd $(mktemp -d)
git clone https://github.com/PapirusDevelopmentTeam/papirus-icon-theme.git
mv papirus-icon-theme/Papirus /usr/share/icons/Papirus
mv papirus-icon-theme/Papirus-Dark /usr/share/icons/Papirus-Dark
rm -rf papirus-icon-theme

# Install polonium KWin script for tiling
cd $(mktemp -d)
curl -L https://github.com/zeroxoneafour/polonium/releases/download/nightly/polonium.kwinscript -o polonium-kwinscript.zip
kpackagetool6 --type KWin/Script --global --install polonium-kwinscript.zip

# Install Geometry Change effect for smooth animations
curl -L https://github.com/peterfajdiga/kwin4_effect_geometry_change/releases/download/v1.3/kwin4_effect_geometry_change_1_3.tar.gz -o kwin4_effect_geometry_change_1_3.tar.gz
kpackagetool6 --type KWin/Effect --global --install kwin4_effect_geometry_change_1_3.tar.gz

# Install window title applet to get current window icon widget
curl -L https://github.com/dhruv8sh/plasma6-window-title-applet/archive/refs/heads/master.zip -o plasma6-window-title-applet.zip
kpackagetool6 --type Plasma/Applet --global --install plasma6-window-title-applet.zip

# Install clevis-dracut to use tang LUKS unlock over home network
rpm-ostree install clevis-dracut
