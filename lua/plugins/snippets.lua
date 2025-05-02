return {
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",

        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            local ls = require("luasnip")
            ls.filetype_extend("javascript", { "jsdoc" })

            ls.config.set_config({
                history = true, -- keep around last snippet local to jump back
                enable_autosnippets = true,})

            require("luasnip.loaders.from_vscode").lazy_load()

            -- vim.keymap.set({"i"}, "<C-s>e", function() ls.expand() end, {silent = true})

            for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/snippets/*.lua", true)) do
                loadfile(ft_path)()
            end

            vim.keymap.set({ "i", "s" }, "<C-k>", function()
               if ls.expand_or_jumpable() then
                   ls.expand_or_jump()
                end
            end, {silent = true})

            -- vim.keymap.set({"i", "s"}, "<C-s>;", function() ls.jump(1) end, {silent = true})

            vim.keymap.set({"i", "s"}, "<C-j>", function()
                if ls.jumpable(-1) then
                    ls.jump(-1)
                end
            end, {silent = true})

            vim.keymap.set({"i", "s"}, "<C-E>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end, {silent = true})

        end,
    }
}
