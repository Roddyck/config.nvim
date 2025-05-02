require("luasnip.session.snippet_collection").clear_snippets "typst"

local ls = require "luasnip"

local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local t = ls.text_node
local r = ls.restore_node
local sn = ls.snippet_node
local d = ls.dynamic_node

local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local postfix = require("luasnip.extras.postfix").postfix
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep

local conds_expand = require("luasnip.extras.conditions.expand")

ls.add_snippets("typst", {
    s("mk", fmt("${}$ {}", { i(1), i(0) })),
    s("dm", fmt(
        [[
        $
        {}
        $
        {}
        ]],
        { i(1), i(0) })
    ),
    s("cc", t("subset")),
}, {
    type = "autosnippets",
})
