local nmap = require("me.core.keymap").nmap
local cmd = require("me.core.keymap").cmd
nmap("<A-o>", cmd "ClangdSwitchSourceHeader")
