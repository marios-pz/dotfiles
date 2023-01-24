#!/bin/bash

pipewire & wireplumber &
nitrogen ~/Pictures/Wallpapers --restore &
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
exec i3
