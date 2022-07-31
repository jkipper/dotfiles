local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require "telescope.config".values

local M = {}

local dotfiles = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "dotfiles",
    finder = finders.new_oneshot_job({ "yadm", "list" }, {}),
    sorter = conf.file_sorter(opts),
    previewer = conf.file_previewer(opts)
  }):find()
end
M.dotfiles = dotfiles
return M
