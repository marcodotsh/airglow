#!/usr/bin/bash

set -ouex pipefail

### Airglow config changes to KDE Plasma

LAYOUT_JS="/usr/share/plasma/look-and-feel/dev.getaurora.aurora.desktop/contents/layouts/org.kde.plasma.desktop-layout.js"

# Change icons only task manager defaults
sed -i '/widget.writeConfig("launchers"/,/widget.reloadConfig()/ {
    /widget.reloadConfig()/i\
            widget.writeConfig("showOnlyCurrentDesktop", "false");\
            widget.writeConfig("wheelEnabled", "false");
}' "$LAYOUT_JS"

# Set taskbar icons
sed -i '/widget.writeConfig("launchers", \[/,/\]);/{
    /widget.writeConfig("launchers", \[/,/\]);/c\
            widget.writeConfig("launchers", [\
                "preferred://filemanager",\
                "preferred://browser",\
                "applications:dev.vencord.Vesktop.desktop",\
                "applications:org.gnome.Ptyxis.desktop",\
                "applications:io.github.kolunmi.Bazaar.desktop"\
            ]);
}' "$LAYOUT_JS"

# Configure pager defaults
cat >> "$LAYOUT_JS" << 'PAGER_CONFIG'

for (let i = 0; i < allPanels.length; ++i) {
    const panel = allPanels[i];
    const widgets = panel.widgets();

    for (let j = 0; j < widgets.length; ++j) {
        const widget = widgets[j];

        if (widget.type === "org.kde.plasma.pager") {
            widget.currentConfigGroup = ["General"];
            widget.writeConfig("displayedText", "0");
            widget.writeConfig("showWindowIcons", "true");
            widget.writeConfig("showOnlyCurrentScreen", "true");
            widget.writeConfig("wrapPage", "true");
            widget.reloadConfig();
        }
    }
}
PAGER_CONFIG

# Set icon theme
sed -i '/\[Icons\]/,// s/^Theme=.*/Theme=Papirus-Dark/' /usr/share/kde-settings/kde-profile/default/share/config/kdeglobals
sed -i '/\Icon Theme\]/,// s/^Inherits=.*/Inherits=breeze_cursors,Papirus-Dark/' /usr/share/icons/default/index.theme
sed -i '/\[Icons\]/,// s/^Theme=.*/Theme=Papirus-Dark/' /usr/share/plasma/look-and-feel/dev.getaurora.aurora.desktop/contents/defaults

# Change window title default settings
sed -i '/<entry name="altTxt"/,/<\/entry>/ s/<default>[^<]*<\/default>/<default><\/default>/' /usr/share/plasma/plasmoids/org.kde.windowtitle/contents/config/main.xml
sed -i '/<entry name="txt"/,/<\/entry>/ s/<default>[^<]*<\/default>/<default><\/default>/' /usr/share/plasma/plasmoids/org.kde.windowtitle/contents/config/main.xml
sed -i '/<entry name="txtSameFound"/,/<\/entry>/ s/<default>[^<]*<\/default>/<default><\/default>/' /usr/share/plasma/plasmoids/org.kde.windowtitle/contents/config/main.xml
sed -i '/<entry name="maxminAllowed"/,/<\/entry>/ s/<default>[^<]*<\/default>/<default>false<\/default>/' /usr/share/plasma/plasmoids/org.kde.windowtitle/contents/config/main.xml
sed -i '/<entry name="closeAllowed"/,/<\/entry>/ s/<default>[^<]*<\/default>/<default>false<\/default>/' /usr/share/plasma/plasmoids/org.kde.windowtitle/contents/config/main.xml
sed -i '/<entry name="scrollAllowed"/,/<\/entry>/ s/<default>[^<]*<\/default>/<default>false<\/default>/' /usr/share/plasma/plasmoids/org.kde.windowtitle/contents/config/main.xml

# Add to ujust airglow entries
echo 'import "/usr/share/ublue-os/just/80-airglow.just"' >> /usr/share/ublue-os/justfile
