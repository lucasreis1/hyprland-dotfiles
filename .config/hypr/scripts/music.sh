#!/bin/bash

if ! hyprctl clients | grep music >/dev/null
then
  hyprctl dispatch -- exec $TERMINAL --class music -e ncspot &> /var/log/music.log
fi
