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
