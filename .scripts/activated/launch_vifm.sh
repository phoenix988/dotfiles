#!/usr/bin/fish


set sessionname "vifm"

tmux has-session -t $sessionname &> /dev/null


if [ $status != 0 ]
   
    tmux new-session -s $sessionname -n vifm -d 

    tmux send-keys -t $sessionname:vifm 'vifmrun'  C-m
 end


 tmux attach -t $sessionname
 


   tmux send-keys -t $sessionname:vifm  'xdotool key Super_L+Shift_L+8' C-m
