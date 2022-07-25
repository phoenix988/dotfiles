#!/bin/bash


harddrive_to_use=""
editor_of_choice=vim

#Here you can point to a file of packages that you want to install
packages_to_install=""

[ -z $harddrive_to_use ] && exit


timedatectil set-ntp true 


mount $harddrive_to_use /mnt


pacstrap /mnt base linux linux-firmware 


genfstab -U /mnt >> /mnt/etc/fstab
  

arch-chroot /mnt


echo packages_to_install | xargs pacman -S 


