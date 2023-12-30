#!/usr/bin/env sh
WALL_DIR=~/.config/wallpapers

HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==2{print $2}')
if [ "$HYPRGAMEMODE" = 1 ] ; then
    hyprctl --batch "\
        keyword animations:enabled 0;\
        keyword decoration:drop_shadow 0;\
        keyword decoration:blur:enabled 0;\
        keyword general:gaps_in 0;\
        keyword general:gaps_out 0;\
        keyword general:border_size 0;\
        keyword decoration:rounding 0"
        # set static wallpaper
        swww img -t none ${WALL_DIR}/$(wpg -c)
    exit
fi

# restore wallpaper
~/.config/scripts/wps.sh $(wpg -c)
hyprctl reload
