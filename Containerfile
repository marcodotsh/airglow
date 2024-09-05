ARG SOURCE_IMAGE=${BASE_IMAGE_NAME:-aurora-dx}

ARG FEDORA_VERSION="latest"


FROM ghcr.io/ublue-os/${SOURCE_IMAGE}:${FEDORA_VERSION}

## Copy system files
COPY system_files /

COPY build.sh /tmp/build.sh

COPY rpms /tmp/rpms

## Run customization from a bash script
RUN mkdir -p /var/lib/alternatives && \
    /tmp/build.sh && \
    ostree container commit

# Run other scripts
COPY scripts /tmp/scripts

RUN bash /tmp/scripts/zerotier.sh && \
    ostree container commit

## NOTES:
# - /var/lib/alternatives is required to prevent failure with some RPM installs
# - All RUN commands must end with ostree container commit
#   see: https://coreos.github.io/rpm-ostree/container/#using-ostree-container-commit

