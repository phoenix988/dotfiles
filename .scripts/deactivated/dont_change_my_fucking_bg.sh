#!/usr/bin/fish

#Gets a random backgroud from the directory you specify
set list_bg ( ls /home/karl/Pictures/backgrounds/animegirl5.jpg  )


set check_empty_bg ( ll /usr/share/backgrounds/arcolinux/ | grep /home/karl/Pictures/backgrounds/ | grep 'jpg$') 

[ -z $check_empty_bg ] && ln -s /home/karl/Pictures/backgrounds/animegirl5.jpg  /usr/share/backgrounds/arcolinux/arco-wallpaper.jpg



