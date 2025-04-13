local map = vim.keymap.set
map('n', '<leader>z', function()
  require('zen-mode').toggle()
end, { noremap = true, silent = true, desc = 'Open Explorer' })
