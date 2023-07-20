#!/usr/bin/bash
echo "pacman_list:" >packages.yaml

pacman -Q | awk '{printf "  - %s\n", $1}' >>packages.yaml
