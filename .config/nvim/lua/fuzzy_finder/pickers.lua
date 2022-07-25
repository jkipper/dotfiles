local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require "telescope.config".values

local dotfiles = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "dotfiles",
    finder = finders.new_oneshot_job { "yadm", "list" },
    sorter = conf.file_sorter(opts)
  }):find()
end

local pickers = {}
pickers.dotfiles = dotfiles
return pickers
