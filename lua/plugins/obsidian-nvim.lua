return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    -- refer to `:h file-pattern` for more examples
    "BufReadPre " .. vim.fn.expand "~" .. "personal/notties/*.md",
    "BufNewFile " .. vim.fn.expand "~" .. "personal/notties/*.md",
  },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    -- A list of workspace names, paths, and configuration overrides.
    -- If you use the Obsidian app, the 'path' of a workspace should generally be
    -- your vault root (where the `.obsidian` folder is located).
    -- When obsidian.nvim is loaded by your plugin manager, it will automatically set
    -- the workspace to the first workspace in the list whose `path` is a parent of the
    -- current markdown file being edited.
    workspaces = {
      {
        name = "notties",
        path = "~/personal/notties",
      },
    },

    legacy_commands = false,

    -- Alternatively - and for backwards compatibility - you can set 'dir' to a single path instead of
    -- 'workspaces'. For example:
    -- dir = "~/vaults/work",

    -- Optional, set the log level for obsidian.nvim. This is an integer corresponding to one of the log
    -- levels defined by "vim.log.levels.\*".
    log_level = vim.log.levels.INFO,

    -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
    completion = {
      -- Enables completion using nvim_cmp
      nvim_cmp = false,
      -- Enables completion using blink.cmp
      blink = true,
      -- Trigger completion at 2 chars.
      min_chars = 2,
      -- Set to false to disable new note creation in the picker
      create_new = true,
    },

    -- Optional, customize how note IDs are generated given an optional title.
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'.
      -- You may have as many periods in the note ID as you'd like—the ".md" will be added automatically
      local suffix = ""
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. "-" .. suffix
    end,

    -- Where to put new notes. Valid options are
    -- _ "current_dir" - put new notes in same directory as the current buffer.
    -- _ "notes_subdir" - put new notes in the default notes subdirectory.
    new_notes_location = "current_dir",

    wiki_link_func = "use_alias_only",
    -- Either 'wiki' or 'markdown'.
    preferred_link_style = "wiki",

    -- Optional, boolean or a function that takes a filename and returns a boolean.
    -- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
    disable_frontmatter = false,

    -- Sets how you follow URLs
    ---@param url string
    follow_url_func = function(url)
      vim.ui.open(url)
      -- vim.ui.open(url, { cmd = { "firefox" } })
    end,

    -- Sets how you follow images
    ---@param img string
    follow_img_func = function(img)
      vim.ui.open(img)
      -- vim.ui.open(img, { cmd = { "loupe" } })
    end,

    ---@class obsidian.config.OpenOpts
    ---
    ---Opens the file with current line number
    ---@field use_advanced_uri? boolean
    ---
    ---Function to do the opening, default to vim.ui.open
    ---@field func? fun(uri: string)
    open = {
      use_advanced_uri = false,
      func = vim.ui.open,
    },

    picker = {
      -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.pick'.
      name = "fzf-lua",
      -- Optional, configure key mappings for the picker. These are the defaults.
      -- Not all pickers support all mappings.
      note_mappings = {
        -- Create a new note from your query.
        new = "<C-x>",
        -- Insert a link to the selected note.
        insert_link = "<C-l>",
      },
      tag_mappings = {
        -- Add tag(s) to current note.
        tag_note = "<C-x>",
        -- Insert a tag at the current location.
        insert_tag = "<C-l>",
      },
    },

    -- Optional, sort search results by "path", "modified", "accessed", or "created".
    -- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
    -- that `:Obsidian quick_switch` will show the notes sorted by latest modified time
    sort_by = "modified",
    sort_reversed = true,

    -- Set the maximum number of lines to read from notes on disk when performing certain searches.
    search_max_lines = 1000,
  },

  ---@class obsidian.config.FooterOpts
  ---
  ---@field enabled? boolean
  ---@field format? string
  ---@field hl_group? string
  ---@field separator? string|false Set false to disable separator; set an empty string to insert a blank line separator.
  footer = {
    enabled = true,
    format = "{{backlinks}} backlinks  {{properties}} properties  {{words}} words  {{chars}} chars",
    hl_group = "Comment",
    separator = string.rep("-", 80),
  },
  ---@class obsidian.config.CheckboxOpts
  ---
  ---Order of checkbox state chars, e.g. { " ", "x" }
  ---@field order? string[]
  checkbox = {
    order = { " ", "~", "!", ">", "x" },
  },
}
