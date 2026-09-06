local vars = require("variables")

hl.config({
    input = {
        kb_layout          = vars.kbLayout,
        kb_options         = vars.kbOptions,
        numlock_by_default = true,

        repeat_delay       = 250,
        repeat_rate        = 35,

        follow_mouse       = 1,
        focus_on_close     = 1,

        touchpad = {
            natural_scroll       = true,
            tap_to_click         = true,
            tap_and_drag         = true,
            disable_while_typing = vars.touchpadDisableTyping,
            scroll_factor        = vars.touchpadScrollFactor,
            clickfinger_behavior = true,
        },

        -- Bind touch to the built in panel. This is also what makes rotation
        -- work: when the output is transformed, Hyprland transforms the touch
        -- coordinates of any device mapped to it, so taps keep landing where
        -- you actually pressed.
        touchdevice = {
            output = vars.internalMonitor,
        },

        tablet = {
            output = vars.internalMonitor,
        },
    },
})

-- The Wacom digitiser exposes finger and pen as two separate devices, and
-- only the finger one is picked up by input:touchdevice. Map the pen too,
-- otherwise stylus input stays stretched across the whole layout once a
-- second monitor is attached.
hl.device({
    name   = vars.touchscreenName,
    output = vars.internalMonitor,
})

hl.device({
    name   = vars.penName,
    output = vars.internalMonitor,
})
