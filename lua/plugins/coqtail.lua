return {
  "whonore/Coqtail",
  ft = "coq",
  config = function()
    vim.g.coqtail_noimap = 1
    vim.g.coqtail_auto_set_proof_diffs = 'on'
  end,
}
