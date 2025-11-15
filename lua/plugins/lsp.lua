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

    vim.lsp.enable("racket_langserver")

    vim.lsp.config("*", {
      capabilities = capabilities,
    })

    vim.lsp.config("svelte", {
      cmd = { "svelteserver", "--stdio" },
      filetypes = { "svelte" },
      root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        -- Svelte LSP only supports file:// schema. https://github.com/sveltejs/language-tools/issues/2777
        if vim.uv.fs_stat(fname) ~= nil then
          local root_markers =
            { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock", "deno.lock" }
          root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers, { ".git" } }
            or vim.list_extend(root_markers, { ".git" })
          -- We fallback to the current working directory if no project root is found
          local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()
          on_dir(project_root)
        end
      end,
      on_attach = function(client, bufnr)
        -- Workaround to trigger reloading JS/TS files
        -- See https://github.com/sveltejs/language-tools/issues/2008
        vim.api.nvim_create_autocmd("BufWritePost", {
          pattern = { "*.js", "*.ts" },
          group = vim.api.nvim_create_augroup("lspconfig.svelte", {}),
          callback = function(ctx)
            -- internal API to sync changes that have not yet been saved to the file system
            client:notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
          end,
        })
        vim.api.nvim_buf_create_user_command(bufnr, "LspMigrateToSvelte5", function()
          client:exec_cmd({
            title = "Migrate Component to Svelte 5 Syntax",
            command = "migrate_to_svelte_5",
            arguments = { vim.uri_from_bufnr(bufnr) },
          })
        end, { desc = "Migrate Component to Svelte 5 Syntax" })
      end,
    })

    vim.lsp.config("lua_ls", {
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if
            path ~= vim.fn.stdpath("config")
            and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc")) ---@diagnostic disable-line: undefined-field
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
        exportPdf = "onType",
      },
    })

    blink.setup({
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
