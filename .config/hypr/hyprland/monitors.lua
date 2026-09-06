local vars = require("variables")

-- Fallback for anything docked or plugged in later. A more specific rule for
-- a named output always wins over this one.
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

-- The built in panel. `preferred` picks its native mode, which avoids
-- hardcoding a resolution that breaks if the panel is ever swapped.
--
-- The transform is deliberately absent here. scripts/tablet-mode.sh rewrites
-- this whole line at runtime to rotate the screen, and a transform baked into
-- the config would fight it on every reload.
hl.monitor({
    output   = vars.internalMonitor,
    mode     = "preferred",
    position = "auto",
    scale    = vars.internalScale,
})
