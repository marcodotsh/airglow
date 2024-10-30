#!/usr/bin/bash

set -ouex pipefail

# Branding for airglow
sed -i '/^PRETTY_NAME/s/Aurora-dx/Airglow/' /usr/lib/os-release
sed -i 's/Aurora-dx/Airglow/' /etc/yafti.yml
sed -i 's/Aurora-DX/Airglow/' /usr/share/kde-settings/kde-profile/default/xdg/kcm-about-distrorc

