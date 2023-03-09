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

require('hologram').setup{
    auto_display = true
}

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

configs.setup({
  ensure_installed = 'all',                            -- one of 'all' or a list of languages
  sync_install = false,                                -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { 'phpdoc', 'tree-sitter-phpdoc' }, -- List of parsers to ignore installing
  highlight = {
    -- user_languagetree = true,
    enable = true,       -- false will disable the whole extension
    disable = { 'css' }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  },
  autopairs = {
    enable = true,
  },
  indent = { enable = true, disable = { 'yaml', 'css' } },
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
      -- "Cornsilk",
      -- "Salmon",
      -- "LawnGreen",
    },
    disable = { 'html' },
  },
  playground = {
    enable = true,
  },
})
