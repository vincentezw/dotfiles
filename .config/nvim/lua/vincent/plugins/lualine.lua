return {
  "nvim-lualine/lualine.nvim",
  -- dependencies = { "DaikyXendo/nvim-material-icon", "nvim-tree/nvim-web-devicons", "ofseed/copilot-status.nvim" },
  dependencies = { "DaikyXendo/nvim-material-icon", "AndreM222/copilot-lualine" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count

    -- configure lualine with modified theme
    lualine.setup({
      options = {
        disabled_filetypes = { "lazy", "neo-tree" },
        theme = "oxocarbon",
      },
      sections = {
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          -- { "fileformat" },
          { "copilot" },
          { "filetype" },
        },
      },
    })
  end,
}
