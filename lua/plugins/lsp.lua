return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- LSP Support
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    -- Autocompletion
    {
      "saghen/blink.cmp",
      version = "1.*",
    },

    -- Snippets
    "L3MON4D3/LuaSnip",
  },
  config = function()
    local blink = require("blink.cmp")
    local capabilities =
      vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), blink.get_lsp_capabilities())

    require("mason").setup({})
    require("mason-lspconfig").setup({
      ensure_installed = {
        "vtsls",
        "pyright",
        "clangd",
        "lua_ls",
        "gopls",
        "rust_analyzer",
      },
    })

    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    vim.lsp.config("lua_ls", {
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if
            path ~= vim.fn.stdpath("config")
            and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
          then
            return
          end
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
          runtime = {
            -- Tell the language server which version of Lua you're using (most
            -- likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
            -- Tell the language server how to find Lua modules same way as Neovim
            -- (see `:h lua-module-load`)
            path = {
              "lua/?.lua",
              "lua/?/init.lua",
            },
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              -- Depending on the usage, you might want to add additional paths
              -- here.
              -- '${3rd}/luv/library'
              -- '${3rd}/busted/library'
            },
            -- Or pull in all of 'runtimepath'.
            -- NOTE: this is a lot slower and will cause issues when working on
            -- your own configuration.
            -- See https://github.com/neovim/nvim-lspconfig/issues/3189
            -- library = {
            --   vim.api.nvim_get_runtime_file('', true),
            -- }
          },
        })
      end,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim", "it", "describe", "before_each", "after_each" },
          },
        },
      },
    })

    vim.lsp.config("tinymist", {
      settings = {
        formatterMode = "typstyle",
        exportPdf = "onSave",
      },
    })

    blink.setup({
      keymap = { preset = "default" },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },

      completion = {
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

    vim.diagnostic.config({
      -- update_in_insert = true,
      virtual_text = true,
      float = {
        border = "rounded",
        source = true,
        header = "",
        prefix = "",
      },
    })
  end,
}
