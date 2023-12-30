#/bin/bash

swayidle -w \
  timeout 300 ~/.config/hypr/scripts/lock.sh \
  timeout 600 'hyprctl dispatch dpms off' \
  before-sleep ~/.config/hypr/scripts/lock.sh
