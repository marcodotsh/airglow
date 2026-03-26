ARG BASE_IMAGE_NAME=${BASE_IMAGE_NAME:-aurora-dx}
ARG FEDORA_MAJOR_VERSION=${FEDORA_MAJOR_VERSION:-40}

FROM ghcr.io/ublue-os/${BASE_IMAGE_NAME}:${FEDORA_MAJOR_VERSION}

ARG FEDORA_MAJOR_VERSION=${FEDORA_MAJOR_VERSION:-40}

## Copy system files
COPY system_files /

RUN mkdir -p /var/lib/alternatives && \
    ostree container commit

# Unroll scripts into separate layers to enable granular docker caching
# Order dictates cache-ability: Slow/Core modifications first, fast/local modifications last.
# - /var/lib/alternatives is required to prevent failure with some RPM installs
# - All RUN commands must end with ostree container commit
#   see: https://coreos.github.io/rpm-ostree/container/#using-ostree-container-commit

COPY build_files/copr-repos.sh /tmp/build_files/
RUN /tmp/build_files/copr-repos.sh && ostree container commit

COPY build_files/packages.sh /tmp/build_files/
RUN /tmp/build_files/packages.sh && ostree container commit

COPY build_files/zerotier.sh /tmp/build_files/
RUN bash /tmp/build_files/zerotier.sh && ostree container commit

COPY build_files/build-initramfs.sh /tmp/build_files/
RUN /tmp/build_files/build-initramfs.sh && ostree container commit

COPY build_files/keyboard-config.sh /tmp/build_files/
RUN /tmp/build_files/keyboard-config.sh && ostree container commit

COPY build_files/airglow-changes.sh /tmp/build_files/
RUN /tmp/build_files/airglow-changes.sh && ostree container commit

COPY build_files/branding.sh /tmp/build_files/
RUN /tmp/build_files/branding.sh && ostree container commit
