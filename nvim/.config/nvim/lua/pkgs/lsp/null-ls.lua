local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/code_actions
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
  debug = false,
  sources = {
    -- formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
    formatting.black.with({
      args = { "--stdin-filename", "$FILENAME", "--quiet", "-", "--fast", "--line-length", "79" },
    }),
    -- formatting.stylua,
    formatting.shfmt,
    -- formatting.clang_format.with({ args = { '-style="{BasedOnStyle: llvm, IndentWidth: 4}"' } }),
    diagnostics.flake8,
    diagnostics.shellcheck,
    diagnostics.ansiblelint.with { filestypes = { "yaml", "yml" } },
    diagnostics.zsh,
    code_actions.shellcheck,
    formatting.golines.with({
      args = { '--max-len', '90' },
    }),
  },
})


local status_ok, ms = pcall(require, "mason-null-ls")

if not status_ok then
  vim.notify("ms " .. ms .. " not found!")
  return
end

ms.setup({
  automatic_setup = true
})


local status_ok, bulb = pcall(require, 'nvim-lightbulb')

if not status_ok then
  vim.notify("bulb " .. bulb .. " not found!")
  return
else
  vim.cmd [[autocmd CursorHold,CursorHoldI * lua require('nvim-lightbulb').update_lightbulb()]]
end

-- Showing defaults
bulb.setup({
  -- LSP client names to ignore
  -- Example: {"sumneko_lua", "null-ls"}
  ignore = {},
  sign = {
    enabled = true,
    -- Priority of the gutter sign
    priority = 10,
  },
  float = {
    enabled = false,
    -- Text to show in the popup float
    text = "💡",
    -- Available keys for window options:
    -- - height     of floating window
    -- - width      of floating window
    -- - wrap_at    character to wrap at for computing height
    -- - max_width  maximal width of floating window
    -- - max_height maximal height of floating window
    -- - pad_left   number of columns to pad contents at left
    -- - pad_right  number of columns to pad contents at right
    -- - pad_top    number of lines to pad contents at top
    -- - pad_bottom number of lines to pad contents at bottom
    -- - offset_x   x-axis offset of the floating window
    -- - offset_y   y-axis offset of the floating window
    -- - anchor     corner of float to place at the cursor (NW, NE, SW, SE)
    -- - winblend   transparency of the window (0-100)
    win_opts = {},
  },
  virtual_text = {
    enabled = false,
    -- Text to show at virtual text
    text = "💡",
    hl_mode = "replace",
  },
  status_text = {
    enabled = false,
    text = "💡",
    text_unavailable = ""
  },
  autocmd = {
    enabled = false,
    pattern = { "*" },
    events = { "CursorHold", "CursorHoldI" }
  }
})
