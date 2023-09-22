#! /usr/bin/bash

if [[ $# -lt 1 ]] || [[ ! -d $1 ]]; then
	echo "Usage:
	$0 <dir containing images>"
	exit 1
fi

swww init

# Edit below to control the images transition
export SWWW_TRANSITION_FPS=60
export SWWW_TRANSITION_STEP=12

# This controls (in seconds) when to switch to the next image
INTERVAL=1800 # every 30 minutes

while true; do
	# Get a random image file from the directory
	img=$(ls "$1" | shuf -n 1)

	# Check if the image file exists
	if [ -f "$1/$img" ]; then
		# Use the image with the "swww" command
		swww img "$1/$img"
	else
		echo "$1/$img Image file not found: $img"
	fi

	# Sleep for some time before picking another random image
	sleep "$INTERVAL" # Adjust the time interval as needed
done
