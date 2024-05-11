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
ostree container commit

# Install kdenetwork-filesharing to enable network share in dolphin
rpm-ostree install kdenetwork-filesharing samba-usershares
ostree container commit

# Install goldwarden
rpm-ostree install https://github.com/quexten/goldwarden/releases/download/v0.2.16/goldwarden-0.2.16-1.el7.x86_64.rpm
ostree container commit

# Install zerotier
curl -s https://install.zerotier.com | bash
