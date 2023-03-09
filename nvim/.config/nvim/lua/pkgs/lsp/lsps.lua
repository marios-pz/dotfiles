local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local on_attach = require("pkgs.lsp.lsp-config").on_attach
local capabilities = require("pkgs.lsp.lsp-config").capabilities

lspconfig.bashls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {},
})

lspconfig.dockerls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {},
})

lspconfig.svelte.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
})

lspconfig.angularls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
})

lspconfig.ansiblels.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {},
  filetypes = { "yaml", "yaml.ansible", "ansible" },
}

lspconfig.yamlls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    yaml = {
      schemaStore = {
        enable = true,
      },
    },
  },
  flags = {
    debounce_text_changes = 150,
  },
})

lspconfig.terraformls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
})

lspconfig.tsserver.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    javascript = {
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
    typescript = {
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
  },
})

lspconfig.jsonls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
      },
    },
    setup = {
      commands = {
        Format = {
          function()
            vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line('$'), 0 })
          end,
        },
      },
    },
  }
  ,
})

lspconfig.ccls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
  cmd = { "ccls", "--log-file=/tmp/ccls.log", "--gcc=/usr/bin/gcc", "--g++=/usr/bin/g++" },
  init_options = {
    cache = {
      directory = ".ccls-cache",
    },
  },
})


lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = 'strict',
        inlayHints = {
          variableTypes = true,
          functionReturnTypes = true,
        },
      },
    },
  }
  ,
})

lspconfig.jdtls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
})

local db_url = os.getenv("DB_NAME") or ""
local db_name = os.getenv("DB_USER") or ""
local db_passwd = os.getenv("DB_PASSWD") or ""

lspconfig.sqlls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    sqlls = {
      connections = {
        {
          driver = "postgres",
          url = "jdbc:postgresql://localhost:5432/" .. db_url,
          defaultSchema = db_url,
          username = db_name,
          password = db_passwd,
        },
      },
    },
  },
})

lspconfig.gopls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    filetypes = { "go", "gomod", "gohtmltmpl", "gotexttmpl" },
    message_level = vim.lsp.protocol.MessageType.Error,
    cmd = {
      "gopls",                              -- share the gopls instance if there is one already
      "-remote=auto", --[[ debug options ]] --
      -- "-logfile=auto",
      -- "-debug=:0",
      "-remote.debug=:0",
      -- "-rpc.trace",
    },
    flags = { allow_incremental_sync = true, debounce_text_changes = 1000 },
    settings = {
      gopls = {
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        -- more settings: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
        -- flags = {allow_incremental_sync = true, debounce_text_changes = 500},
        -- not supported
        analyses = { unusedparams = true, unreachable = false },
        codelenses = {
          generate = true,   -- show the `go generate` lens.
          gc_details = true, --  // Show a code lens toggling the display of gc's choices.
          test = true,
          tidy = true,
        },
        usePlaceholders = true,
        completeUnimported = true,
        staticcheck = true,
        matcher = "fuzzy",
        diagnosticsDelay = "500ms",
        experimentalWatchedFileDelay = "1000ms",
        symbolMatcher = "fuzzy",
        gofumpt = true, -- true, -- turn on for new repos, gofmpt is good but also create code turmoils
        buildFlags = { "-tags", "integration" },
        expandWorkspaceToModule = true,
      },
    },
  },
})

lspconfig.lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      format = {
        enable = true,
      },
      hint = {
        enable = true,
        arrayIndex = 'All', -- "Enable", "Auto", "Disable"
        await = true,
        paramName = 'All',  -- "All", "Literal", "Disable"
        paramType = false,
        semicolon = 'All',  -- "All", "SameLine", "Disable"
        setType = true,
      },
      diagnostics = {
        globals = { "vim", "use", "require", "pcall", "pairs" },
      },
      workspace = {
        library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
      telemetry = {
        enable = false,
      },
    },
  }
  ,
})
