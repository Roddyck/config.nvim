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
  s(
    "dm",
    fmt(
      [[
        $
          {}
        $
        ]],
      { i(0) }
    )
  ),
  s("cc", t("subset")),
  s({ trig = "sr", wordTrig = false }, t("^2")),
  s({ trig = "cb", wordTrig = false }, t("^3")),
  s({ trig = "inv", wordTrig = false }, t("^(-1)")),
  s({ trig = "td", wordTrig = false }, fmta("^(<>)<>", { i(1), i(0) })),
  s(
    { trig = "(%a)(%d)", regTrig = true, name = "auto subscript", dscr = "auto subscript" },
    fmt([[<>_<>]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
    }, { delimiters = "<>" })
  ),
  s(
    { trig = "(%a)_(%d%d)", regTrig = true, name = "auto subscript 2", dscr = "auto subscript for 2+ digits" },
    fmt([[<>_(<>)]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
    }, { delimiters = "<>" })
  ),
  s({ trig = "__", wordTrig = false }, fmta("_(<>)<>", { i(1), i(0) })),
  s("pm", t("plus.minus")),
  s("norm", fmta("||<>||<>", { i(1), i(0) })),


  postfix("tilde", { l("tilde(" .. l.POSTFIX_MATCH .. ")") }),
  postfix("hat", { l("hat(" .. l.POSTFIX_MATCH .. ")") }),
  postfix("bar", { l("macron(" .. l.POSTFIX_MATCH .. ")") }),
  postfix("vec", { l("arrow(" .. l.POSTFIX_MATCH .. ")") }),
}, {
  type = "autosnippets",
})
