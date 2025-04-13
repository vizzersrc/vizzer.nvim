local M = {}

function M.autoload(subdir)
  local path = vim.fn.stdpath 'config' .. '/lua/custom/' .. subdir
  local files = vim.fn.glob(path .. '/*.lua', true, true)

  for _, file in ipairs(files) do
    local module = file:match '.*/lua/(.*)%.lua$'
    module = module:gsub('/', '.')
    require(module)
  end
end

return M
