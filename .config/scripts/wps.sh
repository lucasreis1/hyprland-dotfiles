#!/bin/bash
# get modulus of index based on array size
get_index_mod_array() {
  INDEX=$1
  ARRAY=("${@:2}")

  SIZE=${#ARRAY[@]}

  echo $(( $INDEX % $SIZE ))
}

if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
  COMMAND="wpg -ns"
else
  COMMAND="wpg -s"
fi

DIR=$HOME/.config/wallpapers

if [ $# -eq 0 ]
then # select wallpaper from list
  SELECTED_WALL=$(wpg -l | fzf)
else # the wallpaper is passed as argument
  SELECTED_WALL=$1
  if ! test -f "${DIR}/$SELECTED_WALL"; then
    >&2 echo "file does not exist"
    exit 1
  fi
fi

$COMMAND $SELECTED_WALL && sleep 0.1


if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
  # wallpaper dir
  DIR=$HOME/.config/wallpapers
  EXTENSION="${SELECTED_WALL##*.}"
  # for gifs, replace fframe with the gif.
  # also, remember they are stored in the subfolder "animated"
  if [[ "$EXTENSION" =~ fframe.*$ ]]; then
    SELECTED_WALL=${SELECTED_WALL%.*}.gif
    DIR=${DIR}/animated
  fi

  # for multiple montiors, cycle through wallpapers and outputs
  if [[ "$SELECTED_WALL" =~ .*Pt-[0-9]+.* ]]
  then
    WALLS=( $(ls "${DIR}/${SELECTED_WALL%Pt*}"*) )
    mapfile -t OUTPUTS < <(swww query | cut -d':' -f1)
    
    for i in "${!OUTPUTS[@]}"
    do
      WALL_MOD=$(get_index_mod_array $i "${WALLS[@]}")
      SELECTED_WALL="${WALLS[$WALL_MOD]}"
      OUTPUT=${OUTPUTS[$i]}

      swww img -o $OUTPUT -t grow ${SELECTED_WALL}
    done
  else
    swww img -t grow ${DIR}/${SELECTED_WALL}
  fi

  ~/.config/hypr/scripts/fix_colors.sh
fi
