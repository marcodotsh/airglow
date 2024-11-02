#!/usr/bin/bash

set -ouex pipefail

# Add Sunshine beta repo
curl -Lo /etc/yum.repos.d/lizardbyte-beta-fedora-"${FEDORA_MAJOR_VERSION}".repo https://copr.fedorainfracloud.org/coprs/lizardbyte/beta/repo/fedora-"${FEDORA_MAJOR_VERSION}"/lizardbyte-beta-fedora-"${FEDORA_MAJOR_VERSION}".repo

# Add bazzite repo
curl -Lo /etc/yum.repos.d/kylegospo-bazzite-fedora-"${FEDORA_MAJOR_VERSION}".repo https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite/repo/fedora-"${FEDORA_MAJOR_VERSION}"/kylegospo-bazzite-fedora-"${FEDORA_MAJOR_VERSION}".repo
