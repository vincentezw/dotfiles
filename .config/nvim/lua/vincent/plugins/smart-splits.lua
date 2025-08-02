return {
  'mrjones2014/smart-splits.nvim',
  config = function()
    local nvim_smart_splits = require('smart-splits')

    nvim_smart_splits.setup {
      multiplexer_integration = 'wezterm',
    }
    local keymap = vim.keymap -- for conciseness
    keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
    keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
    keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
    keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
    keymap.set('n', '<C-\\>', require('smart-splits').move_cursor_previous)
  end
}

