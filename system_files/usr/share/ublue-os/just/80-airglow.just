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
    #!/bin/bash
    echo "Scanning for disconnected video ports..."
    mapfile -t ports < <(for p in /sys/class/drm/*/status; do
        con="${p%/status}"
        if [ "$(cat "$p")" = "disconnected" ]; then
            echo "${con#*/card?-}"
        fi
    done)

    if [ "${#ports[@]}" -eq 0 ]; then
        echo "No disconnected ports found."
        exit 1
    fi

    echo "Disconnected video ports:"
    for i in "${!ports[@]}"; do
        printf "%d) %s\n" "$((i+1))" "${ports[$i]}"
    done

    read -p "Select a port by number: " choice
    if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -lt 1 ] || [ "$choice" -gt "${#ports[@]}" ]; then
        echo "Invalid selection."
        exit 1
    fi

    selected_port="${ports[$((choice-1))]}"
    echo "Selected port: $selected_port"

    echo "Appending kernel arguments with rpm-ostree..."
    sudo rpm-ostree kargs --append-if-missing="video=${selected_port}:e"
    sudo rpm-ostree kargs --append-if-missing="drm.edid_firmware=${selected_port}:edid/samsung-q800t-hdmi2.1"

    echo "Kernel arguments updated. A reboot may be required."

