#!/bin/bash

# fix colors for hyprland
COLORS_FILE="$HOME/.config/hypr/colors.conf"
sed -i 's@#@@g' $COLORS_FILE

# reload config for notification client
swaync-client -rs
