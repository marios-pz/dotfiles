#!/bin/bash

OUTPUT_FILE="$HOME/dotfiles/ansible/variables/packages.yaml"
TEMP_FILE="$HOME/dotfiles/ansible/variables/packages.tmp"

{
    echo "packages:"
    pacman -Qq | sed 's/^/  - /'
} > "$TEMP_FILE"

if [ $? -eq 0 ]; then
    mv "$TEMP_FILE" "$OUTPUT_FILE"
    echo "Packages have been written to $OUTPUT_FILE"
else
    echo "Failed to generate package list."
    rm -f "$TEMP_FILE"
    exit 1
fi
