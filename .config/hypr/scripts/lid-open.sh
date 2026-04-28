#!/usr/bin/env bash

LAPTOP_MON="eDP-1"

hyprctl keyword monitor "$LAPTOP_MON,preferred,auto,1"

# Give Hyprland a moment to register the monitor before sending DPMS on
sleep 1
hyprctl dispatch dpms on "$LAPTOP_MON"
