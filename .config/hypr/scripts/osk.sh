#!/usr/bin/env bash
# On screen keyboard, wrapping wvkbd.
#
# In tablet mode the keyboard runs with --auto, so it rises when a text field
# takes focus and drops when it loses it. `toggle` forces it up over apps that
# never report text focus, XWayland ones in particular.
#
# usage: osk.sh {start|stop|toggle}

set -uo pipefail

OSK=wvkbd-mobintl

# Keep these in step with oskHeight and oskLandscape in variables.lua.
HEIGHT=340
LANDSCAPE_HEIGHT=260

running() {
    pgrep -x "$OSK" >/dev/null
}

start() {
    running && return 0

    # Started hidden: --auto brings it up on the first text field rather than
    # covering a third of the screen the moment you fold the lid.
    "$OSK" \
        --hidden \
        --auto \
        -H "$HEIGHT" \
        -L "$LANDSCAPE_HEIGHT" \
        -R 12 \
        --fn "Rubik 16" \
        >/dev/null 2>&1 &
    disown
}

stop() {
    pkill -x "$OSK" 2>/dev/null || true
}

case "${1:-}" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    toggle)
        if running; then
            # wvkbd toggles its own visibility on SIGRTMIN, which leaves it
            # resident and instant rather than respawning it every time.
            pkill -RTMIN -x "$OSK"
        else
            start
            # Give it a moment to bind its layer surface before asking it to
            # show, otherwise the signal lands before the window exists.
            sleep 0.3
            pkill -RTMIN -x "$OSK" 2>/dev/null || true
        fi
        ;;
    *)
        echo "usage: $0 {start|stop|toggle}" >&2
        exit 1
        ;;
esac
