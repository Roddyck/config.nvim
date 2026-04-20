vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(event)
    local name, kind = event.data.spec.name, event.data.kind
    if name == "nvim-treesitter" and kind == "update" then
      if not event.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      vim.cmd("TSUpdate")
    end
  end,
})

vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

local ensure_installed = {
  "vimdoc",
  "jsdoc",
  "python",
  "javascript",
  "typescript",
  "c",
  "lua",
  "rust",
  "bash",
  "gitcommit",
}

require("nvim-treesitter").install(ensure_installed)

local group = vim.api.nvim_create_augroup("RoddykTreesitter", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
  group = group,
  callback = function(args)
    local bufnr = args.buf
    local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
    if not ok or not parser then
      return
    end
    pcall(vim.treesitter.start, 0)
  end,
})
