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
hl.monitor({
    output   = vars.internalMonitor,
    mode     = "preferred",
    position = "auto",
    scale    = vars.internalScale,
})
