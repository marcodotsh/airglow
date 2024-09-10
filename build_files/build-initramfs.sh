#!/usr/bin/bash

set -oue pipefail

if [ ! -f /usr/libexec/rpm-ostree/wrapped/dracut ]; then
    rpm-ostree cliwrap install-to-root /
fi

QUALIFIED_KERNEL="$(rpm -qa | grep -P 'kernel-(|surface-)(\d+\.\d+\.\d+)' | sed -E 's/kernel-(|surface-)//')"

/usr/libexec/rpm-ostree/wrapped/dracut --no-hostonly --kver "$QUALIFIED_KERNEL" --reproducible -v --add ostree -f "/lib/modules/$QUALIFIED_KERNEL/initramfs.img"

chmod 0600 "/lib/modules/$QUALIFIED_KERNEL/initramfs.img"
