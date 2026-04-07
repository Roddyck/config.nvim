vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(event)
    local name, kind = event.data.spec.name, event.data.kind
    if name == "peek" and (kind == "install" or kind == "update") then
      vim.system({ "deno", "task", "--quiet", "build:fast" }, { cwd = event.data.path })
    end
  end,
})

vim.pack.add({
  { src = "https://github.com/toppair/peek.nvim" },
})

require("peek").setup({
  app = { "zen-browser", "--new-window" },
})

vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
