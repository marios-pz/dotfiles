#!/usr/bin/env bash
# wallpaper.sh — set wallpaper and regenerate theme via matugen
# Usage: wallpaper.sh [path/to/image]   (omit to pick a random one)

set -euo pipefail

WALLPAPERS_DIR="${WALLPAPERS_DIR:-$HOME/Pictures/Wallpapers}"

if [[ $# -ge 1 && -f "$1" ]]; then
    WALLPAPER="$1"
else
    WALLPAPER=$(find "$WALLPAPERS_DIR" -type f \
        \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
        | shuf -n 1)
fi

[[ -z "$WALLPAPER" ]] && { echo "No wallpaper found in $WALLPAPERS_DIR"; exit 1; }

# Detect light or dark based on average luminance (requires imagemagick)
detect_mode() {
    if command -v magick &>/dev/null; then
        local lum
        lum=$(magick "$WALLPAPER" -colorspace Gray -format "%[fx:mean]" info: 2>/dev/null || echo "0")
        if (( $(echo "$lum > 0.5" | bc -l 2>/dev/null || echo 0) )); then
            echo "light"
            return
        fi
    fi
    echo "dark"
}

MODE=$(detect_mode)

CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/matugen"
mkdir -p "$CACHE_DIR"
echo "$WALLPAPER" > "$CACHE_DIR/last-wallpaper"
echo "$MODE"      > "$CACHE_DIR/mode"

# Set wallpaper
swww img "$WALLPAPER" \
    --transition-type wipe \
    --transition-angle 30 \
    --transition-duration 1 \
    --transition-fps 60

# Generate theme from wallpaper using matugen templates
matugen image "$WALLPAPER" --mode "$MODE" --prefer saturation

# Alacritty picks up colors.toml on next window open (live_config_reload covers main config only)

echo "wallpaper: $(basename "$WALLPAPER") [$MODE]"
