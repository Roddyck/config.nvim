return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional - Diff integration

    "ibhagwan/fzf-lua", -- optional
  },
  keys = {
    { "<leader>gs", "<cmd>Neogit<cr>", desc = "Neogit" },

  },
  opts = {
    kind = "split_above",
  },
}
