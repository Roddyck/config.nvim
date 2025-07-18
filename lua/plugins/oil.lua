-- Declare a global function to retrieve the current directory
function _G.get_oil_winbar()
  local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
  local dir = require("oil").get_current_dir(bufnr)
  if dir then
    return vim.fn.fnamemodify(dir, ":~")
  else
    -- If there is no current directory (e.g. over ssh), just show the buffer name
    return vim.api.nvim_buf_get_name(0)
  end
end

return {
  "stevearc/oil.nvim",
  opts = {
    keymaps = {
      ["<C-s>"] = false,
      ["<C-h>"] = false,
      ["<C-t>"] = false,
      ["<C-p>"] = false,
    },
    view_options = {
      show_hidden = true,
    },
    win_options = {
      winbar = "%!v:lua.get_oil_winbar()",
    },
  },
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  lazy = false,
}
