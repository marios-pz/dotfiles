local err, g = pcall(require, "go")
if not err then
  return
end

g.setup({
  disable_defaults = false,                                 -- true|false when true set false to all boolean settings and replace all table
  -- settings with {}
  go = 'go',                                                -- go command, can be go[default] or go1.18beta1
  goimport = 'gopls',                                       -- goimport command, can be gopls[default] or goimport
  fillstruct = 'gopls',                                     -- can be nil (use fillstruct, slower) and gopls
  gofmt = 'gofumpt',                                        --gofmt cmd,
  max_line_len = 90,                                        -- max line length in golines format, Target maximum line length for golines
  tag_transform = false,                                    -- can be transform option("snakecase", "camelcase", etc) check gomodifytags for details and more options
  gotests_template = '',                                    -- sets gotests -template parameter (check gotests for details)
  gotests_template_dir = '',                                -- sets gotests -template_dir parameter (check gotests for details)
  comment_placeholder = 'ﳑ',                              -- comment_placeholder your cool placeholder e.g.       
  icons = false,
  verbose = false,                                          -- output loginf in messages
  lsp_cfg = true,                                           -- true: use non-default gopls setup specified in go/lsp.lua
  lsp_gofumpt = false,                                      -- true: set default gofmt in gopls format to gofumpt
  lsp_on_attach = require('pkgs.lsp.lsp-config').on_attach, -- nil: use on_attach function defined in go/lsp.lua,
  lsp_keymaps = false,                                      -- set to false to disable gopls/lsp keymap
  lsp_codelens = true,                                      -- set to false to disable codelens, true by default, you can use a function
  lsp_diag_hdlr = true,                                     -- hook lsp diag handler
  lsp_diag_underline = true,
  lsp_diag_virtual_text = { space = 0, prefix = '' },
  lsp_diag_signs = true,
  lsp_diag_update_in_insert = false,
  lsp_document_formatting = true,
  lsp_inlay_hints = {
    enable = true,
    only_current_line = false,
    only_current_line_autocmd = 'CursorHold',
    show_variable_name = true,
    parameter_hints_prefix = ' ',
    show_parameter_hints = true,
    other_hints_prefix = '=> ',
    max_len_align = false,
    max_len_align_padding = 1,
    right_align = false,
    right_align_padding = 6,
    highlight = 'Comment',
  },
  gopls_remote_auto = true, -- add -remote=auto to gopls
  gocoverage_sign = '█',
  sign_priority = 5,        -- change to a higher number to override other signs
  dap_debug = false,        -- set to false to disable dap
  dap_debug_keymap = false, -- true: use keymap for debugger defined in go/dap.lua
  dap_debug_gui = true,     -- set to true to enable dap gui, highly recommend
  dap_debug_vt = true,      -- set to true to enable dap virtual text
  build_tags = 'tag1,tag2', -- set default build tags
  textobjects = true,       -- enable default text jobects through treesittter-text-objects
  test_runner = 'go',       -- one of {`go`, `richgo`, `dlv`, `ginkgo`, `gotestsum`}
  verbose_tests = true,     -- set to add verbose flag to tests
  run_in_floaterm = false,  -- set to true to run in float window. :GoTermClose closes the floatterm
  -- float term recommend if you use richgo/ginkgo with terminal color

  trouble = false,  -- true: use trouble to open quickfix
  test_efm = false, -- errorfomat for quickfix, default mix mode, set to true will be efm only
  luasnip = false,  -- enable included luasnip snippets. you can also disable while add lua/snips folder to luasnip load
  --  Do not enable this if you already added the path, that will duplicate the entries
})
