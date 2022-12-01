#!/bin/bash

blueman-manager

wid=$(wmctrl -l | grep -i blue | awk '{print $1}' )


wmctrl -ic $wid
