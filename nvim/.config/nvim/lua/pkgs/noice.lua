local status_ok, noice = pcall(require, "noice")
if not status_ok then
    return
end

local status_ok, notify = pcall(require, "notify")
if not status_ok then
    return
end

notify.setup({
    background_colour = "#000000",
})

noice.setup({
    lsp = {
        signature = { enabled = false },
        hover = { enabled = false },
        message = { enabled = false },
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
    },
    presets = {
        bottom_search = false,        -- use a classic bottom cmdline for search
        command_palette = false,      -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = true,            -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true,        -- add a border to hover docs and signature help
    },
})
