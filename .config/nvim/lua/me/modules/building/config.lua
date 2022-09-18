local M = {}

M.task_runner = {
    config = function()
        require("overseer").setup {}
    end,
}

return M
