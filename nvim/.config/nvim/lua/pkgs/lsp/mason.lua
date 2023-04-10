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
})

require("pkgs.lsp.lsps")

require('hologram').setup {
    auto_display = false
}

require("presence").setup({
    -- General options
    auto_update         = true,                 -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
    neovim_image_text   = "I use Neovim BTW",   -- Text displayed when hovered over the Neovim image
    main_image          = "neovim",             -- Main image display (either "neovim" or "file")
    client_id           = "793271441293967371", -- Use your own Discord application client id (not recommended)
    log_level           = nil,                  -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
    debounce_timeout    = 10,                   -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
    enable_line_number  = false,                -- Displays the current line number instead of the current project
    blacklist           = {},                   -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
    buttons             = true,                 -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
    file_assets         = {},                   -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
    show_time           = true,                 -- Show the timer
    -- Rich Presence text options
    editing_text        = "Editing %s",         -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
    file_explorer_text  = "Browsing %s",        -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
    git_commit_text     = "Committing changes", -- Format string rendered when committing changes in git (either string or function(filename: string): string)
    plugin_manager_text = "Managing plugins",   -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
    reading_text        = "Reading %s",         -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
    workspace_text      = "Working on %s",      -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
    line_number_text    = "Line %s out of %s",  -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
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

local status_ok, todo = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
    return
end
todo.setup({})

local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
    return
end

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
