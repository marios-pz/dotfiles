-- Every knob for this setup lives here. The modules under hyprland/ read from
-- this table, so day to day tweaking should not require touching them.

return {
    ------------------
    ---- PROGRAMS ----
    ------------------

    terminal      = "alacritty",
    browser       = "zen-browser",
    fileExplorer  = "nautilus",
    editor        = "code",
    audioSettings = "pavucontrol",
    systemMonitor = "alacritty --class btop -e btop",

    -- Autostarted at login. Discord and Slack are pinned to the comms
    -- workspace by the rules in hyprland/rules.lua.
    discord       = "vesktop",
    slack         = "flatpak run com.slack.Slack",

    -----------------
    ---- DISPLAY ----
    -----------------

    -- The built in panel. `hyprctl monitors` lists the names of everything
    -- else you plug in.
    internalMonitor = "eDP-1",
    internalScale   = 1,

    -- Static workspaces. Every one of these exists at all times, so the
    -- Caelestia bar always shows the full row.
    workspaceCount  = 9,
    commsWorkspace  = 9,

    ---------------
    ---- INPUT ----
    ---------------

    kbLayout              = "us,gr",
    kbOptions             = "grp:alt_shift_toggle",

    touchpadName          = "elan06fa:00-04f3:327e-touchpad",
    touchscreenName       = "wacom-hid-53b8-finger",
    penName               = "wacom-hid-53b8-pen",

    -- Raw libinput names. Unlike pointer devices, Hyprland matches switches
    -- on the unmodified name, so these keep their spaces and capitals.
    tabletModeSwitch      = "Lenovo Yoga Tablet Mode Control switch",
    lidSwitch             = "Lid Switch",

    touchpadScrollFactor  = 0.3,
    touchpadDisableTyping = true,

    -- Fingers per touchpad gesture.
    workspaceSwipeFingers = 4,
    gestureFingers        = 3,

    ------------------
    ---- AESTHETIC ---
    ------------------

    -- Caelestia repaints borders and shadows from the active wallpaper, so
    -- these are only the fallback colours used before the shell comes up.
    activeBorder   = "rgba(a4cbedee)",
    inactiveBorder = "rgba(31363b44)",
    shadowColour   = "rgba(0000004d)",
    backgroundCol  = "rgb(121416)",

    windowOpacity  = 0.95,
    windowRounding = 15,
    borderSize     = 2,

    gapsIn         = 5,
    gapsOut        = 10,
    gapsWorkspaces = 20,
    gapsSingle     = 20,

    blurSize       = 8,
    blurPasses     = 2,
    shadowRange    = 15,

    cursorTheme    = "capitaine-cursors",
    cursorSize     = 24,

    --------------
    ---- MISC ----
    --------------

    -- Strip blur, shadows and animations while a game has focus. Set to
    -- false to drive game mode purely from Super+G.
    autoGameMode    = true,

    volumeStep      = 5,
    volumeMax       = 100,
    sleepCmd        = "systemctl suspend",

    -- On screen keyboard height, in pixels, for portrait and landscape.
    oskHeight       = 340,
    oskLandscape    = 260,
}
