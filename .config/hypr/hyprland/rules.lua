local vars = require("variables")

-- Tag a list of matches so a single rule can be applied to all of them below.
-- `field` names the property to match on when the entries are plain strings.
local function tag(name, matches, field)
    for _, match in ipairs(matches) do
        if field then
            match = { [field] = match }
        end
        hl.window_rule({ match = match, tag = "+" .. name })
    end
end

local OPAQUE   = "opaque"
local FLOAT    = "float"
local FLOAT_LG = "float_large"
local FLOAT_MD = "float_medium"
local COMMS    = "comms"
local XWL_POPUP = "xwl_popup"


--------------------------
---- Baseline styling ----
--------------------------

-- Slight transparency everywhere except fullscreen, where it would only cost
-- fill rate for something nobody can see behind.
hl.window_rule({
    match   = { fullscreen = false },
    opacity = vars.windowOpacity .. " override",
})

-- Centre floating windows, but leave XWayland alone: its menus and tooltips
-- count as windows and would jump to the middle of the screen.
hl.window_rule({
    match  = { float = true, xwayland = false },
    center = true,
})


-------------------------
---- Picture in picture ----
-------------------------

-- Small, pinned and stuck to the bottom right corner.
hl.window_rule({
    match             = { title = "Picture(-| )in(-| )[Pp]icture" },
    float             = true,
    pin               = true,
    keep_aspect_ratio = true,
    size              = "(monitor_w*0.22) (monitor_h*0.22)",
    move              = "(monitor_w*0.97-window_w) (monitor_h*0.96-window_h)",
})


------------------------------
---- Chat apps on comms ws ----
------------------------------

-- Slack and Discord always land on the comms workspace, silently, so they
-- never steal focus when they finish starting up minutes after login.
--
-- To make this apply only to the copies started at login, delete these two
-- rules and move the placement into hyprland/execs.lua instead.
tag(COMMS, {
    "^(vesktop|discord|equibop|WebCord)$",
    "^(com\\.slack\\.Slack|Slack)$",
}, "class")


---------------------
---- Opaque apps ----
---------------------

-- Anything where transparency actively hurts: text you read all day, colour
-- accurate work, and the shell itself.
tag(OPAQUE, {
    "^(Alacritty|foot|kitty)$",
    "^(code|code-oss|Code)$",
    "^(vesktop|discord)$",
    "^org\\.quickshell",
    "^(feh|imv|swappy|org\\.gnome\\.Loupe)$",
    "^(gimp|krita|inkscape|darktable)$",
    "^(kdenlive|shotcut|obs)$",
    "^(blender|godot)$",
}, "class")


-----------------------
---- Floating apps ----
-----------------------

tag(FLOAT, {
    "^(pavucontrol|org\\.pulseaudio\\.pavucontrol)$",
    "^(blueman-manager|nm-connection-editor)$",
    "^(org\\.gnome\\.FileRoller|file-roller)$",
    "^(yad|zenity|wev)$",
    "^(feh|imv|swappy)$",
    "^org\\.quickshell",
}, "class")

tag(FLOAT, {
    "^File (Operation|Upload)( Progress)?$",
    "^.* Properties$",
    "^Rename \".*\"$",
}, "title")

-- File and save dialogs want room to actually browse.
tag(FLOAT_LG, {
    "^(Select|Open)( a)? (File|Folder)s?$",
    "^Save As$",
}, "title")

tag(FLOAT_MD, {
    "^(org\\.gnome\\.Settings|nwg-look|system-config-printer)$",
}, "class")


--------------------------
---- XWayland popups ----
--------------------------

-- XWayland override redirect surfaces arrive as windows with no class or
-- title. Decorating them puts shadows and rounded corners on every dropdown
-- menu in Steam and every Java app.
tag(XWL_POPUP, {
    { xwayland = true, title = "^win[0-9]+$" },
    { xwayland = true, title = "^$", class = "^$", initial_title = "^$", initial_class = "^$" },
})


-------------------------
---- Tag definitions ----
-------------------------
-- These have to come last. A tag rule only applies to windows tagged before
-- the definition is parsed.

hl.window_rule({ match = { tag = OPAQUE }, opaque = true })

hl.window_rule({ match = { tag = FLOAT }, float = true })

hl.window_rule({
    match  = { tag = FLOAT_LG },
    float  = true,
    size   = "(monitor_w*0.6) (monitor_h*0.7)",
    center = true,
})

hl.window_rule({
    match  = { tag = FLOAT_MD },
    float  = true,
    size   = "(monitor_w*0.5) (monitor_h*0.6)",
    center = true,
})

hl.window_rule({
    match     = { tag = COMMS },
    workspace = vars.commsWorkspace .. " silent",
})

hl.window_rule({
    match     = { tag = XWL_POPUP },
    no_blur   = true,
    no_shadow = true,
    no_dim    = true,
    opaque    = true,
    rounding  = 0,
})


---------------------
---- Layer rules ----
---------------------

-- The shell. Drawers and the background fade, the picker overlays must not
-- animate at all or the region you select lags behind the cursor.
hl.layer_rule({ match = { namespace = "caelestia-(drawers|background)" }, animation = "fade" })
hl.layer_rule({ match = { namespace = "caelestia-(border-exclusion|area-picker)" }, no_anim = true })

-- Everything else that draws a transient overlay.
hl.layer_rule({ match = { namespace = "hyprpicker" }, animation = "fade" })
hl.layer_rule({ match = { namespace = "selection" }, animation = "fade" })
hl.layer_rule({ match = { namespace = "launcher" }, animation = "popin 80%", blur = true })

-- The on screen keyboard sits above the lock screen so you can type your
-- password with the lid folded back.
hl.layer_rule({ match = { namespace = "wvkbd" }, above_lock = 1, animation = "slide bottom" })
