function R(module_name)
    require("plenary.reload").reload_module(module_name)
end

local dev_plugin = os.getenv "plugin_location"
if dev_plugin ~= nil then
    vim.opt.runtimepath:append(dev_plugin)
end

require "me.core.config"
require("me.core.pack").load_plugins()
require("me.core.pack").setup_reload()
require "me.mini_tools"
require "me.keymaps"
require "me.core.events"
