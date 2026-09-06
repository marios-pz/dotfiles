#!/usr/bin/env bash
# Accelerometer driven screen rotation for the convertible.
#
# Started and stopped by tablet-mode.sh, and driven by hand from the Super+R
# and Super+Shift+R keybinds. Requires iio-sensor-proxy for monitor-sensor.
#
# usage: rotation.sh {watch|stop|lock|step|reset|apply <0-3>}

set -uo pipefail

# Keep these in step with internalMonitor and internalScale in variables.lua.
MONITOR="eDP-1"
SCALE=1

RUNTIME="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
LOCK_FLAG="$RUNTIME/hypr-rotation.locked"
STATE_FILE="$RUNTIME/hypr-rotation.transform"

notify() {
    command -v notify-send >/dev/null && notify-send -u low -a Hyprland "$1" || true
}

# Hyprland transforms: 0 normal, 1 is 90 degrees, 2 is 180, 3 is 270.
# If the screen ends up rotated the wrong way round on your panel, swap the
# right-up and left-up lines.
orientation_to_transform() {
    case "$1" in
        normal)    echo 0 ;;
        bottom-up) echo 2 ;;
        right-up)  echo 3 ;;
        left-up)   echo 1 ;;
        *)         return 1 ;;
    esac
}

# `hyprctl eval` runs Lua against the live compositor, which is the supported
# way to change config at runtime now that the config itself is Lua.
apply() {
    local transform=$1
    hyprctl eval "hl.monitor({ output = '$MONITOR', mode = 'preferred', position = 'auto', scale = $SCALE, transform = $transform })" >/dev/null 2>&1
    echo "$transform" >"$STATE_FILE"
}

current_transform() {
    cat "$STATE_FILE" 2>/dev/null || echo 0
}

stop_watcher() {
    pkill -f "monitor-sensor --accel" 2>/dev/null || true
}

start_watcher() {
    # Never leave two watchers fighting over the same output.
    stop_watcher

    monitor-sensor --accel 2>/dev/null | while read -r line; do
        # A locked rotation still keeps the watcher alive, so unlocking picks
        # the orientation back up on the next sensor event instead of needing
        # a fold to restart it.
        [[ -e "$LOCK_FLAG" ]] && continue

        case "$line" in
            *"orientation changed: "*)
                orientation="${line##*orientation changed: }"
                if transform=$(orientation_to_transform "$orientation"); then
                    apply "$transform"
                fi
                ;;
        esac
    done &
    disown
}

case "${1:-}" in
    watch)
        start_watcher
        ;;
    stop)
        stop_watcher
        ;;
    lock)
        if [[ -e "$LOCK_FLAG" ]]; then
            rm -f "$LOCK_FLAG"
            notify "Auto rotation on"
        else
            touch "$LOCK_FLAG"
            notify "Auto rotation locked"
        fi
        ;;
    step)
        # Rotating by hand only makes sense with the sensor held off,
        # otherwise the next reading undoes it immediately.
        touch "$LOCK_FLAG"
        apply "$(( ($(current_transform) + 1) % 4 ))"
        ;;
    reset)
        apply 0
        ;;
    apply)
        apply "${2:?usage: rotation.sh apply <0-3>}"
        ;;
    *)
        echo "usage: $0 {watch|stop|lock|step|reset|apply <0-3>}" >&2
        exit 1
        ;;
esac
