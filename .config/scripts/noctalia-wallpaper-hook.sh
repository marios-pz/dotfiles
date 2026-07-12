#!/usr/bin/env bash
# Called by noctalia v5's wallpaper_changed hook: reads $NOCTALIA_WALLPAPER_PATH
# Regenerates the matugen theme (bar, niri, starship, etc.) from the new wallpaper.

WALLPAPER="$NOCTALIA_WALLPAPER_PATH"
[[ -z "$WALLPAPER" ]] && exit 0

matugen image "$WALLPAPER" --prefer saturation

niri msg action reload-config 2>/dev/null || true
