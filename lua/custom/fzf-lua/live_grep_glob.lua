return function()
  require("fzf-lua").live_grep({
    cmd = "rg --column --line-number --color=always --smart-case",
    fn_transform_cmd = function(query, cmd, _)
      local query_split = vim.split(query, " -- ", { plain = true })
      local search_query, glob_patterns = query_split[1], query_split[2]

      local shortcuts = {
        l = "*.lua",
        c = "*.c",
        h = "*.h",
        js = "*.js",
        ts = "*.ts",
        sv = "*.svelte",
      }

      if not glob_patterns then
        return -- fallback to original command
      end

      local pathspecs = {}
      for _, glob_pattern in ipairs(vim.split(glob_patterns, " ")) do
        local pattern = shortcuts[glob_pattern] or glob_pattern
        table.insert(pathspecs, string.format("-g '%s'", pattern))
      end

      local new_cmd = string.format("%s -e %s %s", cmd, vim.fn.shellescape(search_query), table.concat(pathspecs, " "))
      return new_cmd, search_query
    end,
  })
end
