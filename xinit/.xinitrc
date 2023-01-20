#!/bin/bash

pipewire & wireplumber &

nitrogen ~/Pictures/Wallpapers --restore &

exec i3
