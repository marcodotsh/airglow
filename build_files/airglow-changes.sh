#!/usr/bin/bash

set -ouex pipefail

### Airglow config changes to KDE Plasma

# Set taskbar icons
sed -i '/<entry name="launchers" type="StringList">/,/<\/entry>/ s/<default>[^<]*<\/default>/<default>preferred:\/\/filemanager,preferred:\/\/browser,applications:dev.vencord.Vesktop.desktop,applications:org.gnome.Ptyxis.desktop,applications:org.kde.discover.desktop<\/default>/' /usr/share/plasma/plasmoids/org.kde.plasma.taskmanager/contents/config/main.xml
# Set kickoff menu icons
#sed -i '/<entry name="favorites" type="StringList">/,/<\/entry>/ s/<default>[^<]*<\/default>/<default>preferred:\/\/browser,systemsettings.desktop,org.kde.dolphin.desktop,org.kde.kate.desktop,org.gnome.Ptyxis.desktop,org.kde.discover.desktop<\/default>/' /usr/share/plasma/plasmoids/org.kde.plasma.kickoff/contents/config/main.xml
# Set icon theme
sed -i '/\[Icons\]/,// s/^Theme=.*/Theme=Papirus-Dark/' /usr/share/kde-settings/kde-profile/default/share/config/kdeglobals
sed -i '/\Icon Theme\]/,// s/^Inherits=.*/Inherits=breeze_cursors,Papirus-Dark/' /usr/share/icons/default/index.theme
sed -i '/\[Icons\]/,// s/^Theme=.*/Theme=Papirus-Dark/' /usr/share/plasma/look-and-feel/dev.getaurora.aurora.desktop/contents/defaults

# Change pager default settings
sed -i '/<entry name="displayedText" type="Enum">/,/<\/entry>/ s/<default>[^<]*<\/default>/<default>0<\/default>/' /usr/share/plasma/plasmoids/org.kde.plasma.pager/contents/config/main.xml
sed -i '/<entry name="showWindowIcons" type="Bool">/,/<\/entry>/ s/<default>[^<]*<\/default>/<default>true<\/default>/' /usr/share/plasma/plasmoids/org.kde.plasma.pager/contents/config/main.xml
sed -i '/<entry name="showOnlyCurrentScreen" type="Bool">/,/<\/entry>/ s/<default>[^<]*<\/default>/<default>true<\/default>/' /usr/share/plasma/plasmoids/org.kde.plasma.pager/contents/config/main.xml
sed -i '/<entry name="wrapPage" type="Bool">/,/<\/entry>/ s/<default>[^<]*<\/default>/<default>true<\/default>/' /usr/share/plasma/plasmoids/org.kde.plasma.pager/contents/config/main.xml

# Change window title default settings
sed -i '/<entry name="altTxt"/,/<\/entry>/ s/<default>[^<]*<\/default>/<default><\/default>/' /usr/share/plasma/plasmoids/org.kde.windowtitle/contents/config/main.xml
sed -i '/<entry name="txt"/,/<\/entry>/ s/<default>[^<]*<\/default>/<default><\/default>/' /usr/share/plasma/plasmoids/org.kde.windowtitle/contents/config/main.xml
sed -i '/<entry name="txtSameFound"/,/<\/entry>/ s/<default>[^<]*<\/default>/<default><\/default>/' /usr/share/plasma/plasmoids/org.kde.windowtitle/contents/config/main.xml
sed -i '/<entry name="maxminAllowed"/,/<\/entry>/ s/<default>[^<]*<\/default>/<default>false<\/default>/' /usr/share/plasma/plasmoids/org.kde.windowtitle/contents/config/main.xml
sed -i '/<entry name="closeAllowed"/,/<\/entry>/ s/<default>[^<]*<\/default>/<default>false<\/default>/' /usr/share/plasma/plasmoids/org.kde.windowtitle/contents/config/main.xml
sed -i '/<entry name="scrollAllowed"/,/<\/entry>/ s/<default>[^<]*<\/default>/<default>false<\/default>/' /usr/share/plasma/plasmoids/org.kde.windowtitle/contents/config/main.xml

# Change icons only task manager default settings
sed -i '/<entry name="showOnlyCurrentDesktop"/,/<\/entry>/ s/<default>[^<]*<\/default>/<default>false<\/default>/' /usr/share/plasma/plasmoids/org.kde.plasma.taskmanager/contents/config/main.xml
sed -i '/<entry name="wheelEnabled"/,/<\/entry>/ s/<default>[^<]*<\/default>/<default>false<\/default>/' /usr/share/plasma/plasmoids/org.kde.plasma.taskmanager/contents/config/main.xml
