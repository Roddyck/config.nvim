vim.pack.add({
  { src = "https://github.com/NeogitOrg/neogit" },
  { src = "https://github.com/nvim-lua/plenary.nvim" }, -- required
  { src = "https://github.com/sindrets/diffview.nvim" }, -- optional - Diff integration
  { src = "https://github.com/sindrets/ibhagwan/fzf-lua" }, -- optional
})

vim.keymap.set("n", "<leader>gs", "<cmd>Neogit<cr>", { desc = "Neogit" })
