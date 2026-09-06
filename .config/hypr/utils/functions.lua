-- Helpers shared between the modules under hyprland/.

local M = {}

-- Resize the focused window by a percentage of its current size. Returns a
-- closure rather than a dispatcher so the size is read at press time, not at
-- config load time.
function M.resize_active(x_percent, y_percent)
    return function()
        local win = hl.get_active_window()
        if not (win and win.size) then
            return hl.dispatch(hl.dsp.no_op())
        end

        hl.dispatch(hl.dsp.window.resize({
            x        = win.size.x * (x_percent / 100),
            y        = win.size.y * (y_percent / 100),
            relative = true,
        }))
    end
end

-- Float the focused window, park it bottom right at a quarter of the screen
-- height and pin it above everything. Handy for a video while you work.
function M.pip()
    local win = hl.get_active_window()
    local mon = hl.get_active_monitor()
    if not (win and win.size and mon) then
        return
    end

    local mon_w = mon.width / mon.scale
    local mon_h = mon.height / mon.scale

    local scale = (mon_h / 4) / win.size.y
    local w     = math.floor(math.max(200, win.size.x * scale))
    local h     = math.floor(math.max(150, win.size.y * scale))

    local margin = math.min(mon_w, mon_h) * 0.03

    if not win.floating then
        hl.dispatch(hl.dsp.window.float({ action = "on", window = win }))
    end

    hl.dispatch(hl.dsp.window.resize({ x = w, y = h, window = win }))
    hl.dispatch(hl.dsp.window.move({
        x        = math.floor(mon.x + mon_w - w - margin),
        y        = math.floor(mon.y + mon_h - h - margin),
        relative = false,
        window   = win,
    }))
    hl.dispatch(hl.dsp.window.pin({ action = "on", window = "address:" .. win.address }))
end

-- Absolute path to a script in this config's scripts/ directory. Dispatchers
-- run without a shell, so "~" is never expanded for us.
local home = os.getenv("HOME")
local config_dir = os.getenv("XDG_CONFIG_HOME") or (home .. "/.config")

function M.script(name)
    return config_dir .. "/hypr/scripts/" .. name
end

return M
