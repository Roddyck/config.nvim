return {
    'nvim-telescope/telescope.nvim',

    tag = '0.1.8',
    -- or                            , branch = '0.1.x',
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
        require('telescope').setup({
            extensions = {
                fzf = {}
            },
            pickers = {
                find_files = {
                    theme = "ivy"
                },
                git_files = {
                    theme = "ivy"
                },
            },
        })

        require('telescope').load_extension('fzf')

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<leader>ef', function ()
            builtin.find_files({ cwd = "~/.dotfiles/nvim/.config/nvim" })
        end)
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    end
}
