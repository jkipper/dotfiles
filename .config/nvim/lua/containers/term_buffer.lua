
local TermBuffer = {}
TermBuffer.__index = TermBuffer

function TermBuffer:new()
  local obj = setmetatable({ timeout = 0, buf = nil, channel_id = nil }, self)
  self.buf = vim.api.nvim_create_buf(false, true)
  self.channel_id = vim.api.nvim_open_term(self.buf, {})
  return obj
end

---Send data to the buffer
---@param data string
function TermBuffer:send(data)
  vim.schedule(function()
    if data == nil or not self:_is_initialized() then
      return
    end
    vim.api.nvim_chan_send(self.channel_id, data)
  end)
end

function TermBuffer:_is_initialized()
  if self.buf == nil or self.channel_id == nil then
    vim.notify "Terminal buffer is not initialized"
    return false
  elseif not vim.api.nvim_buf_is_valid(self.buf) then
    vim.notify "Buffer was already closed"
    return false
  end
  return true
end

function TermBuffer:show()
  vim.schedule(function()
    if self:_is_initialized() then
      vim.cmd("sb " .. self.buf)
    end
  end)
end

function TermBuffer:close()
  vim.schedule(function()
    if not self:_is_initialized() then
      return
    end
    vim.api.nvim_buf_delete(self.buf, { force = true })
    self = nil
  end)
end


return TermBuffer
