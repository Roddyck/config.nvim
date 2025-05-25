return {
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "echasnovski/mini.icons" },
    config = function()
      local fzf = require("fzf-lua")
      fzf.setup({
        "default-title",

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
      })

      vim.keymap.set("n", "<leader>pf", fzf.files)
      vim.keymap.set("n", "<leader>ef", function()
        fzf.files({ cwd = "~/personal/dev/env/.config/nvim" })
      end)
      vim.keymap.set("n", "<C-p>", fzf.git_files)
      vim.keymap.set("n", "<leader>ps", fzf.grep)
      vim.keymap.set("n", "<leader>lg", fzf.live_grep)
      vim.keymap.set("n", "<leader>vh", fzf.helptags)
    end,
  },
}
