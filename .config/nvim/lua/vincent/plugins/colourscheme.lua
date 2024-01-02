return {
  {
    "nyoom-engineering/oxocarbon.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.opt.background = "dark" -- set this to dark or light
      vim.cmd("colorscheme oxocarbon")
      vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#CE27BD" })
      vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#CE27BD" })
      vim.api.nvim_exec(
        [[
          hi lualine_a_command guifg=#CE27BD guibg=#141313
          hi TelescopePromptBorder guifg=#CE27BD guibg=#141313
          hi TelescopePrompt guifg=#CE27BD 
          hi TelescopePromptNormal guibg=#141313
          hi TelescopePromptPrefix guibg=#141313
          hi TelescopePromptTitle guifg=#141313 guibg=#CE27BD
          hi TelescopePreviewTitle guifg=#141313 guibg=#CE27BD
          hi TelescopeResultsTitle guifg=#141313 guibg=#CE27BD
        ]],
        false
      )
      -- vim.cmd([[ hi NormalFloat guibg= #f7ff00 ctermbg=235 ]])
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
