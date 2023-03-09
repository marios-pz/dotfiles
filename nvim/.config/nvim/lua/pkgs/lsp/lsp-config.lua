local utils = require("utils")

local function lsp_options(buffer)
  vim.api.nvim_buf_set_option(buffer, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

local function lsp_keymaps(bufnr)
  local create_command = utils.create_command
  local command = utils.command

  local buf_keymap = function(mode, lhs, rhs, bufnr)
    local opts = {
      buffer = bufnr or true,
      silent = true,
    }
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  buf_keymap("n", "gD", vim.lsp.buf.declaration)
  buf_keymap("n", "gd", vim.lsp.buf.definition)
  buf_keymap("n", "K", vim.lsp.buf.hover)
  buf_keymap("n", "gi", vim.lsp.buf.implementation)
  buf_keymap("n", "<C-k>", vim.lsp.buf.signature_help)
  buf_keymap("n", "<leader>rn", vim.lsp.buf.rename)
  buf_keymap("n", "gr", function()
    command("Telescope lsp_references")
  end)

  buf_keymap("n", "[d", function()
    vim.diagnostic.goto_prev({ border = "rounded" })
  end)

  buf_keymap("n", "gl", function()
    vim.diagnostic.open_float(0, { scope = "line", border = "rounded" })
  end)

  buf_keymap("n", "]d", function()
    vim.diagnostic.goto_next({ border = "rounded" })
  end)

  buf_keymap("v", "<leader>a", function()
    command("CodeActionMenu")
  end)

  -- create_command("Format", vim.lsp.buf.formatting, { bang = true })
  create_command("Format", function()
  end, { bang = true })
end

local M = {}
M.setup = function()
  local icons = require("pkgs.icons")
  local signs = {
    { name = "DiagnosticSignError", text = icons.diagnostics.Error },
    { name = "DiagnosticSignWarn",  text = icons.diagnostics.Warning },
    { name = "DiagnosticSignHint",  text = icons.diagnostics.Hint },
    { name = "DiagnosticSignInfo",  text = icons.diagnostics.Information },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end
  local config = {
    virtual_text = false,
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

M.on_attach = function(client, bufnr)
  if client.name == "lua_ls" then
    client.server_capabilities.document_formatting = false
  end
  lsp_options(bufnr)
  lsp_keymaps(bufnr)

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("LspFormatting", { clear = true }),
    callback = function()
      vim.lsp.buf.format { async = true }
    end
  })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
