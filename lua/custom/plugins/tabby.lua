return {
  'TabbyML/vim-tabby',
  enabled = true,
  lazy = false,
  dependencies = { 'hrsh7th/nvim-cmp', 'neovim/nvim-lspconfig' },
  init = function()
    vim.g.tabby_agent_start_command = { 'npx', 'tabby-agent', '--stdio' }
    vim.g.tabby_inline_completion_trigger = 'manual'
    vim.g.tabby_inline_completion_keybinding_accept = '<C-a>'
    vim.g.tabby_inline_completion_keybinding_trigger_or_dismiss = '<C-z>'
  end,
}
