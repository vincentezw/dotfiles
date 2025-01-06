return {
  "rcarriga/nvim-notify",
  event = "BufRead",
  config = function()
    local notify = require("notify")
    notify.setup({
      -- background_colour = "#000000",
      render = "compact",
    })

    vim.notify = notify
  end,
}
