vim.pack.add({
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("1.*"),
  },

  {
    src = "https://github.com/L3MON4D3/LuaSnip",
    -- follow latest release.
    version = vim.version.range("v2.*"), -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  },
})

require("blink.cmp").setup({
  keymap = {
    preset = "default",

    ["<Tab>"] = false,
    ["<S-Tab>"] = false,
  },

  appearance = {
    -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- Adjusts spacing to ensure icons are aligned
    nerd_font_variant = "mono",
  },

  completion = {
    list = {
      selection = {
        preselect = true,
        auto_insert = false,
      },
    },

    -- Show documentation when selecting a completion item
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
    },
  },

  snippets = { preset = "luasnip" },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },

  fuzzy = { implementation = "prefer_rust_with_warning" },
})
