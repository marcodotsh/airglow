ARG BASE_IMAGE_NAME=${BASE_IMAGE_NAME:-aurora-dx}

ARG FEDORA_VERSION="latest"


FROM ghcr.io/ublue-os/${BASE_IMAGE_NAME}:${FEDORA_VERSION}

## Copy system files
COPY system_files /

COPY build_files /tmp/build_files

COPY rpms /tmp/rpms

## Run customization from a bash script
RUN mkdir -p /var/lib/alternatives && \
    /tmp/build_files/packages.sh && \
    /tmp/build_files/keyboard-config.sh && \
    /tmp/build_files/airglow-changes.sh && \
    ostree container commit

# Copy again scripts, after memory intensive operation they could have been deleted
COPY build_files /tmp/build_files

RUN bash /tmp/build_files/zerotier.sh && \
    ostree container commit

## NOTES:
# - /var/lib/alternatives is required to prevent failure with some RPM installs
# - All RUN commands must end with ostree container commit
#   see: https://coreos.github.io/rpm-ostree/container/#using-ostree-container-commit

