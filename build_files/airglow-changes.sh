#!/usr/bin/bash

set -ouex pipefail

### Airglow config changes to KDE Plasma

# Set taskbar icons
sed -i '/<entry name="launchers" type="StringList">/,/<\/entry>/ s/<default>[^<]*<\/default>/<default>preferred:\/\/filemanager,preferred:\/\/browser,applications:dev.vencord.Vesktop.desktop,applications:org.gnome.Ptyxis.desktop,applications:org.kde.discover.desktop<\/default>/' /usr/share/plasma/plasmoids/org.kde.plasma.taskmanager/contents/config/main.xml
# Set kickoff menu icons
#sed -i '/<entry name="favorites" type="StringList">/,/<\/entry>/ s/<default>[^<]*<\/default>/<default>preferred:\/\/browser,systemsettings.desktop,org.kde.dolphin.desktop,org.kde.kate.desktop,org.gnome.Ptyxis.desktop,org.kde.discover.desktop<\/default>/' /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/config/main.xml
# Set icon theme
sed -i '/\[Icons\]/,// s/^Theme=.*/Theme=Papirus-Dark/' /usr/share/kde-settings/kde-profile/default/share/config/kdeglobals
