vim.pack.add({
  {
    src = "https://github.com/ThePrimeagen/harpoon",
    version = "harpoon2",
  },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
})

local harpoon = require "harpoon"

harpoon:setup()

vim.keymap.set("n", "<leader>A", function()
  harpoon:list():prepend()
end)
vim.keymap.set("n", "<leader>a", function()
  harpoon:list():add()
end)
vim.keymap.set("n", "<C-e>", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end)

for i = 1, 5 do
  vim.keymap.set("n", string.format("<leader>%d", i), function()
    harpoon:list():select(i)
  end)
end
