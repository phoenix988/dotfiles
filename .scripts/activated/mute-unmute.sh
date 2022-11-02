#!/bin/bash

status=$(amixer | grep -i playback | grep  "^  Front" | awk '{print $NF}' | sed -e 's/\[/ /g' -e 's/\]//g')

status=$(printf '%s\n' ${status[@]} | uniq)

[ "$status" = "on" ] && amixer set Master mute || amixer set Master unmute
