return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "DaikyXendo/nvim-material-icon", "AndreM222/copilot-lualine" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count
    -- LSP clients attached to buffer
    local clients_lsp = function()
      local bufnr = vim.api.nvim_get_current_buf()
      local clients = vim.lsp.get_clients({bufnr = bufnr})
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

    local filetype = {
      "filetype",
      icon_ony = true,
      colored = true,
    }

    vim.api.nvim_command("highlight LualineGreenText guifg=#4db73d ctermfg=248")
    vim.api.nvim_command("highlight LualineGreyText guifg=#a9a9a9 ctermfg=248")
    vim.api.nvim_command("highlight LualineRedText guifg=#cd1e1e ctermfg=248")

    local extended_cyberdream = {
      normal = {
        a = {fg = "#161616", bg = "#81A9F8" },
        b = {},
        c = {},
      },
      insert = {
        a = {fg = "#161616", bg = "#78bf7c" },
      },
      visual = {
        a = {fg = "#161616", bg = "#dedc71" },
      },
      replace = {
        a = {fg = "#161616", bg = "#c46333" },
      },
      command = {
        a = {fg = "#161616", bg = "#d65a56" },
      },
      terminal = {
        a = {fg = "#161616", bg = "#c261bf" },
      },
    }

    lualine.setup({
      options = {
        disabled_filetypes = { "lazy", "neo-tree" },
        theme = extended_cyberdream,
        component_separators = "",
        section_separators = "",
        color = { bg = nil },
      },
      sections = {
        lualine_a = {
          {
						"mode",
						fmt = function(str)
              local short = str:sub(1, 1)
              if str == "V-LINE" then
                short = "VL"
              elseif str == "V-BLOCK" then
                short = "VB"
              end

              return short
						end,
            separator = { left = "", right = "" },
					},
        },
        lualine_b = {
          {
            "branch",
            icon = { "", color = { fg = "#CE27BD" } },
            padding = { left = 2, right = 3 },
            color = { bg = nil, fg = "#ffffff" },
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
              error = { fg = "#ff6e5e" },
              warn = { fg = "#f1ff5e" },
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
            color = { fg = "#ff6e5e" },
            padding = { left = 3, right = 2 },
          },
          { "copilot", color = { fg = "#82C257" }, padding = { right = 1 } },
          filetype,
        },
        lualine_y = {},
        lualine_z = {
          {
            "location",
						fmt = function(str)
              str = str:gsub("%s+", "")
              return "󰹹" .. str
            end,
            color = { bg = "#161616", fg = "#9E85D4" },
            padding = { left = 1, right = 0 },
          },
        },
      },
    })
  end,
}
