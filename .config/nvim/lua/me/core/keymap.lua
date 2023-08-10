local M = {}

---@param mode string | list
---@return fun(map: string, command: string | function)
local make_map = function(mode)
    return function(map, command)
        vim.keymap.set(mode, map, command, { noremap = true, silent = true })
    end
end

M.nmap = make_map "n"
M.imap = make_map "i"
M.vmap = make_map "v"
M.nvmap = make_map { "n", "v" }

---@param vcmd string
---@return string
M.cmd = function(vcmd) return "<cmd>" .. vcmd .. "<CR>" end

return M
