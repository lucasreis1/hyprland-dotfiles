#!/bin/bash

# change output from mirror to side-by-side screens

left="DP-2"
right="DP-3"

move_workspaces() {
  hyprctl dispatch moveworkspacetomonitor 1 $left
  hyprctl dispatch moveworkspacetomonitor 2 $left
  hyprctl dispatch moveworkspacetomonitor 3 $left
  hyprctl dispatch moveworkspacetomonitor 8 $left
  hyprctl dispatch moveworkspacetomonitor 9 $left
}

# we have two monitors, change to mirror mode
if [ "$(hyprctl monitors | grep "$left")" == "" ]
then
  hyprctl keyword monitor $left,1920x1080@165, 0x360, auto 
  move_workspaces
else
  hyprctl keyword monitor $left,1920x1080@165, auto, auto, mirror, $right 
  pkill start_waybar.sh 
  sleep 0.5 
  swww init 
  ~/.config/hypr/scripts/start_waybar.sh
fi
