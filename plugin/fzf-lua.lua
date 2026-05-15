vim.pack.add({
  { src = "https://github.com/ibhagwan/fzf-lua" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
})

local fzf = require("fzf-lua")
fzf.setup({
  "telescope",

  fzf_colors = true,
  ui_select = true,

  fzf_opts = {
    ["--no-scrollbar"] = true,
  },

  winopts = {
    title_flags = false,
  },
})

vim.keymap.set("n", "<leader>pf", fzf.files)
vim.keymap.set("n", "<leader>ef", function()
  fzf.files({ cwd = "~/personal/dev/env/.config/nvim" })
end)
vim.keymap.set("n", "<C-p>", fzf.git_files)
vim.keymap.set("n", "<leader>ps", fzf.grep)
vim.keymap.set("n", "<leader>lg", require("custom.fzf-lua.live_grep_glob"))
vim.keymap.set("n", "<leader>vh", fzf.helptags)
