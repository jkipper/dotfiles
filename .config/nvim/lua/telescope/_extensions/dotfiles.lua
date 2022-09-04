local telescope = require "telescope"
local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values

local dotfiles = function(opts)
    opts = opts or {}
    pickers
        .new(opts, {
            prompt_title = "Find dotfiles",
            results_title = "Dotfiles",
            finder = finders.new_oneshot_job({ "yadm", "list" }, {}),
            sorter = conf.file_sorter(opts),
            previewer = conf.file_previewer(opts),
        })
        :find()
end
return telescope.register_extension { exports = { dotfiles = dotfiles } }
