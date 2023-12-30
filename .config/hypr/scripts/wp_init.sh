#!/bin/bash

WALLPAPER_SCRIPT=~/.config/scripts/wps.sh

# get a random wallpaper from the animated ones
if [ $# -eq 1 ] && [ "$1" == "-r" ]; then
  SELECTED_WALL=$(wpg -l | grep fframe.png | shuf | head -n 1)
else
  SELECTED_WALL=$(wpg -c)
fi

sleep 0.5
sh ~/.config/wpg/wp_init.sh

$WALLPAPER_SCRIPT $SELECTED_WALL
