function R(module_name)
    require("plenary.reload").reload_module(module_name)
end

require "me.core.config"
require("me.core.pack").load_plugins()
require("me.core.pack").setup_reload()
require "me.mini_tools"
require "me.keymaps"
