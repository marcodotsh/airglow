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

# Install drm-utils for modetest command (DRM/KMS)
rpm-ostree install drm-utils

# Install kdenetwork-filesharing to enable network share in dolphin
rpm-ostree install kdenetwork-filesharing samba-usershares

# Install goldwarden
GOLDWARDEN_VERSION=$(curl -s https://api.github.com/repos/quexten/goldwarden/tags | jq -r '.[0].name')
GOLDWARDEN_VERSION_NUMBER=$(echo $GOLDWARDEN_VERSION | sed 's/v//')
rpm-ostree install "https://github.com/quexten/goldwarden/releases/download/$GOLDWARDEN_VERSION/goldwarden-$GOLDWARDEN_VERSION_NUMBER-1.el7.x86_64.rpm"

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

# Install libcamera to support surface cams
rpm-ostree install libcamera libcamera-tools libcamera-gstreamer libcamera-ipa pipewire-plugin-libcamera

# Install merkuro (KDE calendar, tasks, contacts)
rpm-ostree install akonadi merkuro korganizer

# Install waydroid
rpm-ostree install waydroid cage wlr-randr lzip
sed -i~ -E 's/=.\$\(command -v (nft|ip6?tables-legacy).*/=/g' /usr/lib/waydroid/data/scripts/waydroid-net.sh
curl -Lo /usr/bin/waydroid-choose-gpu https://raw.githubusercontent.com/KyleGospo/waydroid-scripts/main/waydroid-choose-gpu.sh
chmod +x /usr/bin/waydroid-choose-gpu

# Install dependencies for WinApps
rpm-ostree install dialog
