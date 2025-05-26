return {
  {
    "folke/zen-mode.nvim",
    config = function()
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
    end,
  },

  {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {
        context = -1,
        treesitter = true,
      }
    end,
  },
}
