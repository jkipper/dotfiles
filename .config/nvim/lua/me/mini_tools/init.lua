require "me.mini_tools.containers.containers"
require("me.mini_tools.cyclist").setup()

vim.api.nvim_create_user_command("Colormode", function(tbl)
    local theme = vim.g.colors_name
    local target = tbl.args
    if theme == "tokyonight" then
        if target == "dark" then
            vim.cmd.colorscheme "tokyonight-storm"
        elseif target == "light" then
            vim.cmd.colorscheme "tokyonight-day"
        end
    end
    if theme == "kanagawa" then
        if target == "dark" then
            vim.cmd.colorscheme "kanagawa-wave"
        elseif target == "light" then
            vim.cmd.colorscheme "kanagawa-lotus"
        end
    end
end, {
    nargs = 1,
    complete = function(_, _, _) return { "dark", "light" } end,
})
