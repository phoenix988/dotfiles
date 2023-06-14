#!/usr/bin/env bash
# add custom autostart items

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

run "picom -b --config $HOME/.config/picom/picom-jona.conf"
