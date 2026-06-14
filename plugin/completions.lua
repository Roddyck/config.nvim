vim.pack.add({
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("1.*"),
  },

  {
    src = "https://github.com/L3MON4D3/LuaSnip",
    -- follow latest release.
    version = vim.version.range("2.*"), -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  },

  { src = "https://github.com/folke/lazydev.nvim" },

  { src = "https://github.com/onsails/lspkind.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
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

    menu = {
      scrollbar = false,
      draw = {
        components = {
          kind_icon = {
            text = function(ctx)
              local icon = ctx.kind_icon
              if vim.tbl_contains({ "Path" }, ctx.source_name) then
                local dev_icon = require("nvim-web-devicons").get_icon(ctx.label)
                if dev_icon then
                  icon = dev_icon
                end
              else
                icon = require("lspkind").symbol_map[ctx.kind] or ""
              end

              return icon .. ctx.icon_gap
            end,

            highlight = function(ctx)
              local hl = ctx.kind_hl
              if vim.tbl_contains({ "Path" }, ctx.source_name) then
                local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                if dev_icon then
                  hl = dev_hl
                end
              end
              return hl
            end,
          },
        },
      },
    },
  },

  snippets = { preset = "luasnip" },
  sources = {
    default = { "lazydev", "lsp", "path", "snippets", "buffer" },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        -- make lazydev completions top priority (see `:h blink.cmp`)
        score_offset = 100,
      },
    },
  },

  fuzzy = { implementation = "prefer_rust_with_warning" },
})
