return {
  "nvim-lualine/lualine.nvim",
  -- dependencies = { "DaikyXendo/nvim-material-icon", "nvim-tree/nvim-web-devicons", "ofseed/copilot-status.nvim" },
  dependencies = { "DaikyXendo/nvim-material-icon", "AndreM222/copilot-lualine" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count
    -- LSP clients attached to buffer
    local clients_lsp = function()
      local bufnr = vim.api.nvim_get_current_buf()

      local clients = vim.lsp.buf_get_clients(bufnr)
      if next(clients) == nil then
        return ""
      end

      local c = {}
      for _, client in pairs(clients) do
        table.insert(c, client.name)
      end
      local client_str = table.concat(c, ", ")
      return "(" .. client_str .. ")"
    end

    local mode_map = {
      ["n"] = " Normal",
      ["no"] = "O-PENDING",
      ["nov"] = "O-PENDING",
      ["noV"] = "O-PENDING",
      ["no�"] = "O-PENDING",
      ["niI"] = "NORMAL",
      ["niR"] = "NORMAL",
      ["niV"] = "NORMAL",
      ["nt"] = "NORMAL",
      ["v"] = " Visual",
      ["vs"] = " Visual",
      ["V"] = " Visual line",
      ["Vs"] = " Visual line",
      ["\22"] = " Visual block",
      ["s"] = "SELECT",
      ["S"] = "S-LINE",
      ["�"] = "S-BLOCK",
      ["i"] = "󰏫 Insert",
      ["ic"] = "󰏫 Insert",
      ["ix"] = "󰏫 Insert",
      ["R"] = " Replace",
      ["Rc"] = "REPLACE",
      ["Rx"] = "REPLACE",
      ["Rv"] = "V-REPLACE",
      ["Rvc"] = "V-REPLACE",
      ["Rvx"] = "V-REPLACE",
      ["c"] = "󰘳 Command",
      ["cv"] = "EX",
      ["ce"] = "EX",
      ["r"] = " Replace",
      ["rm"] = "MORE",
      ["r?"] = "CONFIRM",
      ["!"] = "SHELL",
      ["t"] = "TERMINAL",
    }
    vim.api.nvim_command("highlight LualineGreenText guifg=#4db73d ctermfg=248")
    vim.api.nvim_command("highlight LualineGreyText guifg=#a9a9a9 ctermfg=248")
    vim.api.nvim_command("highlight LualineRedText guifg=#cd1e1e ctermfg=248")

    -- configure lualine with modified theme
    lualine.setup({
      options = {
        disabled_filetypes = { "lazy", "neo-tree" },
        theme = "auto",
        component_separators = "",
        section_separators = "",
        color = { bg = nil },
      },
      sections = {
        lualine_a = {
          {
            function()
              return mode_map[vim.api.nvim_get_mode().mode]
            end,
            separator = { left = " ", right = "" },
          },
        },
        lualine_b = {
          {
            "branch",
            icon = { "", color = { fg = "#CE27BD" } },
            padding = { left = 2, right = 3 },
            color = { bg = nil },
          },
        },
        lualine_c = {
          {
            "diagnostics",
            sources = { "nvim_lsp" },
            sections = { "error", "warn" },
            symbols = { error = "  ", warn = "  ", info = " " },
            always_visible = true,
            fmt = function(name, context)
              local bracket_open = "%#LualineGreyText#(%#Normal#"
              local bracket_close = "%#LualineGreyText#)%#Normal#"
              return string.format("%s%s%s", bracket_open, name, bracket_close)
            end,
            diagnostics_color = {
              error = { fg = "#9F5D62" },
              warn = { fg = "#B5A075" },
            },
          },
          {
            "filename",
            path = 1,
            symbols = {
              modified = "%#LualineGreenText#%#Normal#", -- Text to show when the file is modified.
              readonly = "%#LualineRedText#%#Normal#", -- Text to show when the file is non-modifiable or readonly.
              unnamed = "[No Name] ", -- Text to show for unnamed buffers.
              newfile = "[New] ", -- Text to show for newly created file before first write
            },
            icon = { "", color = { fg = "#CE27BD" } },
            padding = { left = 2 },
          },
          {
            "searchcount",
            icon = { "", color = { fg = "#06a4c7" } },
            fmt = function(name, context)
              if vim.v.hlsearch > 0 then
                local cleaned_name = string.gsub(name, "[%[%]]", "")
                return " " .. cleaned_name
              end
            end,
            padding = { left = 3 },
          },
          {
            "selectioncount",
            icon = { "󰒅", color = { fg = "#06a4c7" } },
            fmt = function(name, context)
              if name ~= "" then
                local cleaned_name = string.gsub(name, "[%[%]]", "")
                return " " .. cleaned_name
              end
            end,
            padding = { left = 3 },
          },
        },
        lualine_x = {
          {
            clients_lsp,
            color = { gui = "italic" },
            padding = 1,
          },
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
            padding = { left = 3, right = 2 },
          },
          -- { "fileformat" },
          { "copilot", color = { fg = "#82C257" }, padding = { right = 3 } },
          {
            "filetype",
            colored = true, -- Enable colored background
            color = { fg = "#1abc9c", bg = "#2c3e50" },
            icons_enabled = false,
            separator = { left = "", right = "" },
          },
        },
        lualine_y = {
          {
            " ", -- Custom empty component as separator
            draw_empty = true,
          },
          {
            "progress",
            color = { fg = "#06a4c7", bg = "#2c3e50" },
            separator = { left = " ", right = " " },
            padding = { left = 1, right = 1 },
          },
        },
        lualine_z = {
          {
            "", -- Custom empty component as separator
            draw_empty = true,
            color = { bg = "#171616" },
            padding = 0,
          },
          {
            "location",
            color = { fg = "#9E85D4", bg = "#2c3e50" },
            separator = { left = " ", right = " " },
            padding = { left = 1, right = 1 },
          },
        },
      },
    })
  end,
}
