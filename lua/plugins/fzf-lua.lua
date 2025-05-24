return {
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "echasnovski/mini.icons" },
    config = function()
      local fzf_lua = require("fzf-lua")
      fzf_lua.setup({
        "default-title",

        fzf_colors = {
          true,
          bg = "-1",
          gutter = "-1",
        },

        keymap = {
          fzf = {
            true,
            ["ctrl-q"] = "select-all+accept",
          },
        },
      })

      vim.keymap.set("n", "<leader>pf", fzf_lua.files)
      vim.keymap.set("n", "<leader>ef", function()
        fzf_lua.files({ cwd = "~/personal/dev/env/.config/nvim" })
      end)
      vim.keymap.set("n", "<C-p>", fzf_lua.git_files)
      vim.keymap.set("n", "<leader>ps", fzf_lua.grep)
      vim.keymap.set("n", "<leader>lg", fzf_lua.live_grep)
      vim.keymap.set("n", "<leader>vh", fzf_lua.helptags)
    end,
  },
}
