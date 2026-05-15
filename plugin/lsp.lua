vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },

  { src = "https://github.com/j-hui/fidget.nvim" },

  -- Autocompletion
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("1.*"),
  },

  -- setup lua_ls for lazy people
  { src = "https://github.com/folke/lazydev.nvim" },

  -- typescript...
  { src = "https://github.com/pmizio/typescript-tools.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
})

require("lazydev").setup({
  library = {
    -- See the configuration section for more details
    -- Load luvit types when the `vim.uv` word is found
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
})

-- servers with additional configuration, empty table if no config
local servers = {
  lua_ls = {},

  tinymist = {
    settings = {
      formatterMode = "typstyle",
      exportPdf = "onType",
    },
  },

  svelte = {},
  clangd = {},
  gopls = {},
  tailwindcss = {},
}

require("fidget").setup({})

local blink = require("blink.cmp")
local capabilities =
  vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), blink.get_lsp_capabilities())

vim.lsp.config("*", {
  capabilities = capabilities,
})

-- enable and configure servers
for server, config in pairs(servers) do
  if next(config) ~= nil then
    vim.lsp.config(server, config)
  end

  vim.lsp.enable(server)
end

vim.diagnostic.config({
  -- update_in_insert = true,
  virtual_text = true,
  virtual_lines = false,
  float = {
    source = true,
    header = "",
    prefix = "",
  },
})

vim.keymap.set("n", "<leader>vl", function()
  local config = vim.diagnostic.config() or {}
  if config.virtual_text then
    vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
  else
    vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
  end
end)

require("typescript-tools").setup {
  settings = {
    -- spawn additional tsserver instance to calculate diagnostics on it
    separate_diagnostic_server = true,
    -- "change"|"insert_leave" determine when the client asks the server about diagnostic
    publish_diagnostic_on = "insert_leave",
    -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
    complete_function_calls = true,
    include_completions_with_insert_text = true,
    code_lens = "off",
    disable_member_code_lens = true,
    jsx_close_tag = {
      enable = false,
      filetypes = { "javascriptreact", "typescriptreact" },
    },
    tsserver_file_preferences = {
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      includeInlayVariableTypeHints = true,
      includeInlayVariableTypeHintsWhenTypeMatchesName = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayEnumMemberValueHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeCompletionsForModuleExports = true,
      includeCompletionsForImportStatements = true,
    },
  },
}

local group = vim.api.nvim_create_augroup("custom-lsp", {})
vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(e)
    local opts = { buffer = e.buf }
    vim.keymap.set("n", "gd", function()
      vim.lsp.buf.definition()
    end, opts)
    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover()
    end, opts)
    vim.keymap.set("n", "<leader>vws", function()
      vim.lsp.buf.workspace_symbol()
    end, opts)
    vim.keymap.set("n", "<leader>vd", function()
      vim.diagnostic.open_float()
    end, opts)
    vim.keymap.set("n", "<leader>vca", function()
      vim.lsp.buf.code_action()
    end, opts)
    vim.keymap.set("n", "<leader>vrr", function()
      vim.lsp.buf.references()
    end, opts)
    vim.keymap.set("n", "<leader>vrn", function()
      vim.lsp.buf.rename()
    end, opts)
    vim.keymap.set("i", "<C-h>", function()
      vim.lsp.buf.signature_help()
    end, opts)
    vim.keymap.set("n", "[d", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, opts)
    vim.keymap.set("n", "]d", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, opts)
  end,
})
