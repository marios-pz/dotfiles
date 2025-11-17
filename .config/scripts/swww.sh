#!/usr/bin/env bash

#start swww
WALLPAPERS_DIR=~/Pictures/Wallpapers/
WALLPAPER=$(find "$WALLPAPERS_DIR" -type f | shuf -n 1)
swww img "$WALLPAPER"
