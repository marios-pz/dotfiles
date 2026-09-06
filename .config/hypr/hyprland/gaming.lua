local vars = require("variables")

-- Everything Steam and friends need to behave on Hyprland, plus a game mode
-- that strips the compositor down to essentials while you play.

local GAME = "game"

local function tag(matches, field)
    for _, match in ipairs(matches) do
        if field then
            match = { [field] = match }
        end
        hl.window_rule({ match = match, tag = "+" .. GAME })
    end
end


-------------------------
---- What is a game ----
-------------------------

tag({
    -- Steam assigns this class to the game window itself, never to the
    -- client. Anchoring matters: an unanchored "steam" would swallow every
    -- steam_app_* window into the client rules below.
    "^steam_app_[0-9]+$",
    -- Lutris and Heroic launched titles.
    "^steam_app_default$",
    "^(lutris|heroic)-",
    -- Anything already wrapped in gamescope.
    "^gamescope$",
}, "class")


--------------------------
---- Game window rules ----
--------------------------

hl.window_rule({
    match        = { tag = GAME },

    -- No compositing effects on something redrawing every frame.
    opaque       = true,
    no_blur      = true,
    no_shadow    = true,
    no_dim       = true,
    rounding     = 0,

    -- Opts this window into the tearing enabled by general.allow_tearing.
    -- Lower latency, at the cost of a tear line under vsync misses.
    immediate    = true,

    -- Tells Hyprland to prefer the direct scanout path for this surface.
    content      = "game",

    -- A controller only session sends no keyboard or pointer events, so the
    -- idle timer would otherwise lock the screen mid match.
    idle_inhibit = "always",
})


-----------------------------
---- Steam client quirks ----
-----------------------------

-- Hyprland has no negative match, so this floats every window the client
-- owns and the rule below puts the real main window back into the tiling.
hl.window_rule({
    match = { class = "^steam$" },
    float = true,
})

-- The main window is the only one titled exactly "Steam". Static effects are
-- matched against the initial title, which is what this window opens with.
hl.window_rule({
    match = { class = "^steam$", title = "^Steam$" },
    float = false,
    tile  = true,
})

hl.window_rule({
    match = { class = "^steam$", title = "^Friends List$" },
    float = true,
    size  = "(monitor_w*0.25) (monitor_h*0.7)",
})

-- Notification toasts park themselves and must never take focus.
hl.window_rule({
    match            = { class = "^steam$", title = "^notificationtoasts_[0-9]+_desktop$" },
    float            = true,
    no_initial_focus = true,
    no_focus         = true,
})


---------------------
---- Game mode ----
---------------------

-- Blur and animations are the two things that cost real frames on integrated
-- graphics. This turns them off together, along with gaps and borders, and
-- puts them back afterwards.

local game_mode_on = false

local function set_game_mode(enabled)
    game_mode_on = enabled

    hl.config({
        animations = { enabled = not enabled },
        decoration = {
            blur   = { enabled = not enabled },
            shadow = { enabled = not enabled },
        },
        general = {
            gaps_in     = enabled and 0 or vars.gapsIn,
            gaps_out    = enabled and 0 or vars.gapsOut,
            border_size = enabled and 0 or vars.borderSize,
        },
    })

    hl.exec_cmd(string.format(
        "notify-send -u low -a Hyprland 'Game mode %s'",
        enabled and "on" or "off"
    ))
end

local function toggle_game_mode()
    set_game_mode(not game_mode_on)
end


-- Follow focus, so alt tabbing out of a game gives the desktop its effects
-- back without touching the keyboard. Set autoGameMode to false in
-- variables.lua to drive it purely from the keybind.
if vars.autoGameMode then
    local function is_game(win)
        local class = win and (win.class or win.initial_class)
        if not class then
            return false
        end
        return class:match("^steam_app_") ~= nil
            or class == "gamescope"
            or class:match("^lutris%-") ~= nil
            or class:match("^heroic%-") ~= nil
    end

    hl.on("window.active", function(win)
        local wanted = is_game(win)
        if wanted ~= game_mode_on then
            set_game_mode(wanted)
        end
    end)
end

return {
    toggle_game_mode = toggle_game_mode,
    set_game_mode    = set_game_mode,
}
