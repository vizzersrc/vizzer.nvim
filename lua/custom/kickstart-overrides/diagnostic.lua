-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = true,
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = false,
}

vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    local max_win_width = vim.api.nvim_win_get_width(0)
    local float_width = math.floor(math.min(max_win_width * 0.6, 120))

    vim.diagnostic.open_float(nil, {
      focusable = false,
      close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
      border = 'rounded',
      source = 'always',
      prefix = '',
      scope = 'cursor',
      max_width = float_width,
    })
  end,
})
