local vars   = require("variables")
local util   = require("utils.functions")
local gaming = require("hyprland.gaming")

-- Every keyboard and mouse bind. Switch events (hinge, lid) live in
-- hyprland/convertible.lua because they are not keys.
--
-- Mod is SUPER throughout. Anything prefixed `caelestia:` is a global
-- shortcut registered by the shell over the D-Bus GlobalShortcuts portal,
-- which is why those need no command and keep working while locked.

local function bind(keys, action, desc, opts)
    opts = opts or {}
    opts.description = desc
    hl.bind(keys, action, opts)
end

local locked    = { locked = true }
local repeating = { repeating = true }
local mouse     = { mouse = true }


-----------------
---- The shell ----
-----------------

bind("SUPER + Space", hl.dsp.global("caelestia:launcher"), "App launcher")
-- Tapping and releasing Super on its own also opens it, the way it does on
-- Windows. The release flag is what stops it firing on every Super + key.
bind("SUPER + SUPER_L", hl.dsp.global("caelestia:launcher"), "App launcher", { release = true })

bind("SUPER + N", hl.dsp.global("caelestia:sidebar"), "Toggle sidebar")
-- Ctrl is in the way here because bare SUPER + K and SUPER + L are focus
-- keys, see the hjkl block below.
bind("CTRL + SUPER + K", hl.dsp.global("caelestia:showall"), "Show every shell panel")
bind("CTRL + SUPER + L", hl.dsp.global("caelestia:lock"), "Lock the session")
bind("CTRL + ALT + Delete", hl.dsp.global("caelestia:session"), "Session menu",
    { dont_inhibit = true })
bind("CTRL + ALT + C", hl.dsp.global("caelestia:clearNotifs"), "Clear notifications", locked)
bind("CTRL + SUPER + SHIFT + L", hl.dsp.exec_cmd(vars.sleepCmd), "Suspend", locked)

-- If the shell dies while the screen is locked, this brings both back.
bind("SUPER + ALT + L", function()
    hl.dispatch(hl.dsp.exec_cmd("caelestia shell -d"))
    hl.dispatch(hl.dsp.global("caelestia:lock"))
end, "Restart the shell and lock")

bind("CTRL + SUPER + SHIFT + R", hl.dsp.exec_cmd("qs -c caelestia kill"),
    "Kill the shell", { release = true })
bind("CTRL + SUPER + ALT + R", hl.dsp.exec_cmd("qs -c caelestia kill; sleep .1; caelestia shell -d"),
    "Restart the shell", { release = true })


------------------
---- Programs ----
------------------

bind("SUPER + Return", hl.dsp.exec_cmd(vars.terminal), "Terminal")
bind("SUPER + B", hl.dsp.exec_cmd(vars.browser), "Browser")
bind("SUPER + E", hl.dsp.exec_cmd(vars.fileExplorer), "File manager")
bind("SUPER + C", hl.dsp.exec_cmd(vars.editor), "Editor")
bind("CTRL + ALT + V", hl.dsp.exec_cmd(vars.audioSettings), "Audio settings")
bind("CTRL + SHIFT + Escape", hl.dsp.exec_cmd(vars.systemMonitor), "System monitor")


----------------
---- Windows ----
----------------

bind("SUPER + Q", hl.dsp.window.close(), "Close window")
bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }), "Fullscreen")
bind("SUPER + SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized" }), "Maximise")
bind("SUPER + T", hl.dsp.window.float(), "Toggle floating")
bind("SUPER + P", hl.dsp.window.pin(), "Pin above other workspaces")
bind("CTRL + SUPER + C", hl.dsp.window.center(), "Centre window")
bind("SUPER + ALT + Backslash", util.pip, "Shrink to a corner, pinned")

-- Focus. Arrows and hjkl do the same thing.
for key, dir in pairs({ left = "left", right = "right", up = "up", down = "down",
                        H = "left", L = "right", K = "up", J = "down" }) do
    bind("SUPER + " .. key, hl.dsp.focus({ direction = dir }), "Focus " .. dir)
    bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ direction = dir }), "Move window " .. dir)
end

-- Resize. Width on the bare key, height with Shift.
bind("SUPER + Minus", util.resize_active(-10, 0), "Narrower", repeating)
bind("SUPER + Equal", util.resize_active(10, 0), "Wider", repeating)
bind("SUPER + SHIFT + Minus", util.resize_active(0, -10), "Shorter", repeating)
bind("SUPER + SHIFT + Equal", util.resize_active(0, 10), "Taller", repeating)

-- Mouse. 272 is left button, 273 is right.
bind("SUPER + mouse:272", hl.dsp.window.drag(), "Drag window", mouse)
bind("SUPER + mouse:273", hl.dsp.window.resize(), "Resize window", mouse)

-- Alt tab through the windows on this workspace.
bind("ALT + TAB", hl.dsp.window.cycle_next(), "Next window", repeating)
bind("SHIFT + ALT + TAB", hl.dsp.window.cycle_next({ next = false }), "Previous window", repeating)


---------------
---- Groups ----
---------------

bind("SUPER + Comma", hl.dsp.group.toggle(), "Group or ungroup")
bind("SUPER + U", hl.dsp.window.move({ out_of_group = true }), "Pull window out of its group")
bind("CTRL + ALT + TAB", hl.dsp.group.next(), "Next window in group", repeating)
bind("CTRL + SHIFT + ALT + TAB", hl.dsp.group.prev(), "Previous window in group", repeating)


-------------------
---- Workspaces ----
-------------------

-- Static 1 to 9. Every one always exists, so these never create or destroy
-- anything, they only move you.
for i = 1, vars.workspaceCount do
    bind("SUPER + " .. i, hl.dsp.focus({ workspace = i }), "Go to workspace " .. i)
    bind("SUPER + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }),
        "Move window to workspace " .. i)
end

bind("SUPER + D", hl.dsp.focus({ workspace = vars.commsWorkspace }), "Go to chat apps")
bind("SUPER + TAB", hl.dsp.focus({ workspace = "previous" }), "Last workspace")

bind("CTRL + SUPER + Left", hl.dsp.focus({ workspace = "-1" }), "Previous workspace", repeating)
bind("CTRL + SUPER + Right", hl.dsp.focus({ workspace = "+1" }), "Next workspace", repeating)
bind("SUPER + mouse_up", hl.dsp.focus({ workspace = "-1" }), "Previous workspace")
bind("SUPER + mouse_down", hl.dsp.focus({ workspace = "+1" }), "Next workspace")

-- Scratchpad. Also reachable with a three finger swipe, see gestures.lua.
bind("SUPER + S", hl.dsp.workspace.toggle_special("scratchpad"), "Toggle scratchpad")
bind("SUPER + ALT + S", hl.dsp.window.move({ workspace = "special:scratchpad" }),
    "Send window to scratchpad")


-------------------
---- Screen and clipboard ----
-------------------

bind("Print", hl.dsp.exec_cmd("caelestia screenshot"), "Screenshot the screen", locked)
bind("SUPER + SHIFT + S", hl.dsp.global("caelestia:screenshotFreeze"),
    "Freeze the screen and snip a region")
bind("SUPER + SHIFT + ALT + S", hl.dsp.global("caelestia:screenshot"), "Snip a live region")
bind("SUPER + SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a"), "Pick a colour")

bind("CTRL + ALT + R", hl.dsp.exec_cmd("caelestia record"), "Record the screen")
bind("SUPER + ALT + R", hl.dsp.exec_cmd("caelestia record -s"), "Record with sound")
bind("SUPER + SHIFT + ALT + R", hl.dsp.exec_cmd("caelestia record -r"), "Record a region")

-- `pkill fuzzel ||` makes each of these a toggle rather than stacking pickers.
bind("SUPER + V", hl.dsp.exec_cmd("pkill fuzzel || caelestia clipboard"), "Clipboard history")
bind("SUPER + ALT + V", hl.dsp.exec_cmd("pkill fuzzel || caelestia clipboard -d"),
    "Delete from clipboard history")
bind("SUPER + Period", hl.dsp.exec_cmd("pkill fuzzel || caelestia emoji -p"), "Emoji picker")


---------------------------
---- Convertible extras ----
---------------------------

bind("SUPER + O", hl.dsp.exec_cmd(util.script("osk.sh") .. " toggle"),
    "Toggle the on screen keyboard", locked)
bind("SUPER + R", hl.dsp.exec_cmd(util.script("rotation.sh") .. " lock"),
    "Lock or unlock auto rotation")
bind("SUPER + SHIFT + R", hl.dsp.exec_cmd(util.script("rotation.sh") .. " step"),
    "Rotate the screen 90 degrees")


---------------
---- Gaming ----
---------------

bind("SUPER + G", gaming.toggle_game_mode, "Toggle game mode")


------------------------------
---- Media, volume, light ----
------------------------------

-- The shell owns these so the on screen indicator shows up.
bind("XF86MonBrightnessUp", hl.dsp.global("caelestia:brightnessUp"), "Brighter", locked)
bind("XF86MonBrightnessDown", hl.dsp.global("caelestia:brightnessDown"), "Dimmer", locked)

bind("XF86AudioPlay", hl.dsp.global("caelestia:mediaToggle"), "Play or pause", locked)
bind("XF86AudioPause", hl.dsp.global("caelestia:mediaToggle"), "Play or pause", locked)
bind("XF86AudioNext", hl.dsp.global("caelestia:mediaNext"), "Next track", locked)
bind("XF86AudioPrev", hl.dsp.global("caelestia:mediaPrev"), "Previous track", locked)
bind("XF86AudioStop", hl.dsp.global("caelestia:mediaStop"), "Stop playback", locked)
bind("CTRL + SUPER + Space", hl.dsp.global("caelestia:mediaToggle"), "Play or pause", locked)

-- Volume goes straight to wireplumber. Raising unmutes first, which is what
-- everyone actually expects from the key.
bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(string.format(
    "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l %s @DEFAULT_AUDIO_SINK@ %d%%+",
    vars.volumeMax / 100, vars.volumeStep
)), "Volume up", { locked = true, repeating = true })

bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(string.format(
    "wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ %d%%-",
    vars.volumeStep
)), "Volume down", { locked = true, repeating = true })

bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), "Mute", locked)
bind("SUPER + SHIFT + M", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), "Mute", locked)
bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    "Mute the microphone", locked)
