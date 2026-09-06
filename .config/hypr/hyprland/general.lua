local vars = require("variables")

hl.config({
    general = {
        layout          = "dwindle",

        gaps_in         = vars.gapsIn,
        gaps_out        = vars.gapsOut,
        gaps_workspaces = vars.gapsWorkspaces,
        border_size     = vars.borderSize,

        -- Tearing is opt in per window. Only windows tagged `game` in
        -- hyprland/gaming.lua actually get it.
        allow_tearing   = true,

        col             = {
            active_border   = vars.activeBorder,
            inactive_border = vars.inactiveBorder,
        },
    },

    dwindle = {
        preserve_split = true,
        smart_resizing = true,
    },

    decoration = {
        rounding = vars.windowRounding,

        blur = {
            enabled           = true,
            size              = vars.blurSize,
            passes            = vars.blurPasses,
            new_optimizations = true,
            -- Lets the shell's translucent panels blur what is behind them.
            ignore_opacity    = true,
            popups            = true,
            input_methods     = true,
        },

        shadow = {
            enabled      = true,
            range        = vars.shadowRange,
            render_power = 4,
            color        = vars.shadowColour,
        },
    },

    misc = {
        disable_hyprland_logo        = true,
        disable_splash_rendering     = true,
        force_default_wallpaper      = 0,
        background_color             = vars.backgroundCol,

        animate_manual_resizes       = false,
        animate_mouse_windowdragging = false,

        -- Lets Caelestia's lock screen come back if the shell is restarted
        -- while locked, instead of dropping you at a dead screen.
        allow_session_lock_restore   = true,
        session_lock_xray            = true,

        focus_on_activate            = true,
        on_focus_under_fullscreen    = 2,
        middle_click_paste           = false,

        mouse_move_enables_dpms      = true,
        key_press_enables_dpms       = true,
    },

    binds = {
        scroll_event_delay       = 0,
        -- Static workspaces, so pressing the key for the workspace you are
        -- already on should do nothing rather than bounce you elsewhere.
        workspace_back_and_forth = false,
        allow_pin_fullscreen     = true,
    },

    cursor = {
        hotspot_padding   = 1,
        -- Convertible niceties: the pointer gets out of the way as soon as
        -- you touch the screen, and comes back when you move the mouse.
        hide_on_touch     = true,
        hide_on_key_press = false,
        inactive_timeout  = 5,
    },

    render = {
        -- Bypasses composition for fullscreen windows. This is what makes
        -- tearing and the low latency path actually reachable in games.
        direct_scanout = 1,
    },

    xwayland = {
        -- Steam, Proton and most native Linux games are XWayland clients.
        -- Without this they render at 1x and get upscaled into a blur on any
        -- output with a scale other than 1.
        force_zero_scaling = true,
    },

    ecosystem = {
        no_update_news  = true,
        no_donation_nag = true,
    },
})
