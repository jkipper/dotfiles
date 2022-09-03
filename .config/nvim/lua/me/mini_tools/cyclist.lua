local M = {}
M.log_level_order = { "DEBUG", "INFO", "WARNING", "ERROR" }

function M.find_word_under_cursor(line, cursor_col, word)
    local idx = 1
    local last_idx = 0
    while last_idx ~= idx do
        last_idx = idx
        local word_start, word_end = line:find(word, idx)
        if not word_start then
            break
        end
        if cursor_col >= word_start - 1 and cursor_col <= word_end - 1 then
            return table.unpack { word_start, word_end }
        else
            idx = idx + word_end
        end
    end
    return nil
end

function M.cycler(dir, fallback_key)
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local line = vim.api.nvim_get_current_line()
    ---@diagnostic disable-next-line: missing-parameter
    local cur_word = vim.fn.expand "<cword>"
    if not cur_word then
        return
    end
    for idx, word_to_match in ipairs(M.log_level_order) do
        local m = string.match(cur_word, "(%w+_?" .. word_to_match .. ")")
        if m then
            local word_start, word_end = M.find_word_under_cursor(line, col, cur_word)
            if not word_start then
                return
            end
            local replace_idx = idx + dir
            -- handle wraparound with stupid 1 index in both directions
            replace_idx = replace_idx > #M.log_level_order and 1 or replace_idx
            replace_idx = replace_idx == 0 and #M.log_level_order or replace_idx
            local new_word = cur_word:gsub(word_to_match, M.log_level_order[replace_idx])
            vim.api.nvim_set_current_line(line:sub(1, word_start - 1) .. new_word .. line:sub(word_end + 1, #line))
            return
        end
    end
    vim.cmd(vim.api.nvim_replace_termcodes("normal! " .. fallback_key, true, true, true))
end

function M.setup()
    local function increase()
        vim.schedule(function()
            M.cycler(1, "<C-A>")
        end)
    end

    local function decrease()
        vim.schedule(function()
            M.cycler(-1, "<C-X>")
        end)
    end

    vim.keymap.set("n", "<C-A>", increase, { noremap = true })
    vim.keymap.set("n", "<C-X>", decrease, { noremap = true })
end

return M
