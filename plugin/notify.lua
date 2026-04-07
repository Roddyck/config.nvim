vim.pack.add({
  { src = "https://github.com/rcarriga/nvim-notify" }
})

vim.notify = require "notify"
require("notify").setup {
  background_colour = "#000000",
}
