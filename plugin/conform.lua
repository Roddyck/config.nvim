vim.pack.add({
  { src = "https://github.com/stevearc/conform.nvim" },
})

vim.keymap.set("n", "<leader>f", function()
  require("conform").format({ bufnr = 0 })
end)

-- This will provide type hinting with LuaLS
---@module "conform"
---@type conform.setupOpts
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    go = { "gofmt" },
    -- Conform will run the first available formatter
    javascript = { "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "prettierd", "prettier", stop_after_first = true },
    typescript = { "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "prettierd", "prettier", stop_after_first = true },
  },

  default_format_opts = {
    lsp_format = "fallback",
  },
})
