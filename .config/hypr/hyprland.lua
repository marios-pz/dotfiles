-- Hyprland configuration, paired with the Caelestia shell.
--
-- Layout:
--   variables.lua      every tunable value
--   hyprland/*.lua     one concern per file, loaded in the order below
--   utils/*.lua        helpers shared between modules
--   scripts/*.sh       anything that has to outlive a dispatcher call
--
-- Order matters in two places: rules.lua defines window tags that gaming.lua
-- and convertible.lua reuse, and keybinds.lua expects the workspaces to exist.

require("hyprland.env")
require("hyprland.monitors")
require("hyprland.general")
require("hyprland.animations")
require("hyprland.input")
require("hyprland.gestures")
require("hyprland.workspaces")
require("hyprland.rules")
require("hyprland.gaming")
require("hyprland.convertible")
require("hyprland.keybinds")
require("hyprland.execs")
