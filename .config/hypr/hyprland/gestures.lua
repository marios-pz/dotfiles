local vars = require("variables")

hl.config({
    gestures = {
        workspace_swipe_distance                 = 700,
        workspace_swipe_cancel_ratio             = 0.15,
        workspace_swipe_min_speed_to_force       = 5,
        workspace_swipe_direction_lock           = true,
        workspace_swipe_direction_lock_threshold = 10,

        -- Workspaces are static, so a swipe past the last one should stop
        -- rather than conjure a tenth workspace.
        workspace_swipe_create_new               = false,

        -- The whole point of a 2-in-1: the same swipe works with the lid
        -- folded back and no touchpad in reach.
        workspace_swipe_touch                    = true,
    },
})

-- Four fingers left and right walks the static workspaces.
hl.gesture({
    fingers   = vars.workspaceSwipeFingers,
    direction = "horizontal",
    action    = "workspace",
})

-- Three fingers up and down reaches the scratchpad.
hl.gesture({
    fingers        = vars.gestureFingers,
    direction      = "up",
    action         = "special",
    workspace_name = "scratchpad",
})

hl.gesture({
    fingers        = vars.gestureFingers,
    direction      = "down",
    action         = "special",
    workspace_name = "scratchpad",
})

-- Pinch to zoom the whole desktop. Genuinely useful on a small touch panel.
hl.gesture({
    fingers     = 2,
    direction   = "pinch",
    action      = "cursor_zoom",
    zoom_level  = 1.2,
    mode        = "mult",
})
