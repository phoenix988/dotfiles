#!/bin/bash

back=$(cat ~/.config/kitty/theme.conf | grep background | awk '{print $NF}')
fore=$(cat ~/.config/kitty/theme.conf | grep selection_background | awk '{print $NF}')

 sed -n '/Keyboard shortcuts/,/End Keyboard shortcut/p' ~/.config/kitty/kitty.conf | \
       grep -v ^# | \
       grep -v clear | \
       sed  '/^$/d' | \
       sed -e 's/map/map\t/' \
           -e 's/map/\n/' \
           -e 's/^*//g' \
           -e 's/^[ \t]*//' | \
           sed -e 's/tab::/\t/g'  | \
           yad --text-info  --back=$back --fore=$fore --geometry=1200x800
 


