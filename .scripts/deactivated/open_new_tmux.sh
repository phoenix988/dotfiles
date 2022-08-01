#!/usr/bin/fish

set tmuxsession ( tmux ls | awk '{print $1}' | cut -d ":" -f 1 )


if [ $tmuxsession = "0" ] 


    tmux attach

else 

    tmux 

end
