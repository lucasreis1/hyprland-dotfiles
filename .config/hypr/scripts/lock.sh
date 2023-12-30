#/bin/bash

WALLPAPER_DIR=~/Pictures/wallpapers/blurred

IMG=$(ls $WALLPAPER_DIR/*.png | shuf | head -n 1)
swaylock -f -i $IMG
