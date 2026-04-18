vim.pack.add({
  { src = "https://github.com/ibhagwan/fzf-lua" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
})

local fzf = require("fzf-lua")
fzf.setup({
  "ivy",

  fzf_colors = true,

  fzf_opts = {
    ["--no-scrollbar"] = true,
  },

  winopts = {
    title_flags = false,
  },

  keymap = {
    fzf = {
      true,
      ["ctrl-q"] = "select-all+accept",
    },
  },

  files = {
    no_ignore = true, -- don't respect .gitignore, I use git_files for that instead
  },
})

vim.keymap.set("n", "<leader>pf", fzf.files)
vim.keymap.set("n", "<leader>ef", function()
  fzf.files({ cwd = "~/personal/dev/env/.config/nvim" })
end)
vim.keymap.set("n", "<C-p>", fzf.git_files)
vim.keymap.set("n", "<leader>ps", fzf.grep)
vim.keymap.set("n", "<leader>lg", fzf.live_grep)
vim.keymap.set("n", "<leader>vh", fzf.helptags)
