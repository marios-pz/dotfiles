#!/usr/bin/bash

pacman -Qqen | awk '{print "  - " $0}' | sed '1i\
pacman_list:' >packages.yaml
