local vars = require("variables")
local util = require("utils.functions")

-- 2-in-1 hinge and lid handling.
--
-- Switches are matched on their raw libinput name, unlike pointer devices
-- which Hyprland lowercases and hyphenates. `hyprctl devices` prints both
-- forms if you ever need to check them.

local tablet_mode = util.script("tablet-mode.sh")

-- Folding the lid past the keyboard: rotation follows the accelerometer, the
-- on screen keyboard comes up on text focus, and the touchpad stops
-- registering the palm now pressed against it.
hl.bind(
    "switch:on:" .. vars.tabletModeSwitch,
    hl.dsp.exec_cmd(tablet_mode .. " on"),
    { locked = true, description = "Enter tablet mode" }
)

hl.bind(
    "switch:off:" .. vars.tabletModeSwitch,
    hl.dsp.exec_cmd(tablet_mode .. " off"),
    { locked = true, description = "Leave tablet mode" }
)

-- Closing the lid blanks the panel. Nothing here suspends: that is
-- logind's job, and duplicating it causes races on resume.
hl.bind(
    "switch:on:" .. vars.lidSwitch,
    hl.dsp.exec_cmd(tablet_mode .. " lid-close"),
    { locked = true, description = "Lid closed" }
)

hl.bind(
    "switch:off:" .. vars.lidSwitch,
    hl.dsp.exec_cmd(tablet_mode .. " lid-open"),
    { locked = true, description = "Lid opened" }
)
