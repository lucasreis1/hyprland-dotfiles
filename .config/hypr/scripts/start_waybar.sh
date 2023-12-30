#!/bin/bash

LOG="/var/log/waybar.log"

# start waybar if not started
if ! pgrep -x "waybar" > /dev/null; then
	waybar &>$LOG & 
fi

# current checksums
current_checksum_config=$(md5sum ~/.config/waybar/config)
current_checksum_style=$(md5sum ~/.config/waybar/style.css)
current_checksum_colors=$(md5sum ~/.config/waybar/colors.css)

# loop forever
while true; do
  sleep 2
	# new checksums
	new_checksum_config=$(md5sum ~/.config/waybar/config)
	new_checksum_style=$(md5sum ~/.config/waybar/style.css)
	new_checksum_colors=$(md5sum ~/.config/waybar/colors.css)

	# if checksums are different
	if [ "$current_checksum_config" != "$new_checksum_config" ] || [ "$current_checksum_style" != "$new_checksum_style" ] || [ "$current_checksum_colors" != "$new_checksum_colors" ] || ! pgrep -x "waybar" > /dev/null ; then
		# kill waybar
		killall waybar

		# start waybar
		waybar &>$LOG & 

		# update checksums
		current_checksum_config=$new_checksum_config
		current_checksum_style=$new_checksum_style
		current_checksum_colors=$new_checksum_colors
	fi
done
