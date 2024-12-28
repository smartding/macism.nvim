local uv = vim.uv
local api = vim.api
local fn = vim.fn

local M = {}

local function leave_insert()
  local handle = io.popen("macism")
  if not handle then
    return
  end

  local result = handle:read("*a")
  handle:close()
  local input_source = result:match("%S+") -- Trim any extra whitespace

  if input_source ~= default_input_source then
    vim.b.macism_input_source = input_source
    fn.system("macism " .. default_input_source)
  end
end

local function enter_insert()
  if vim.b.macism_input_source and vim.b.macism_input_source ~= default_input_source then
    -- switch to previous input source
    fn.system("macism " .. vim.b.macism_input_source)
  end
end

M.setup = function(opts)
  -- no need to switch input method in a SSH session
  if uv.os_getenv("SSH_TTY") ~= nil then
    return
  end

  -- no need to switch input method if not macOS
  if not string.find(uv.os_uname().sysname, "Darwin") then
    return
  end

  -- defaults to ABC input source
  default_input_source = opts.default_input_source or "com.apple.keylayout.ABC"

  -- setup autocmds
  local macism_augroup = api.nvim_create_augroup("macism_augroup", { clear = true })
  api.nvim_create_autocmd("InsertEnter", { callback = enter_insert, group = macism_augroup })
  api.nvim_create_autocmd("InsertLeave", { callback = leave_insert, group = macism_augroup })
end

return M
