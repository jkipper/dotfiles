local lua_path = vim.fn.stdpath "config" .. "/lua"
local auto_reload = nil
local PackerHooks = vim.api.nvim_create_augroup("PackerHooks", { clear = true })

local paths = require "me.core.paths"

local reload_config = function()
    local lua_dirs = vim.fn.glob("./lua/*", 0, 1)
    for _, dir in ipairs(lua_dirs) do
        dir = string.gsub(dir, "./lua/", "")
        R(dir)
    end
    require("packer").compile()
end

local notify = function(notify_text)
    vim.notify(notify_text, vim.log.levels.INFO, { title = "Reload" })
end

local toggle_auto_config_reload = function()
    if auto_reload ~= nil then
        vim.api.nvim_del_autocmd(auto_reload)
        auto_reload = nil
        notify "Disabled automatic config reload"
    else
        auto_reload = vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = lua_path .. "*.lua",
            callback = reload_config,
            group = PackerHooks,
        })
        notify "Enable automatic config reload"
    end
end

local enable_auto_luafile = function()
    vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "*.lua",
        callback = function()
            ---@diagnostic disable-next-line: missing-parameter
            dofile(vim.fn.expand "%")
        end,
        group = PackerHooks,
    })
end

local M = {}
function M.setup_reload()
    -- This and the group must be created on load, otherwise weird stuff happens on reload
    vim.api.nvim_create_autocmd("User", {
        pattern = "PackerCompileDone",
        callback = function()
            notify "Compile done, reloading config"
            dofile(vim.env.MYVIMRC)
        end,
        group = PackerHooks,
    })

    vim.api.nvim_create_user_command("EnableAutoLuafile", enable_auto_luafile, {})
    vim.api.nvim_create_user_command("ConfigReload", reload_config, {})
    vim.api.nvim_create_user_command("ConfigToggleAutoReload", toggle_auto_config_reload, {})
end
function M.load_plugins()
    local vim_path = paths.get_config_path()
    local modules_dir = vim_path .. "/lua/me/modules"

    local get_plugins_list = function()
        local list = {}
        local tmp = vim.split(vim.fn.globpath(modules_dir, "*/plugins.lua"), "\n")
        for _, f in ipairs(tmp) do
            list[#list + 1] = string.match(f, "lua/(.+).lua$"):gsub("/", ".")
        end
        return list
    end

    local plugins_file = get_plugins_list()
    require("packer").startup(function(use)
        use { "wbthomason/packer.nvim" }
        for _, m in ipairs(plugins_file) do
            for _, conf in pairs(require(m)) do
                use(conf)
            end
        end
    end)
end

M.export_config = function(mod_conf)
    return function(modules)
        for name, conf in pairs(modules) do
            local loaded_conf = mod_conf[name]
            local provided_conf = conf["config"]
            if provided_conf ~= nil and loaded_conf ~= nil then
                vim.notify("Duplicate config provided for " .. name)
            end
            if loaded_conf ~= nil then
                if not provided_conf then
                    modules[name].config = loaded_conf["conf"]
                end
                local provided_deps = conf["requires"]
                if not provided_deps then
                    modules[name].requires = vim.tbl_values(loaded_conf["deps"] or {})
                end
            end
        end
        return modules
    end
end

return M
