#!/usr/bin/env bash
# Flip light/dark mode without changing wallpaper

CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/matugen"
MODE_FILE="$CACHE_DIR/mode"
WALL_FILE="$CACHE_DIR/last-wallpaper"

current=$(cat "$MODE_FILE" 2>/dev/null || echo "dark")
[[ "$current" == "dark" ]] && new_mode="light" || new_mode="dark"

wallpaper=$(cat "$WALL_FILE" 2>/dev/null)
if [[ -z "$wallpaper" || ! -f "$wallpaper" ]]; then
    echo "No cached wallpaper found" >&2
    exit 1
fi

echo "$new_mode" > "$MODE_FILE"
matugen image "$wallpaper" --mode "$new_mode"

pkill -SIGUSR2 waybar    2>/dev/null || true
pkill -SIGRTMIN+8 waybar 2>/dev/null || true
pkill -USR1 kitty        2>/dev/null || true
