local status_ok, mason = pcall(require, "mason")
if not status_ok then
    return
end

local settings = {
    ui = {
        icons = {
            package_installed = "✝",
            package_pending = "✓",
            package_uninstalled = "✗",
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 10,
}

mason.setup(settings)

-- Load Custom server and icons
require("pkgs.lsp.lsp-config").setup()

require("nvim-tree").setup({
    sort_by = "case_sensitive",
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
    view = {
        options = {
            hide_dotfiles = false,
        },
    },
})

require("pkgs.lsp.lsps")


local status_ok, noice = pcall(require, "noice")
if not status_ok then
    return
end

noice.setup({
    lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
        },
    },
    presets = {
        bottom_search = false,        -- use a classic bottom cmdline for search
        command_palette = true,       -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false,           -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false,       -- add a border to hover docs and signature help
    },
})

local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
    return
end

mason_lspconfig.setup({
    ensure_installed = {},
    automatic_installation = true,
})

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true


local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
    return
end

configs.setup({})

require('adoc_pdf_live').setup()

local langs = {
    'go',
    'python',
    'c',
    'svelte',
    'java',
    'html',
    'css',
    'javascript',
    'gitcommit',
    'gitignore',
    'typescript',
    'sql',
    'bash',
    'json',
    'toml',
    'yaml',
    'terraform',
    'dockerfile',
    'lua'
}

configs.setup({
    ensure_installed = langs, -- one of 'all' or a list of languages
    sync_install = true,      -- install languages synchronously (only applied to `ensure_installed`)
    highlight = {
        -- user_languagetree = true,
        enable = true,       -- false will disable the whole extension
        disable = { 'css' }, -- list of language that will be disabled
        additional_vim_regex_highlighting = true,
    },
    autopairs = {
        enable = true,
    },
    indent = { enable = true, disable = { 'css' } },
    context_commentstring = {
        enable = true,
        ensure_installed = false,
    },
    autotag = {
        enable = true,
        disable = { 'xml' },
    },
    rainbow = {
        enable = true,
        colors = {
            'Gold',
            'Orchid',
            'DodgerBlue',
        },
        disable = { 'html' },
    },
    playground = {
        enable = true,
    },
})
