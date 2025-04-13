local map = vim.keymap.set

map('n', '<leader>pv', ':w<CR>:Ex<CR>', { noremap = true, silent = true, desc = 'Open Explorer' })
