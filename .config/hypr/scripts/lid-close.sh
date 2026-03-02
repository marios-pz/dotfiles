#!/bin/bash

sleep 1

LAPTOP_MON="eDP-1"
EXTERNAL_MON="HDMI-A-1"

WORKSPACES=$(hyprctl workspaces -j | jq -r ".[] | select(.monitor == \"$LAPTOP_MON\") | .id")

for ws in $WORKSPACES; do
    hyprctl dispatch moveworkspacetomonitor "$ws" "$EXTERNAL_MON"
done

hyprctl keyword monitor "$LAPTOP_MON,disable"
