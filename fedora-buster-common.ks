# fedora-buster-common.ks
#
# Description:
# - Fedora package set for the Buster Desktop Environment
#
# Maintainer(s):
# - Abel Jimenez

%packages

# desktop enviroment 
budgie-desktop
lightdm-gtk
nautilus
gnome-screensaver
gnome-system-monitor
gnome-terminal
xdg-user-dirs
xdg-user-dirs-gtk
xorg-x11-drv-libinput
plank

# lightdm



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
    
    touch ~/first_login_setup_done
fi
EOF
chmod a+x /etc/profile.d/first_login_setup.sh


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
background-transparency-percent=6
scrollback-unlimited=true
use-transparent-background=true
scrollbar-policy='never'

FOE

# lightdm theme 
cat >> /etc/lightdm/lightdm-gtk-greeter.conf << FOE
[greeter]
background = /usr/share/backgrounds/f29/default/standard/f29.png
font-name = Cantarell 9
theme-nam = Arc-Darker
icon-theme-name = Arc
xft-hintstyle = hintfull
theme-name = Arc-Darker
xft-dpi = 96
xft-antialias = true
xft-rgba = rgb
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