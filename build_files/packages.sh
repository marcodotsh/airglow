#!/bin/sh

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# Install sunshine from pre built package with DMA-BUF sharing for VAAPI support (pull #2053)
# binary artifact has expired, rebuilding for now and adding this package manually
rpm-ostree install /tmp/rpms/sunshine-fedora-40-amd64.rpm
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
curl -L https://github.com/zeroxoneafour/polonium/releases/latest/download/polonium.kwinscript -o polonium-kwinscript.zip
plasmapkg --global --install polonium-kwinscript.zip
