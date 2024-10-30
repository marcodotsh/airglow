ARG BASE_IMAGE_NAME=${BASE_IMAGE_NAME:-aurora-dx}
ARG FEDORA_MAJOR_VERSION=${FEDORA_MAJOR_VERSION:-40}

FROM ghcr.io/ublue-os/${BASE_IMAGE_NAME}:${FEDORA_MAJOR_VERSION}

## Copy system files
COPY system_files /

COPY build_files /tmp/build_files

#COPY rpms /tmp/rpms

ARG FEDORA_MAJOR_VERSION=${FEDORA_MAJOR_VERSION:-40}
## Run customization from a bash script
RUN mkdir -p /var/lib/alternatives && \
    /tmp/build_files/copr-repos.sh && \
    /tmp/build_files/packages.sh && \
    /tmp/build_files/keyboard-config.sh && \
    /tmp/build_files/airglow-changes.sh && \
    /tmp/build_files/branding.sh && \
    /tmp/build_files/build-initramfs.sh && \
    ostree container commit

# Copy again scripts, after memory intensive operation they could have been deleted
COPY build_files /tmp/build_files

RUN bash /tmp/build_files/zerotier.sh && \
    ostree container commit

## NOTES:
# - /var/lib/alternatives is required to prevent failure with some RPM installs
# - All RUN commands must end with ostree container commit
#   see: https://coreos.github.io/rpm-ostree/container/#using-ostree-container-commit

