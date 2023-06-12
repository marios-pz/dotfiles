-- The name's ThePrimeagen.
local err, harpoon = pcall(require, "harpoon")
if not err then
    return
end

require("telescope").load_extension('harpoon')

harpoon.setup({
    menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
    }
})
