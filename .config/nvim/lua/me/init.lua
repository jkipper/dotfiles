require "me.core.config"
require "me.core.events"

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("me.plugins", {})
require "me.keymap"

local Hooks = vim.api.nvim_create_augroup("Hooks", { clear = true })
local enable_auto_luafile = function()
    vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "*.lua",
        callback = function()
            ---@diagnostic disable-next-line: missing-parameter
            dofile(vim.fn.expand "%")
        end,
        group = Hooks,
    })
end
vim.api.nvim_create_user_command("EnableAutoLuafile", enable_auto_luafile, {})
