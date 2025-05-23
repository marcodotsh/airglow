# Install system flatpaks
install-airglow-flatpaks:
    #!/bin/bash
    AIRGLOW_ISO_FLATPAK_LIST="$(curl https://raw.githubusercontent.com/marcodotsh/airglow/main/iso_flatpaks/iso_flatpaks | tr '\n' ' ')"
    AIRGLOW_POSTINSTALL_FLATPAK_LIST="$(curl https://raw.githubusercontent.com/marcodotsh/airglow/main/postinstall_flatpaks/postinstall_flatpaks | tr '\n' ' ')"
    echo "Installing ISO Flatpaks.."
    flatpak --system -y install ${AIRGLOW_ISO_FLATPAK_LIST}
    echo "Installing Postinstall Flatpaks.."
    flatpak --system -y install ${AIRGLOW_POSTINSTALL_FLATPAK_LIST}

virtual-monitor-setup:
    @echo "Available disconnected video ports:"
    @ports=($(for p in /sys/class/drm/*/status; do con=${p%/status}; if [ $(cat $p) = "disconnected" ]; then echo "${con#*/card?-}"; fi; done))
    @for i in "${!ports[@]}"; do echo "$((i+1)). ${ports[$i]}"; done
    @echo -n "Select a port by number: "
    @read choice
    @selected_port=${ports[$((choice-1))]}
    @echo "Selected port: $selected_port"
    @echo "Appending kernel arguments..."
    @sudo rpm-ostree kargs --append-if-missing=drm.edid_firmware=${selected_port}:edid/samsung-q800t-hdmi2.1
    @sudo rpm-ostree kargs --append-if-missing=video=${selected_port}:e
