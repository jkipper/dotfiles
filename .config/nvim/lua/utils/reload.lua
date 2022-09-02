local scandir = require "plenary.scandir"
local lua_path = vim.fn.stdpath "config" .. "/lua"

local _M = {
	auto_reload = nil,
	PackerHooks = vim.api.nvim_create_augroup("PackerHooks", { clear = true }),
}

local notify = function(notify_text)
	vim.notify(notify_text, vim.log.levels.INFO, { title = "Reload" })
end
function _M.file_path_to_lua_module(path)
	local mod = string.gsub(path, lua_path .. "/", "")
	mod = string.gsub(mod, "/", ".")
	mod = string.gsub(mod, ".lua", "")
	mod = string.gsub(mod, ".init", "")
	return mod
end

function _M.reload_files(files)
	for _, file in ipairs(files) do
		local pack = _M.file_path_to_lua_module(file)
		if pack ~= "utils.reload" then
			package.loaded[_M.file_path_to_lua_module(file)] = nil
		end
	end
	require("packer").compile()
end

function _M.reload_config()
	local files = scandir.scan_dir(lua_path, {
		search_pattern = "%.lua$",
		hidden = false,
	})
	_M.reload_files(files)
end

function _M.toggle_auto_config_reload()
	if _M.auto_reload ~= nil then
		vim.api.nvim_del_autocmd(_M.auto_reload)
		_M.auto_reload = nil
		notify "Disabled automatic config reload"
	else
		_M.auto_reload = vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = lua_path .. "*.lua",
			callback = _M.reload_config,
			group = _M.PackerHooks,
		})
		notify "Enable automatic config reload"
	end
end

function _M.enable_auto_luafile()
	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = "*.lua",
		callback = function()
			---@diagnostic disable-next-line: missing-parameter
			dofile(vim.fn.expand "%")
		end,
		group = _M.PackerHooks,
	})
end

-- This and the group must be created on load, otherwise weird stuff happens on reload
vim.api.nvim_create_autocmd("User", {
	pattern = "PackerCompileDone",
	callback = function()
		notify "Compile done, reloading config"
		dofile(vim.env.MYVIMRC)
	end,
	group = _M.PackerHooks,
})

function _M.setup()
	vim.api.nvim_create_user_command("EnableAutoLuafile", _M.enable_auto_luafile, {})
	vim.api.nvim_create_user_command("ConfigReload", _M.reload_config, {})
	vim.api.nvim_create_user_command("ConfigToggleAutoReload", _M.toggle_auto_config_reload, {})
end

return _M
