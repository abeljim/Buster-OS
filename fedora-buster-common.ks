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
#lightdm-webkit2-greeter


#  Basic Utilties
@networkmanager-submodules
@development-tools
@multimedia
@sound-and-video
@libreoffice

# Software 
code 
gimp
deluge 
kdenlive

# Machine learning 
conda 

# Browser 
chromium
chromium-libs-media-freeworld

# cli
vim
zsh 
zsh-syntax-highlighting

# plymouth
plymouth-plugin-script
buster_plymouth

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

# remove extra desktop enviroment
rm -rf /usr/bin/openbox-session
rm -rf /usr/bin/cinnamon*

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

FOE

glib-compile-schemas /usr/share/glib-2.0/schemas

# add theme for plymouth
cat >> /etc/plymouth/plymouthd.conf << FOE
ShowDelay=0
FOE
plymouth-set-default-theme buster -R

# setup lightdm webkit
sed -i -e 's/#user-session=default/user-session=budgie-desktop/' /etc/lightdm/lightdm.conf
# sed -i -e 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-webkit2-greeter/' /etc/lightdm/lightdm.conf
# sed -i -e 's/#logind-check-graphical=false/logind-check-graphical=true/' /etc/lightdm/lightdm.conf
# sed -i -e 's/debug_mode          = false/debug_mode          = true' /etc/lightdm/lightdm-webkit2-greeter.conf


cat >> /etc/rc.d/init.d/livesys << EOF
# Show harddisk install on the desktop
sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop
# mkdir -p /home/liveuser/Desktop
# cp /usr/share/applications/liveinst.desktop /home/liveuser/Desktop

# and mark it as executable
chmod +x /home/liveuser/Desktop/liveinst.desktop

# this goes at the end after all other changes. 
chown -R liveuser:liveuser /home/liveuser
restorecon -R /home/liveuser

EOF

%end

%post --nochroot --log=/mnt/sysimage/root/ks-post-no-root.log
cp -vr /builddir/fedora-kickstarts/user_file /mnt/sysimage/usr/share/
chmod -R a+r+x /mnt/sysimage/usr/share/user_file
%end