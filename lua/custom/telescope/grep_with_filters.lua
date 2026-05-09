local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local sorters = require "telescope.sorters"
local make_entry = require "telescope.make_entry"
local conf = require("telescope.config").values

return function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd and vim.fn.expand(opts.cwd) or vim.uv.cwd()

  local custom_grep = finders.new_async_job({
    command_generator = function(prompt)
      if prompt == "" or prompt == nil then
        return nil
      end

      local args = { "rg" }
      local additional_rg_args =
        { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" }

      local prompt_split = vim.split(prompt, " -- ", { plain = true })
      table.insert(args, "-e")
      table.insert(args, prompt_split[1])

      if prompt_split[2] then
        for _, pattern in ipairs(vim.split(prompt_split[2], " ")) do
          table.insert(args, "-g")
          table.insert(args, pattern)
        end
      end

      return vim
        .iter({
          args,
          additional_rg_args,
        })
        :flatten()
        :totable()
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  })

  pickers
    .new(opts, {
      debounce = 200,
      prompt_title = "Live Grep with filters",
      finder = custom_grep,
      previewer = conf.grep_previewer(opts),
      sorter = sorters.highlighter_only(),
    })
    :find()
end
