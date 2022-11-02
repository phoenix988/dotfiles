#!/usr/bin/fish
#
#
#

set update ( pacman -S htop --noconfirm )



if [ $status != "0" ] ;  
    echo $update | mutt -b karlfredin@gmail.com 
else
    echo $update
end
