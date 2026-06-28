#!/usr/bin/env bash
# Called by noctalia when dark mode toggles: $1=true(dark) or false(light)

IS_DARK="$1"
[[ "$IS_DARK" == "true" ]] && MODE="dark" || MODE="light"

CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/matugen"
WALLPAPER=$(cat "$CACHE_DIR/last-wallpaper" 2>/dev/null)

if [[ -z "$WALLPAPER" || ! -f "$WALLPAPER" ]]; then
    exit 0
fi

echo "$MODE" > "$CACHE_DIR/mode"
matugen image "$WALLPAPER" --mode "$MODE" --prefer saturation

niri msg action reload-config 2>/dev/null || true
