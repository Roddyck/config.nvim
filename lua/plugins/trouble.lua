return {
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  keys = {
    {
      "<leader>tt",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "[t",
      "<cmd>Trouble diagnostics next skip_groups=true jump=true<cr>",
      desc = "Next Diagnostic (Trouble)",
    },
    {
      "]t",
      "<cmd>Trouble diagnostics prev skip_groups=true jump=true<cr>",
      desc = "Previous Diagnostic (Trouble)",
    },
    {
      "<leader>tT",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>tQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
}
