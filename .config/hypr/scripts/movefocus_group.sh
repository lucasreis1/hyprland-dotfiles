#!/bin/bash

get_index_of_array() {
  ITEM=$1
  ARRAY=("${@:2}")
  
  for i in ${!ARRAY[@]}; do
    if [[ "${ARRAY[$i]}" == "$ITEM" ]]; then
      echo $i
      exit
    fi
  done

  echo -1
}

DIRECTION=$1

GROUP=$(hyprctl -j activewindow | jq '.grouped[]')
ADDRESS=$(hyprctl -j activewindow | jq '.address')

if [ "$GROUP" == "" ]; then
  hyprctl dispatch movefocus $DIRECTION
else
  readarray -t GROUP <<<$GROUP

  LAST_INDEX=$(( ${#GROUP[@]} - 1 ))
  case $DIRECTION in
    "l")
      if [ "$(get_index_of_array $ADDRESS ${GROUP[@]})" == "0" ]; then
        hyprctl dispatch movefocus l 
      else
        hyprctl dispatch changegroupactive b 
      fi ;;
    "d") hyprctl dispatch changegroupactive b ;;
    "u") hyprctl dispatch changegroupactive f ;;
    "r") 
      if [ "$(get_index_of_array $ADDRESS ${GROUP[@]})" == "$LAST_INDEX" ]; then
        hyprctl dispatch movefocus r 
      else
        hyprctl dispatch changegroupactive f 
      fi ;;
  esac
fi
