#!/usr/bin/env bash
# Convertible hinge and lid handling, driven by the switch binds in
# hyprland/convertible.lua.
#
# usage: tablet-mode.sh {on|off|reset|lid-close|lid-open}

set -uo pipefail

HERE="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
ROTATION="$HERE/rotation.sh"
OSK="$HERE/osk.sh"

# Hyprland lowercases device names and turns spaces into hyphens, so these do
# not look like the names in /proc/bus/input/devices. `hyprctl devices` prints
# the form used here.
TOUCHPAD="elan06fa:00-04f3:327e-touchpad"
KEYBOARD="at-translated-set-2-keyboard"

# The firmware already stops the folded keyboard from sending keys on most
# Yogas. Set this to 1 if yours does not.
DISABLE_KEYBOARD=0

RUNTIME="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
LOCK_FILE="$RUNTIME/hypr-tablet-mode.lock"
LAST_FILE="$RUNTIME/hypr-tablet-mode.last"
DEBOUNCE_SECONDS=1

# The hinge switch bounces hard: folding this machine once fires the on and
# off events dozens of times over a couple of seconds. Without this, every
# bounce spawns a fresh sensor watcher and they race each other. flock
# serialises overlapping runs, then the timestamp check drops any event that
# lands too soon after the last one that actually applied, which collapses a
# burst down to a single transition.
debounce_or_exit() {
    exec 9>"$LOCK_FILE"
    flock 9

    local last now
    last=$(cat "$LAST_FILE" 2>/dev/null || echo 0)
    now=$(date +%s)

    if (( now - last < DEBOUNCE_SECONDS )); then
        exit 0
    fi
    echo "$now" >"$LAST_FILE"

    # Release the lock before anything long lived starts. The sensor watcher
    # would otherwise inherit fd 9, hold the flock forever, and deadlock every
    # later run of this script.
    exec 9>&-
}

set_device() {
    hyprctl eval "hl.device({ name = '$1', enabled = $2 })" >/dev/null 2>&1
}

set_input_enabled() {
    local enabled=$1
    set_device "$TOUCHPAD" "$enabled"
    (( DISABLE_KEYBOARD )) && set_device "$KEYBOARD" "$enabled"
}

# Blank the panel only when it is the sole output. Closing the lid on a docked
# machine should leave the external monitor alone.
monitor_count() {
    hyprctl monitors -j 2>/dev/null | grep -c '"name"' || echo 1
}

case "${1:-}" in
    on)
        debounce_or_exit
        "$ROTATION" watch
        "$OSK" start
        # No touchpad: with the lid folded back it is face down against
        # whatever the machine is resting on.
        set_input_enabled false
        ;;
    off)
        debounce_or_exit
        "$ROTATION" stop
        "$ROTATION" reset
        "$OSK" stop
        set_input_enabled true
        ;;
    reset)
        # Startup state. Switch binds only fire on a change, so a machine that
        # booted folded comes up here in laptop mode until you fold it once.
        "$ROTATION" stop
        "$ROTATION" reset
        "$OSK" stop
        set_input_enabled true
        ;;
    lid-close)
        if (( $(monitor_count) <= 1 )); then
            hyprctl dispatch 'hl.dsp.dpms({ action = "disable" })' >/dev/null 2>&1
        fi
        ;;
    lid-open)
        hyprctl dispatch 'hl.dsp.dpms({ action = "enable" })' >/dev/null 2>&1
        ;;
    *)
        echo "usage: $0 {on|off|reset|lid-close|lid-open}" >&2
        exit 1
        ;;
esac
