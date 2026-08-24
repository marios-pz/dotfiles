#!/usr/bin/env bash
# Toggles accelerometer-driven auto-rotation for convertible tablet mode.
# Invoked by niri's switch-events with "on" or "off" (see
# cfg/switch-events.kdl), or manually for testing.
#
# Requires: iio-sensor-proxy (extra).

set -uo pipefail

OUTPUT="eDP-1"

# The hinge switch can bounce (fire on/off repeatedly within milliseconds)
# when folding/unfolding, e.g. niri saw ~35 tablet-mode-on/off events in 8s
# here. Without debouncing, "on"/"off" spawn a fresh rotate watcher and race
# each other on every bounce. flock serializes overlapping runs; the time
# check then drops any on/off event that arrives too soon after the last
# one actually applied, collapsing a bounce burst into one.
RUNTIME_DIR="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
LOCK_FILE="$RUNTIME_DIR/niri-tablet-mode.lock"
LAST_FILE="$RUNTIME_DIR/niri-tablet-mode.last"
DEBOUNCE_SECONDS=1

debounce_or_exit() {
    exec 9>"$LOCK_FILE"
    flock 9

    last=$(cat "$LAST_FILE" 2>/dev/null || echo 0)
    now=$(date +%s)
    if (( now - last < DEBOUNCE_SECONDS )); then
        exit 0
    fi
    echo "$now" > "$LAST_FILE"

    # Release the lock now that the debounce bookkeeping is done. "on" goes
    # on to spawn a long-lived background process (the monitor-sensor
    # watcher); if fd 9 stayed open it would inherit it and hold the flock
    # forever, deadlocking every future invocation of this script on the
    # next flock 9.
    exec 9>&-
}

start_rotate_watcher() {
    pkill -f "monitor-sensor --accel" 2>/dev/null || true
    monitor-sensor --accel 2>/dev/null | while read -r line; do
        case "$line" in
            *"orientation changed: normal"*)    niri msg output "$OUTPUT" transform normal ;;
            *"orientation changed: bottom-up"*) niri msg output "$OUTPUT" transform 180 ;;
            # If left/right end up swapped on your hardware, flip these two.
            *"orientation changed: right-up"*)  niri msg output "$OUTPUT" transform 270 ;;
            *"orientation changed: left-up"*)   niri msg output "$OUTPUT" transform 90 ;;
        esac
    done &
    disown
}

stop_rotate_watcher() {
    pkill -f "monitor-sensor --accel" 2>/dev/null || true
}

case "${1:-}" in
    on)
        debounce_or_exit
        start_rotate_watcher
        ;;
    off)
        debounce_or_exit
        stop_rotate_watcher
        niri msg output "$OUTPUT" transform normal
        ;;
    *)
        echo "usage: $0 {on|off}" >&2
        exit 1
        ;;
esac
