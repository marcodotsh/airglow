# Install system flatpaks
install-airglow-flatpaks:
    #!/bin/bash
    AIRGLOW_ISO_FLATPAK_LIST="$(curl https://raw.githubusercontent.com/marcodotsh/airglow/main/airglow_flatpaks/iso_flatpaks | tr '\n' ' ')"
    AIRGLOW_POSTINSTALL_FLATPAK_LIST="$(curl https://raw.githubusercontent.com/marcodotsh/airglow/main/airglow_flatpaks/postinstall_flatpaks | tr '\n' ' ')"
    echo "Installing ISO Flatpaks.."
    flatpak --system -y install ${AIRGLOW_ISO_FLATPAK_LIST}
    echo "Installing Postinstall Flatpaks.."
    flatpak --system -y install ${AIRGLOW_POSTINSTALL_FLATPAK_LIST}

