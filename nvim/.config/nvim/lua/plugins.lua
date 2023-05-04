local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    "folke/which-key.nvim",
    'folke/tokyonight.nvim',
    "nvim-tree/nvim-web-devicons",
    'sindrets/diffview.nvim',
    "mfussenegger/nvim-dap-python",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "jay-babu/mason-null-ls.nvim",
    'RRethy/vim-illuminate',
    "folke/todo-comments.nvim",

    -- Debugging
    "mfussenegger/nvim-dap",
    "theHamsta/nvim-dap-virtual-text",
    "rcarriga/nvim-dap-ui",

    -- CMP
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "neovim/nvim-lspconfig",
    "L3MON4D3/LuaSnip",
    "jose-elias-alvarez/null-ls.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "filipdutescu/renamer.nvim",
    "nvim-lualine/lualine.nvim",
    'ray-x/lsp_signature.nvim',

    -- Convenience
    "xiyaowong/nvim-transparent",
    'marioortizmanero/adoc-pdf-live.nvim',
    "lukas-reineke/indent-blankline.nvim",
    "ThePrimeagen/harpoon",
    "nvim-tree/nvim-tree.lua",
    'b0o/schemastore.nvim',
    "lewis6991/impatient.nvim",
    "rafamadriz/friendly-snippets",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "numToStr/Comment.nvim",
    "tpope/vim-surround",
    "windwp/nvim-autopairs",
    "akinsho/bufferline.nvim",
    "ray-x/guihua.lua",
    "ray-x/go.nvim",
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify"
        },
    },
    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({})
        end,
    },
    {
        'weilbith/nvim-code-action-menu',
        cmd = 'CodeActionMenu',
    },
    {
        "kosayoda/nvim-lightbulb",
        dependencies = 'antoinemadec/FixCursorHold.nvim',
    },
}

local opts = {}

require("lazy").setup(plugins, opts)
