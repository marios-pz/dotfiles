#!/usr/bin/env bash
# Called by noctalia after wallpaper+color generation: $1=path $2=mode(dark/light)

WALLPAPER="$1"
MODE="${2:-dark}"

CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/matugen"
mkdir -p "$CACHE_DIR"
echo "$WALLPAPER" > "$CACHE_DIR/last-wallpaper"
echo "$MODE"      > "$CACHE_DIR/mode"

matugen image "$WALLPAPER" --mode "$MODE" --prefer saturation

niri msg action reload-config 2>/dev/null || true
