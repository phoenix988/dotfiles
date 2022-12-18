#!/usr/bin/fish

#Gets a random backgroud from the directory you specify
set list_bg ( ls $HOME/Pictures/backgrounds/animegirl5.jpg  )


set check_empty_bg ( ll /usr/share/backgrounds/arcolinux/ | grep $HOME/Pictures/backgrounds/ | grep 'jpg$') 

[ -z $check_empty_bg ] && ln -s $HOME/Pictures/backgrounds/animegirl5.jpg  /usr/share/backgrounds/arcolinux/arco-wallpaper.jpg



