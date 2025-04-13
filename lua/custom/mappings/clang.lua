local map = vim.keymap.set

-- Custom C keymaps
local function get_paths()
  local file_abs = vim.fn.expand '%:p'
  local file_no_ext = vim.fn.expand '%:p:r'
  local file_name = vim.fn.expand '%:t:r'
  local asm_file = file_no_ext .. '.s'
  local exe_file = file_no_ext .. '.out'
  return file_abs, file_no_ext, file_name, asm_file, exe_file
end

-- 📦 Compile & Execute
map('n', '<leader>gce', function()
  vim.cmd 'w'
  local file, _, _, _, exe = get_paths()
  local cmd = string.format([[gcc "%s" -Wall -pedantic -o "%s"]], file, exe)

  local result = vim.fn.system(cmd)
  if vim.v.shell_error ~= 0 then
    vim.notify('❌ Compilation failed!\n\n' .. result, vim.log.levels.ERROR)
    return
  end

  vim.cmd('!' .. exe)
end, { noremap = true, silent = true, desc = 'Compile & execute opened C file' })

-- 🐞 Compile & Debug (DAP)
map('n', '<leader>gcd', function()
  vim.cmd 'w'
  local file, _, _, _, exe = get_paths()
  local cmd = string.format([[gcc -g "%s" -o "%s"]], file, exe)

  local result = vim.fn.system(cmd)
  if vim.v.shell_error ~= 0 then
    vim.notify('❌ Compilation failed!\n\n' .. result, vim.log.levels.ERROR)
    return
  end

  require('dap').run {
    name = 'Launch compiled file',
    type = 'codelldb',
    request = 'launch',
    program = exe,
    cwd = vim.fn.getcwd(),
    stopOnEntry = false,
    args = {},
  }
end, { noremap = true, silent = true, desc = 'Compile & debug opened C file' })

-- 🛠 Compile to Assembly
map('n', '<leader>gca', function()
  vim.cmd 'w'
  local file, _, _, asm, _ = get_paths()
  local cmd = string.format([[gcc -S "%s" -o "%s"]], file, asm)

  local result = vim.fn.system(cmd)
  if vim.v.shell_error ~= 0 then
    vim.notify('❌ Compilation to assembly failed!\n\n' .. result, vim.log.levels.ERROR)
    return
  end

  vim.cmd('split ' .. asm)
end, { noremap = true, silent = true, desc = 'Compile and read opened C file as Assembly' })
