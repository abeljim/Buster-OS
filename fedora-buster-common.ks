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
nautilus
gnome-screensaver
gnome-system-monitor
gnome-terminal
lightdm-gtk
xdg-user-dirs
xdg-user-dirs-gtk
xorg-x11-drv-libinput
plank

# Utilties
@networkmanager-submodules
@development-tools
@multimedia
@sound-and-video

# Software 
@libreoffice
vim
code 

# extra backgrounds
f29-backgrounds-extras-gnome

%end

%post 
cat >> /usr/share/glib-2.0/schemas/99_my_custom_settings.gschema.override << FOE
[org.gnome.desktop.interface]
gtk-theme='Adapta-Nokto-Eta'
icon-theme='Pop'
cursor-theme='Adwaita'
monospace-font-name='Fira Mono Medium 9'
font-name='Fira Sans 8.7998046875'
document-font-name='Sans 10'

[org.gnome.desktop.background]
picture-uri='file:///usr/share/backgrounds/f29/default/standard/f29.png'
FOE

glib-compile-schemas /usr/share/glib-2.0/schemas


cat >> /etc/rc.d/init.d/livesys << EOF
# Show harddisk install on the desktop
sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
mkdir /home/liveuser/Desktop
cp /usr/share/applications/liveinst.desktop /home/liveuser/Desktop

# and mark it as executable
chmod +x /home/liveuser/Desktop/liveinst.desktop

# this goes at the end after all other changes. 
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser

EOF

%end