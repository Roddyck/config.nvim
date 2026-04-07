vim.pack.add({
  "https://github.com/folke/zen-mode.nvim",
  "https://github.com/folke/twilight.nvim",
})

vim.keymap.set("n", "<leader>zz", function()
  require("zen-mode").setup {
    window = {
      backdrop = 1,
      height = 0.9,
      width = 0.8,
      options = {
        number = false,
        relativenumber = false,
        signcolumn = "no",
        list = false,
        cursorline = false,
      },
    },
    require("zen-mode").toggle(),
  }

  require("twilight").setup {
    context = 10,
    treesitter = true,
  }
end)
