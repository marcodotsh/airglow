#!/usr/bin/bash

set -ouex pipefail

sed -i 's@enabled=1@enabled=0@g' /etc/yum.repos.d/lizardbyte-beta-fedora-"${FEDORA_MAJOR_VERSION}".repo
