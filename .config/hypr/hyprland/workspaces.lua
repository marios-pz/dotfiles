local vars = require("variables")

-- Static workspaces 1 to 9.
--
-- `persistent` keeps each one alive even when empty, which is what makes the
-- Caelestia bar show the full row at all times instead of only the workspaces
-- that happen to have a window in them.
--
-- No `monitor` is set on purpose. Binding them to eDP-1 would strand every
-- workspace on the laptop panel the moment you dock, so instead they follow
-- whichever output is focused.
for i = 1, vars.workspaceCount do
    hl.workspace_rule({
        workspace  = tostring(i),
        persistent = true,
    })
end

-- A single scratchpad, reachable from the keyboard and from a three finger
-- swipe. Special workspaces are not part of the 1 to 9 row.
hl.workspace_rule({
    workspace = "special:scratchpad",
    gaps_out  = vars.gapsSingle,
})

-- Breathe a little when a workspace holds exactly one window. `s[false]`
-- excludes fullscreen, so this never adds bars around a fullscreen game.
hl.workspace_rule({ workspace = "w[tv1]s[false]", gaps_out = vars.gapsSingle })
hl.workspace_rule({ workspace = "f[1]s[false]", gaps_out = vars.gapsSingle })
