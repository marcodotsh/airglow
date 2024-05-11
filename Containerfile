ARG SOURCE_IMAGE="aurora"

ARG SOURCE_SUFFIX="-dx"

ARG FEDORA_VERSION="latest"


FROM ghcr.io/ublue-os/${SOURCE_IMAGE}${SOURCE_SUFFIX}:${FEDORA_VERSION}

## Copy system files
COPY system_files /

COPY build.sh /tmp/build.sh

COPY rpms /tmp/rpms

COPY scripts /tmp/scripts

## Run customization from a bash script
RUN mkdir -p /var/lib/alternatives && \
    /tmp/build.sh && \
    ostree container commit

## NOTES:
# - /var/lib/alternatives is required to prevent failure with some RPM installs
# - All RUN commands must end with ostree container commit
#   see: https://coreos.github.io/rpm-ostree/container/#using-ostree-container-commit

