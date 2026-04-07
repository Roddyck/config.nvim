vim.pack.add({ "https://github.com/folke/trouble.nvim" })

vim.keymap.set("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>")
vim.keymap.set("n", "[t", "<cmd>Trouble diagnostics next skip_groups=true jump=true<cr>")
vim.keymap.set("n", "]t", "<cmd>Trouble diagnostics prev skip_groups=true jump=true<cr>")
vim.keymap.set("n", "<leader>tT", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>")
vim.keymap.set("n", "<leader>tQ", "<cmd>Trouble qflist toggle<cr>")
