local M = {}
local home = os.getenv "HOME"

function M.get_config_path()
    local config = os.getenv "XDG_CONFIG_DIR"
    if not config then
        return home .. "/.config/nvim"
    end
    return config
end

function M.get_data_path()
    local data = os.getenv "XDG_DATA_DIR"
    if not data then
        return home .. "/.local/share/nvim"
    end
    return data
end

return M
