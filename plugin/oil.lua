vim.pack.add({
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
})

require('oil').setup({
  keymaps = {
    ["<C-s>"] = false,
    ["<C-h>"] = false,
    ["<C-t>"] = false,
    ["<C-p>"] = false,
  },
  view_options = {
    show_hidden = true,
  },
})
