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
          hi BufferCurrent gui=italic guibg=#2E2E2E
          hi BufferCurrentMod gui=italic guifg=#ff9e64 guibg=#2E2E2E
          hi BufferCurrentSign guifg=#161616 guibg=#2E2E2E
          hi BufferInactive guibg=#161616
          hi BufferInactiveMod guibg=#161616 guifg=#ff9e64
          hi BufferInactiveSign guifg=#161616 guibg=#161616
          hi BufferTabpageFill guibg=#161616


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
}
