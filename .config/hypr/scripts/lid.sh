#!/usr/bin/env bash
# Lid handling, driven by the switch binds in hyprland/lid.lua.
#
# usage: lid.sh {close|open}

set -uo pipefail

# Blank the panel only when it is the sole output. Closing the lid on a docked
# machine should leave the external monitor alone.
monitor_count() {
    hyprctl monitors -j 2>/dev/null | grep -c '"name"' || echo 1
}

case "${1:-}" in
    close)
        if (( $(monitor_count) <= 1 )); then
            hyprctl dispatch 'hl.dsp.dpms({ action = "disable" })' >/dev/null 2>&1
        fi
        ;;
    open)
        hyprctl dispatch 'hl.dsp.dpms({ action = "enable" })' >/dev/null 2>&1
        ;;
    *)
        echo "usage: $0 {close|open}" >&2
        exit 1
        ;;
esac
