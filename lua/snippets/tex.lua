require("luasnip.session.snippet_collection").clear_snippets "tex"

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

local function math()
    return vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1
end

local mat = function(args, snip)
    local rows = tonumber(snip.captures[2])
    local cols = tonumber(snip.captures[3])
    local nodes = {}
    local ins_index = 1
    for j = 1, rows do
        table.insert(nodes, r(ins_index, tostring(j).."x1", i(1)))
        ins_index = ins_index+1
        for k = 2, cols do
            table.insert(nodes, t" & ")
            table.insert(nodes, r(ins_index, tostring(j).."x"..tostring(k), i(1)))
            ins_index = ins_index + 1
        end
        table.insert(nodes, t{"\\\\", ""})
    end
    return sn(nil, nodes)
end

ls.add_snippets("tex", {
    s("template",
        fmta(
            [[
            \documentclass[a4paper]{article}
            \usepackage[a4paper,%
                text={180mm, 260mm},%
                left=15mm, top=15mm]{geometry}
            \usepackage[utf8]{inputenc}
            \usepackage{cmap}
            \usepackage[english, russian]{babel}
            \usepackage{indentfirst}
            \usepackage{amssymb}
            \usepackage{amsmath}
            \usepackage{amsthm}
            \usepackage{mathtools}
            \usepackage{tcolorbox}
            \usepackage{import}
            \usepackage{xifthen}
            \usepackage{pdfpages}
            \usepackage{transparent}
            \usepackage{graphicx}
            \graphicspath{ {./figures} }

            \DeclarePairedDelimiter\set\{\}

            \newcommand{\incfig}[1]{%
            \def\svgwidth{\columnwidth}
            \import{./figures/}{#1.pdf_tex}
            }

            \newtheorem*{theorem}{Теорема}
            \newtheorem*{statement}{Утверждение}
            \newtheorem*{lemma}{Лемма}
            \newtheorem*{proposal}{Предложение}
            \newtheorem*{consequence}{Следствие}


            \theoremstyle{definition}
            \newtheorem*{definition}{Определение}

            \theoremstyle{remark}
            \newtheorem*{remark}{Замечание}

            \renewcommand\qedsymbol{$\blacksquare$}

            \begin{document}
            <>
            \end{document}
            ]],
            { i(0) }),
            { condition=conds_expand.line_begin }
    ),


    s("beg",
        fmta(
            [[
                \begin{<>}
                    <>
                \end{<>}
            ]],
            { i(1), i(0), rep(1) }),
            { condition=conds_expand.line_begin }
    ),

    s("mk", fmt("$ {} $ {}", { i(1), i(0) })),
    s("dm",
        fmt(
            [[
            \[
                {}
            \]
            ]],
            { i(0) })
    ),
    s("case",
        fmta(
            [[
                \begin{cases}
                    <>
                \end{cases}
            ]],
            { i(0) }),
            { condition=math }
    ),
    s("scase",
        fmta(
            [[
                \begin{align}
                \left[
                \begin{array}{ll}
                    <>
                \end{array}
                \right .
                \end{align}
            ]],
            { i(0) },
            { condition=math }
        )
    ),
    s("box",
        fmta(
            [[
                \begin{tcolorbox}
                <>
                \end{tcolorbox}
            ]],
            { i(0) }
        )
    ),

    s({ trig="=>", wordTrig=false }, t("\\implies"), { condition=math }),
    s({ trig="<=", wordTrig=false }, t("\\impliedby"), { condition=math }),
    s({ trig="iff", wordTrig=false }, t("\\iff"), { condition=math }),
    s({ trig="~~", wordTrig=false }, t("\\approx"), { condition=math }),
    s("!>", t("\\mapsto"), { condition=math }),
    s("**", t("\\cdot"), { condition=math }),
    s("xx", t("\\times"), { condition=math }),

    s("//", fmta("\\frac{<>}{<>} <>", { i(1), i(2), i(0) }), { condition=math }),
    s("fak", fmta("\\sfrac{<>}{<>} <>", { i(1), i(2), i(0) }), { condition=math }),
    s("d/dx", fmta("\\frac{\\partial <>}{\\partial <>} <>", { i(1, "u"), i(2, "x"), i(0) }), { condition=math }),
    s("dsq/dx", fmta("\\frac{\\partial^{2} <>}{\\partial <> \\partial <>} <>", { i(1, "u"), i(2, "x"), i(3, "y"), i(0) }), { condition=math }),

    s("ooo", t("\\infty"), { condition=math }),

    s("AA", t("\\forall"), { condition=math }),
    s("EE", t("\\exists"), { condition=math }),
    s("cc", t("\\subset"), { condition=math }),
    s("OO", t("\\varnothing"), { condition=math }),
    s("/\\", t("\\setminus"), { condition=math }),
    s("UU", t("\\cup"), { condition=math }),
    s("Nn", t("\\cap"), { condition=math }),
    s("uuu", fmta("\\bigcup_{<> \\in <>}", { i(1, "i"), i(2, "I") }), { condition=math }),

    s("norm", fmta("||<>||<>", {i(1), i(0)}), { condition=math }),

    s("RR", t("\\mathbb{R}"), { condition=math }),
    s("QQ", t("\\mathbb{Q}"), { condition=math }),
    s("CC", t("\\mathbb{C}"), { condition=math }),
    s("ZZ", t("\\mathbb{Z}"), { condition=math }),
    s("NN", t("\\mathbb{N}"), { condition=math }),

    s("inn", t("\\in"), { condition=math }),
    s("notin", t("\\notin"), { condition=math }),
    s("leq", t("\\leq"), { condition=math }),
    s("geq", t("\\geq"), { condition=math }),
    s("txt", fmta("\\text{<>}<>", { i(1), i(0) }), { condition=math }),

    s("xii", t("x_i"), { condition=math }),
    s("yii", t("y_i"), { condition=math }),
    s("utt", t("u_{tt}"), { condition=math }),
    s("uxx", t("u_{xx}"), { condition=math }),

    s({ trig="sr", wordTrig=false }, t("^2"), { condition=math }),
    s({ trig="cb", wordTrig=false }, t("^3"), { condition=math }),
    s({ trig="inv", wordTrig=false }, t("^{-1}"), { condition=math }),
    s({ trig="td", wordTrig=false }, fmta("^{<>}<>", { i(1), i(0) }), { condition=math }),

    s("fun", fmt("{}: {} \\to {}: {} {}", { i(1, "f"), i(2), i(3), i(4), i(0) }), { condition=math }),
    s("lim", fmta("\\lim_{<> \\to <>} <>", { i(1, "n"), i(2, "\\infty"), i(0)}), { condition=math }),
    s("sum", fmta("\\sum_{i=<>}^{<>} <>", { i(1, "1"), i(2, "\\infty"), i(0)}), { condition=math }),
    s("prod", fmta("\\prod_{i=<>}^{<>} <>", { i(1, "1"), i(2, "\\infty"), i(0)}), { condition=math }),
    s("dint", fmta("\\int_{<>}^{<>} <>", { i(1, "-\\infty"), i(2, "\\infty"), i(0)}), { condition=math }),
    s("sq", fmta("\\sqrt{<>} <>", { i(1), i(0) }), { condition=math }),

    s("fntop", fmt("{}: {} \\to {} {}",
        { i(1, "f"), i(2, "(X, \\tau)"), i(3, "(Y, \\omega)"), i(0) }),
        { condition=math }),

    s({ trig="__", wordTrig=false}, fmta("_{<>}<>", { i(1), i(0) }), { condition=math }),

    -- TODO:  Greek letters, maybe need to think about how i do them
    s("ff", t("\\phi"), { condition=math }),
    s("yy", t("\\psi"), { condition=math }),
    s("aa", t("\\alpha"), { condition=math }),
    s("bb", t("\\beta"), { condition=math }),
    s("tt", t("\\tau"), { condition=math }),
    s("qq", t("\\theta"), { condition=math }),
    s("omm", t("\\omega"), { condition=math }),
    s("ss", t("\\sigma"), { condition=math }),
    s("SS", t("\\Sigma"), { condition=math }),
    s("ll", t("\\lambda"), { condition=math }),

    postfix("tilde", { l("\\widetilde{" .. l.POSTFIX_MATCH .. "}") }),
    postfix("hat", { l("\\hat{" .. l.POSTFIX_MATCH .. "}") }, { condition=math }),
    postfix("bar", { l("\\overline{" .. l.POSTFIX_MATCH .. "}") }),
    postfix("under", { l("\\underline{" .. l.POSTFIX_MATCH .. "}") }),
    postfix("vec", { l("\\vec{" .. l.POSTFIX_MATCH .. "}") }),

    s({ trig='(%a)(%d)', regTrig=true, name='auto subscript', dscr='auto subscript'},
        fmt([[<>_<>]],
        { f(function(_, snip) return snip.captures[1] end),
        f(function(_, snip) return snip.captures[2] end) },
        { delimiters='<>' }),
        { condition=math }
    ),
    s({ trig='(%a)_(%d%d)', regTrig=true, name='auto subscript 2', dscr='auto subscript for 2+ digits'},
        fmt([[<>_{<>}]],
        { f(function(_, snip) return snip.captures[1] end),
        f(function(_, snip) return snip.captures[2] end)},
        { delimiters='<>' }),
        { condition=math }
    ),

    s({ trig="([bBpvV])mat(%d+)x(%d+)([ar])", regTrig=true, name="matrix"},
        fmta([[
        \begin{<>}<>
        <>
        \end{<>}]],
        { f(function(_, snip) return snip.captures[1] .. "matrix" end),
        f(function(_, snip)
            if snip.captures[4] == "a" then
                local out = string.rep("c", tonumber(snip.captures[3]) - 1)
                return "[" .. out .. "|c]"
            end
            return ""
        end),
        d(1, mat),
        f(function(_, snip) return snip.captures[1] .. "matrix" end)}
        ))
}, {
    type = "autosnippets",
})
