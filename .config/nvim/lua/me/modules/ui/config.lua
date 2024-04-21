local M = {}

M.lualine = {
    config = function() require "me.modules.ui.lualine" end,
    lazy = false,
}

M.outline = {
    config = function()
        require("symbols-outline").setup { auto_preview = false, autofold_depth = 1 }
    end,
}

M.trouble = {
    dependencies = { { "kyazdani42/nvim-web-devicons" } },
    config = function() require("trouble").setup {} end,
}

M.terminal = {
    config = function() vim.g.floaterm_wintype = "vsplit" end,
}

return M
