#!/bin/bash

pipewire & wireplumber &
nitrogen ~/Pictures/Wallpapers --restore &
picom &
exec i3
