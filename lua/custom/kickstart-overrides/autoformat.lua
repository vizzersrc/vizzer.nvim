require('conform').setup {
  format_on_save = function(bufnr)
    return {
      timeout_ms = 500,
      lsp_format = 'fallback',
    }
  end,
}
