#!/bin/fish
set check_ps (ps aux | awk '/mbsync/ {print $11}' | head -n1)
set mymail 'karlfredin@gmail.com'

[ -z $check_ps ] && mbsync -H $mymail ; mbsync -L $mymail ; mbsync -d $mymail 
