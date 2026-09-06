local vars = require("variables")
local util = require("utils.functions")

-- Everything started once, at login. `hyprland.start` fires after the
-- compositor is up and the Wayland socket exists, so clients started here
-- never race the display.

hl.on("hyprland.start", function()
    ---- Session services ----

    -- Secrets for anything using libsecret, Slack and browsers included.
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")

    -- Graphical password prompts for anything asking for root.
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

    -- Clipboard history. `caelestia clipboard` is a viewer over cliphist, so
    -- without these two watchers the picker opens empty.
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

    -- Forward the bluetooth headset buttons to MPRIS.
    hl.exec_cmd("mpris-proxy")

    ---- Cursor ----

    -- XWayland and the compositor read XCURSOR_THEME and XCURSOR_SIZE, set
    -- in hyprland/env.lua. GTK ignores both and needs telling separately.
    hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme '" .. vars.cursorTheme .. "'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size " .. vars.cursorSize)

    ---- The shell ----

    -- Bar, launcher, notifications, lock screen and wallpaper. Starting this
    -- before the apps means their tray icons have somewhere to land.
    hl.exec_cmd("caelestia shell -d")

    ---- Apps ----

    -- The browser opens here on workspace 1. Slack and Discord are pulled to
    -- the comms workspace by the rules in hyprland/rules.lua, silently, so
    -- they cannot steal focus while they start.
    hl.exec_cmd(vars.browser)
    hl.exec_cmd(vars.discord)
    hl.exec_cmd(vars.slack)

    ---- Convertible ----

    -- Puts rotation, the touchpad and the on screen keyboard into a known
    -- laptop mode state. Switch binds only fire on a change, so a machine
    -- that booted folded stays in laptop mode until you fold it once.
    hl.exec_cmd(util.script("tablet-mode.sh") .. " reset")
end)
