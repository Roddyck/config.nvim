vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(event)
    local name, kind = event.data.spec.name, event.data.kind
    if name == "telescope-fzf-native.nvim" and (kind == "install" or kind == "update") then
      vim.system({ "make" }, { cwd = event.data.path })
    end
  end,
})

vim.pack.add({
  {
    src = "https://github.com/nvim-telescope/telescope.nvim",
    version = vim.version.range("0.2.*"),
  },

  {
    src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
  },

  { src = "https://github.com/nvim-lua/plenary.nvim" },
})

require("telescope").setup({
  pickers = {
    find_files = {
      theme = "ivy",
    },
    git_files = {
      theme = "ivy",
    },
    grep_string = {
      theme = "ivy",
    },
    live_grep = {
      theme = "ivy",
    },
    help_tags = {
      theme = "ivy",
    },
  },
})

require("telescope").load_extension("fzf")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>pf", builtin.find_files)
vim.keymap.set("n", "<leader>ef", function()
  builtin.find_files({ cwd = "~/personal/dev/env/.config/nvim" })
end)
vim.keymap.set("n", "<C-p>", builtin.git_files)
vim.keymap.set("n", "<leader>ps", builtin.grep_string)
vim.keymap.set("n", "<leader>lg", builtin.live_grep)
vim.keymap.set("n", "<leader>vh", builtin.help_tags)
