#!/usr/bin/fish

#Gets a random backgroud from the directory you specify
set list_bg ( ll ~/Pictures/backgrounds/ | awk '{print $9}' | sed '/^$/d' | xargs shuf -e -n1  )



#Unlinks the wallpaper path if the link exist already
ls /usr/share/backgrounds/arcolinux/arco-wallpaper.jpg &> /dev/null && sudo unlink /usr/share/backgrounds/arcolinux/arco-wallpaper.jpg 

#Sets the symlink pointing to the random background choosen by the script
sudo ln -s ~/Pictures/backgrounds/$list_bg  /usr/share/backgrounds/arcolinux/arco-wallpaper.jpg



