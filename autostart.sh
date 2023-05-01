#!/usr/bin/env bash 
# 
# Using bash in the shebang rather than /bin/sh, which should
# be avoided as non-POSIX shell users (fish) may experience errors.
#lxsession &
/usr/lib/polkit-kde-authentication-agent-1 &

#Compositor
picom -b --config  $HOME/.config/picom/picom.conf

#Set Display layout
#$HOME/.screenlayout/layout.sh &
emacs --daemon &

#Set wallpaper
~/.fehbg &
#feh --randomize --bg-fill /home/karl/Pictures/Wallpapers/* &

nm-applet &

ckb-next -b &
#xfce4-screensaver &
xfce4-power-manager &
volumeicon &
conky -c /home/karl/.config/conky/main &
flameshot &
steam -silent -no-browser &
discord &
lutris &
blueman-applet &
mullvad-vpn &



