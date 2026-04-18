vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },

  -- Autocompletion
  {
    src = "https://github.com/saghen/blink.cmp",
    version = vim.version.range("1.*"),
  },

  {
    src = "https://github.com/j-hui/fidget.nvim",
  },
})

-- servers with additional configuration, empty table if no config
-- TODO: actually install svelte-language-server
local servers = {
  lua_ls = {
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
          },
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
  },

  tinymist = {
    settings = {
      formatterMode = "typstyle",
      exportPdf = "onType",
    },
  },

  -- svelte = {
  --   cmd = { "svelteserver", "--stdio" },
  --   filetypes = { "svelte" },
  --   root_dir = function(bufnr, on_dir)
  --     local fname = vim.api.nvim_buf_get_name(bufnr)
  --     -- Svelte LSP only supports file:// schema. https://github.com/sveltejs/language-tools/issues/2777
  --     if vim.uv.fs_stat(fname) ~= nil then
  --       local root_markers =
  --         { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock", "deno.lock" }
  --       root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers, { ".git" } }
  --         or vim.list_extend(root_markers, { ".git" })
  --       -- We fallback to the current working directory if no project root is found
  --       local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()
  --       on_dir(project_root)
  --     end
  --   end,
  --   on_attach = function(client, bufnr)
  --     -- Workaround to trigger reloading JS/TS files
  --     -- See https://github.com/sveltejs/language-tools/issues/2008
  --     vim.api.nvim_create_autocmd("BufWritePost", {
  --       pattern = { "*.js", "*.ts" },
  --       group = vim.api.nvim_create_augroup("lspconfig.svelte", {}),
  --       callback = function(ctx)
  --         -- internal API to sync changes that have not yet been saved to the file system
  --         client:notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
  --       end,
  --     })
  --     vim.api.nvim_buf_create_user_command(bufnr, "LspMigrateToSvelte5", function()
  --       client:exec_cmd({
  --         title = "Migrate Component to Svelte 5 Syntax",
  --         command = "migrate_to_svelte_5",
  --         arguments = { vim.uri_from_bufnr(bufnr) },
  --       })
  --     end, { desc = "Migrate Component to Svelte 5 Syntax" })
  --   end,
  -- },
}

require("fidget").setup()

local blink = require("blink.cmp")
local capabilities =
  vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), blink.get_lsp_capabilities())

vim.lsp.config("*", {
  capabilities = capabilities,
})

-- enable and configure servers
for server, config in pairs(servers) do
  if next(config) ~= nil then
    vim.lsp.config(server, config)
  end

  vim.lsp.enable(server)
end

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

local group = vim.api.nvim_create_augroup("RoddykLsp", {})
vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(e)
    local opts = { buffer = e.buf }
    vim.keymap.set("n", "gd", function()
      vim.lsp.buf.definition()
    end, opts)
    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover()
    end, opts)
    vim.keymap.set("n", "<leader>vws", function()
      vim.lsp.buf.workspace_symbol()
    end, opts)
    vim.keymap.set("n", "<leader>vd", function()
      vim.diagnostic.open_float()
    end, opts)
    vim.keymap.set("n", "<leader>vca", function()
      vim.lsp.buf.code_action()
    end, opts)
    vim.keymap.set("n", "<leader>vrr", function()
      vim.lsp.buf.references()
    end, opts)
    vim.keymap.set("n", "<leader>vrn", function()
      vim.lsp.buf.rename()
    end, opts)
    vim.keymap.set("i", "<C-h>", function()
      vim.lsp.buf.signature_help()
    end, opts)
    vim.keymap.set("n", "[d", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, opts)
    vim.keymap.set("n", "]d", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, opts)
  end,
})
