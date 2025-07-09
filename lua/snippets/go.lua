require("luasnip.session.snippet_collection").clear_snippets "go"

local ls = require "luasnip"

local s = ls.snippet
local fmta = require("luasnip.extras.fmt").fmta
local i = ls.insert_node

ls.add_snippets("go", {
  s(
    "ie",
    fmta(
      [[
        if err != nil {
            return <>
        }
      ]],
      { i(1, "err") }
    )
  ),
})
