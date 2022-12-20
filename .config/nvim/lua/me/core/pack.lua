local lua_path = vim.fn.stdpath "config" .. "/lua"
local auto_reload = nil
local PackerHooks = vim.api.nvim_create_augroup("PackerHooks", { clear = true })

local paths = require "me.core.paths"

local reload_config = function()
    ---@diagnostic disable-next-line: param-type-mismatch
    local lua_dirs = vim.fn.glob("./lua/*", 0, 1)
    for _, dir in ipairs(lua_dirs) do
        dir = string.gsub(dir, "./lua/", "")
        R(dir)
    end
    require("packer").compile()
end
--- @param notify_text string
local notify =
    function(notify_text) vim.notify(notify_text, vim.log.levels.INFO, { title = "Reload" }) end

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
        ---@diagnostic disable-next-line: missing-parameter
        local tmp = vim.split(vim.fn.globpath(modules_dir, "*/plugins.lua"), "\n")
        for _, f in ipairs(tmp) do
            list[#list + 1] = string.match(f, "lua/(.+).lua$"):gsub("/", ".")
        end
        return list
    end

    local plugins_file = get_plugins_list()
    local confs = {}
    local disabled_in_vscode = { "completion", "building", "tools", "ui"}
    for _, m in ipairs(plugins_file) do
        local disable = vim.g.vscode ~= nil
            and vim.tbl_contains(disabled_in_vscode, vim.fn.split(m, "\\.")[3])
        if not disable then
            for _, conf in pairs(require(m)) do
                confs[#confs + 1] = conf
            end
        else
            print("DISABLING " .. m)
        end
    end
    local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazypath) then
        notify "CREATING"
        vim.fn.system {
            "git",
            "clone",
            "--filter=blob:none",
            "--single-branch",
            "https://github.com/folke/lazy.nvim.git",
            lazypath,
        }
    end
    vim.opt.runtimepath:append(lazypath)
    require("lazy").setup(confs)
end

---@alias PluginConfig table{requires: table<string, string[]>?, config = function?}

---@param mod_conf table<string, PluginConfig>
---@return function(table<string, table>): table
M.export_config = function(mod_conf)
    return function(modules)
        for name, provided_mod in pairs(modules) do
            local loaded_mod = mod_conf[name]
            if loaded_mod ~= nil then
                if not provided_mod["config"] then
                    modules[name].config = loaded_mod["config"]
                end
                local provided_deps = provided_mod["dependencies"]
                if not provided_deps then
                    modules[name].dependencies = vim.tbl_values(loaded_mod["dependencies"] or {})
                end
            end
        end
        return modules
    end
end

return M
