return {
  'mrjones2014/smart-splits.nvim',
  config = function()
    local nvim_smart_splits = require('smart-splits')

    nvim_smart_splits.setup {
      disable_when_zoomed = false,
      keybindings = {
        left = "<C-h>",
        down = "<C-j>",
        up = "<C-k>",
        right = "<C-l>",
        last_active = "<C-\\>",
        next = "<C-Space>",
      }
    }
  end
}

