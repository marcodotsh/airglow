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



#### Change to System Configuration Files

# this example modifies default timeouts to prevent slow reboots from services that won't stop
sed -i 's/#DefaultTimeoutStopSec.*/DefaultTimeoutStopSec=15s/' /etc/systemd/user.conf
sed -i 's/#DefaultTimeoutStopSec.*/DefaultTimeoutStopSec=15s/' /etc/systemd/system.conf
