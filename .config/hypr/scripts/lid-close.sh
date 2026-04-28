#!/bin/bash

sleep 1

LAPTOP_MON="eDP-1"

# Dynamically find the first connected external monitor (not the laptop screen)
EXTERNAL_MON=$(hyprctl monitors -j | jq -r ".[] | select(.name != \"$LAPTOP_MON\") | .name" | head -n1)

if [ -z "$EXTERNAL_MON" ]; then
    echo "No external monitor found, skipping workspace migration"
    exit 0
fi

# Move all workspaces from the laptop screen to the external monitor
WORKSPACES=$(hyprctl workspaces -j | jq -r ".[] | select(.monitor == \"$LAPTOP_MON\") | .id")

for ws in $WORKSPACES; do
    hyprctl dispatch moveworkspacetomonitor "$ws" "$EXTERNAL_MON"
done

# Wake up the external monitor just in case it's in DPMS sleep
hyprctl dispatch dpms on "$EXTERNAL_MON"

hyprctl keyword monitor "$LAPTOP_MON,disable"
