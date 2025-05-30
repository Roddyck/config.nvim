return {
  "stevearc/conform.nvim",
  opts = {},
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        go = { "gofmt" },
      },

      default_format_opts = {
        lsp_format = "fallback",
      },
    })
  end,
}
