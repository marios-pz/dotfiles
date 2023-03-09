require("options")
require("utils")
require("keybinds")
require("plugins")
require("./pkgs/which-key")
require("./pkgs/bufferline")
require("./pkgs/dap")
require("./pkgs/autocommands")

-- mason
require("./pkgs/lsp/mason")

-- lsp
require("./pkgs/lsp/cmp")
require("./pkgs/lsp/null-ls")
require("./pkgs/lsp/lsp-config")
require("./pkgs/lsp/lsp-signature")

-- Convenience
require("./pkgs/convenience/vim-surround")
require("./pkgs/convenience/renamer")
require("./pkgs/convenience/comment")
require("./pkgs/convenience/ranger")
require("./pkgs/convenience/go-nvim")
require("./pkgs/convenience/harpoon")
require("./pkgs/convenience/indent")
require("./pkgs/autopairs")


-- My colorscheme
vim.cmd.colorscheme("tokyonight-storm")
require('impatient').enable_profile()
require("todo-comments").setup()
