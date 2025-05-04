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
    s("template", t(
        [[
        #import "@preview/rose-pine:0.2.0": apply, rose-pine
        #import "@preview/fletcher:0.5.7" as fletcher: diagram, node, edge
        #show: apply()

        #show ref: it => {
            let eq = math.equation
            let el = it.element
            if el != none and el.func() == eq {
                // Override equation references.
                link(el.location(),numbering(
                    el.numbering,
                    ..counter(eq).at(el.location())
                ))
            } else {
                // Other references as usual.
                it
            }
        }

        #let num_eq(content) = math.equation(
            block: true,
            numbering: "(1)",
            content,
        )

        #let theorem(num, contents) = [
        #block(
            stroke: rose-pine.rose,
            inset: 1em,
            width: 100%,
            fill: gradient.linear(rose-pine.pine, rose-pine.love, angle: 30deg)
        )[
        *Теорема #num.* #contents
        ]
        ]

        #let definition(contents) = [
        #block(
            stroke: rose-pine.rose,
            inset: 1em,
            width: 100%,
            fill: gradient.linear(rose-pine.pine, rose-pine.love, angle: 30deg)
        )[
        *Определение.* #contents
        ]
        ]

        #let qedsymbol = [
        #align(right)[
        #square(size: 0.6em, stroke: 0.5pt + rose-pine.base, fill: rose-pine.text)
        ]
        ]
        ]])
    ),
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
