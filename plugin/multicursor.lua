vim.pack.add({
  {
    src = "https://github.com/jake-stewart/multicursor.nvim",
    version = "1.0"
  }
})

local mc = require("multicursor-nvim")
mc.setup()

vim.keymap.set({ "n", "x" }, "<up>", function() mc.lineAddCursor(-1) end)
vim.keymap.set({ "n", "x" }, "<down>", function() mc.lineAddCursor(1) end)
vim.keymap.set({ "n", "x" }, "<leader><up>", function() mc.lineSkipCursor(-1) end)
vim.keymap.set({ "n", "x" }, "<leader><down>", function() mc.lineSkipCursor(1) end)

vim.keymap.set({ "n", "x" }, "<leader>n", function() mc.matchAddCursor(1) end)
vim.keymap.set({ "n", "x" }, "<leader>s", function() mc.matchSkipCursor(1) end)
vim.keymap.set({ "n", "x" }, "<leader>N", function() mc.matchAddCursor(-1) end)
vim.keymap.set({ "n", "x" }, "<leader>S", function() mc.matchSkipCursor(-1) end)

vim.keymap.set({ "n", "x" }, "<c-q>", mc.toggleCursor)

mc.addKeymapLayer(function(layerSet)
  layerSet({ "n", "x" }, "<left>", mc.prevCursor)
  layerSet({ "n", "x" }, "<right>", mc.nextCursor)

  layerSet({ "n", "x" }, "<leader>q", mc.deleteCursor)

  layerSet("n", "<esc>", function()
    if not mc.cursorsEnabled() then
      mc.enableCursors()
    else
      mc.clearCursors()
    end
  end)
end)

local hl = vim.api.nvim_set_hl
hl(0, "MultiCursorCursor", { reverse = true })
hl(0, "MultiCursorVisual", { link = "Visual" })
hl(0, "MultiCursorSign", { link = "SignColumn" })
hl(0, "MultiCursorMatchPreview", { link = "Search" })
hl(0, "MultiCursorDisabledCursor", { reverse = true })
hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
