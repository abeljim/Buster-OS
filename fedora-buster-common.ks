# fedora-buster-common.ks
#
# Description:
# - Fedora package set for the Buster Desktop Environment
#
# Maintainer(s):
# - Abel Jimenez

%packages

# RPM FUSION
rpmfusion-free-release
rpmfusion-nonfree-release

# desktop enviroment 
budgie-desktop
lightdm-gtk
nautilus
nautilus-python
gnome-screensaver
gnome-system-monitor
gnome-terminal
xdg-user-dirs
xdg-user-dirs-gtk
xorg-x11-drv-libinput
plank

# lightdm greeter 
slick-greeter


#  Basic Utilties
@networkmanager-submodules
@development-tools
@multimedia
@sound-and-video
@libreoffice

# Software 
code 

# Browser 
chromium
chromium-libs-media-freeworld
deluge 

# cli
vim

%end

%post --log=/root/ks-post.log

# first time user script
cat >> /etc/profile.d/first_login_setup.sh << 'EOF'
#!/bin/bash

if [ ! -f ~/first_login_setup_done ]; then
    cd /usr/share/user_file/
    
    bash theme/theme_setup.sh
    bash misc/misc_setup.sh
    
    touch ~/first_login_setup_done
fi
EOF
chmod a+x /etc/profile.d/first_login_setup.sh

# add vs code to nautlius 
wget https://gist.githubusercontent.com/cra0zy/f8ec780e16201f81ccd5234856546414/raw/6e53c15ea4b18de077587e781dc95dc7f0582cc3/VSCodeExtension.py && mkdir -p ~/.local/share/nautilus-python/extensions && cp -f VSCodeExtension.py ~/.local/share/nautilus-python/extensions/VSCodeExtension.py && rm VSCodeExtension.py && nautilus -q

# theming for gnome based stuff
cat >> /usr/share/glib-2.0/schemas/99_my_custom_settings.gschema.override << FOE
[org.gnome.desktop.interface]
gtk-theme='Adapta-Nokto-Eta'
icon-theme='Pop'
cursor-theme='Adwaita'

[org.gnome.desktop.background]
picture-uri='file:///usr/share/backgrounds/f29/default/standard/f29.png'

[com.solus-project.budgie-panel]
builtin-theme=false

[org.gnome.desktop.peripherals.touchpad]
natural-scroll=false
edge-scrolling-enabled=true
tap-to-click=true

[org.gnome.Terminal.Legacy.Profile]
background-color='rgb(0,43,54)'
use-theme-colors=false
foreground-color='rgb(131,148,150)'
scrollback-unlimited=true
scrollbar-policy='never'

[net.launchpad.plank.docks.dock1]
icon-size=48
show-dock-item=false
position='bottom'
dock-items=['chromium-browser.dockitem']
unhide-delay=0
items-alignment='center'
theme='Matte'
hide-mode='intelligent'
pinned-only=false
auto-pinning=true
alignment='center'
hide-delay=0
monitor=''
lock-items=false
tooltips-enabled=true
pressure-reveal=false
offset=0
current-workspace-only=false


FOE

glib-compile-schemas /usr/share/glib-2.0/schemas

cat >> /etc/rc.d/init.d/livesys << EOF
# set up lightdm autologin
sed -i 's/^#autologin-user=.*/autologin-user=liveuser/' /etc/lightdm/lightdm.conf
sed -i 's/^#autologin-user-timeout=.*/autologin-user-timeout=0/' /etc/lightdm/lightdm.conf
sed -i 's/^#user-session=.*/user-session=budgie-desktop/' /etc/lightdm/lightdm.conf

# make the installer show up
sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop

chown -R liveuser:liveuser /home/liveuser

EOF

%end