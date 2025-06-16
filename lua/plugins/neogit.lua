return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional - Diff integration

    "ibhagwan/fzf-lua", -- optional
  },
  config = function()
    require("neogit").setup({
      kind = "split_above",
    })

    vim.keymap.set("n", "<leader>gs", vim.cmd.Neogit)
  end,
}
