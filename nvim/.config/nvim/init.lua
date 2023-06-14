require("options")
require("utils")
require("keybinds")
require("plugins")

-- mason
require("pkgs.lsp.mason")

-- lsp
require("pkgs.lsp.cmp")
require("pkgs.lsp.null-ls")
require("pkgs.lsp.lsp-config")
require("pkgs.lsp.lsp-signature")
require("pkgs.lsp.treesitter")
require("pkgs.lsp.lsp-config").setup()
require("pkgs.lsp.lsps")
require("pkgs.lsp.neotest")

-- Convenience
require("pkgs.convenience.vim-surround")
require("pkgs.convenience.renamer")
require("pkgs.convenience.comment")
require("pkgs.convenience.harpoon")
require("pkgs.convenience.indent")
require("pkgs.autopairs")
require("todo-comments").setup()

require("pkgs.bufferline")
require("pkgs.autocommands")
require("pkgs.dap")
require("pkgs.noice")
require("pkgs.trouble")
require("pkgs.which-key")
require('impatient').enable_profile()
vim.cmd.colorscheme("tokyonight-storm")
