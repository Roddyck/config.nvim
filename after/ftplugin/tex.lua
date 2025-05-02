vim.opt.spelllang = "en_us"
vim.opt.spell = true
vim.keymap.set("i", "<C-l>", "<c-g>u<ESC>[s1z=`a]<c-g>u", { buffer = 0, noremap = true })

-- create or edit inkscape figure
vim.keymap.set('i', '<C-b>', "<Esc>: silent exec '.!inkscape-figures create \"'.getline('.').'\" \"'.b:vimtex.root.'/figures/\"'<CR><CR>:w<CR>", { noremap = true })
vim.keymap.set("n", "<C-b>", ": silent exec '!inkscape-figures edit \"'.b:vimtex.root.'/figures/\" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>", { silent = true, noremap = true})
