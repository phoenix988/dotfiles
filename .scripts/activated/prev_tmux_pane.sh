#!/usr/bin/fish




set active (tmux list-pane | awk '/active/ {print $1 " " $NF}' | sed -e 's/(//g' -e 's/)//g' -e 's/://g'  ) 
set last_pane (tmux list-pane |  tail -n1 | awk '{print $1}' | sed 's/://g')



set choose ( echo $active | awk '{print $1}' )



set decision ( math $choose + 1 )


[ $choose = $last_pane ] && tmux select-pane -t 1



[ $choose != $last_pane ] && tmux select-pane -t $decision








