local vars = require("variables")
local util = require("utils.functions")

-- Lid handling.
--
-- Switches are matched on their raw libinput name, unlike pointer devices
-- which Hyprland lowercases and hyphenates. `hyprctl devices` prints both
-- forms if you ever need to check them.

local lid = util.script("lid.sh")

-- Closing the lid blanks the panel. Nothing here suspends: that is
-- logind's job, and duplicating it causes races on resume.
hl.bind(
    "switch:on:" .. vars.lidSwitch,
    hl.dsp.exec_cmd(lid .. " close"),
    { locked = true, description = "Lid closed" }
)

hl.bind(
    "switch:off:" .. vars.lidSwitch,
    hl.dsp.exec_cmd(lid .. " open"),
    { locked = true, description = "Lid opened" }
)
