return {
  {
    "nyoom-engineering/oxocarbon.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.opt.background = "dark" -- set this to dark or light
      vim.cmd("colorscheme oxocarbon")
      vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#6ACBCB" })
      vim.api.nvim_command([[highlight GotoPreviewTitle  guifg=#141313 guibg=#6ACBCB]])
      vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#6ACBCB" })
      vim.api.nvim_exec(
        [[
          hi BufferCurrent gui=italic
          hi BufferCurrentMod gui=italic guifg=#ff9e64
          hi NeoTreeTabActive gui=italic
          hi NeoTreeTabInactive guibg=#161616
          hi TelescopePromptBorder guifg=#6ACBCB guibg=#141313
          hi TelescopePrompt guifg=#6ACBCB 
          hi TelescopePromptNormal guibg=#141313
          hi TelescopePromptPrefix guibg=#141313
          hi TelescopePromptTitle guifg=#141313 guibg=#6ACBC4
          hi TelescopePreviewTitle guifg=#141313 guibg=#6ACBCB
          hi TelescopeResultsTitle guifg=#141313 guibg=#6ACBCB
        ]],
        false
      )
    end,
  },
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   priority = 1000,
  --   config = function()
  --     require("catppuccin").setup({
  --       integrations = {
  --         barbar = true,
  --         barbecue = {
  --           dim_dirname = true, -- directory name is dimmed by default
  --           bold_basename = true,
  --           dim_context = false,
  --           alt_background = false,
  --         },
  --         cmp = true,
  --         mason = true,
  --         neotree = true,
  --         native_lsp = {
  --           enabled = true,
  --           virtual_text = {
  --             errors = { "italic" },
  --             hints = { "italic" },
  --             warnings = { "italic" },
  --             information = { "italic" },
  --           },
  --           underlines = {
  --             errors = { "underline" },
  --             hints = { "underline" },
  --             warnings = { "underline" },
  --             information = { "underline" },
  --           },
  --           inlay_hints = {
  --             background = true,
  --           },
  --         },
  --         treesitter = true,
  --         telescope = {
  --           enabled = true,
  --         },
  --         which_key = true,
  --       },
  --     })
  --     -- loadhi the colorscheme here
  --     vim.cmd([[colorscheme catppuccin-mocha]])
  --   end,
  -- },
}
