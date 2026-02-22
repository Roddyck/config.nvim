return {
  "whonore/Coqtail",
  ft = "coq",
  config = function()
    vim.g.coqtail_nomap = 1
    vim.keymap.set("n", "<leader>cc", "<cmd>RocqStart<cr>")
    vim.keymap.set("n", "<leader>cq", "<cmd>RocqStop<cr>")
    vim.keymap.set("n", "<leader>cj", "<cmd>RocqNext<cr>")
    vim.keymap.set("n", "<leader>ck", "<cmd>RocqUndo<cr>")
  end,
}
