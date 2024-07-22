return {
  {
    "scottmckendry/cyberdream.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("cyberdream").setup({
        borderless_telescope = false,
        transparent = true,
        italic_comments = true,
        colors = {
          bg = "#161616",
        },
      })

      vim.opt.background = "dark" -- set this to dark or light
      vim.cmd("colorscheme cyberdream")
      vim.api.nvim_exec2(
        [[
          hi GotoPreviewTitle guifg=#141313 guibg=#6ACBC4
          hi BufferCurrent gui=italic guibg=#2E2E2E
          hi BufferCurrentMod gui=italic guifg=#ff9e64 guibg=#2E2E2E
          hi BufferCurrentSign guifg=#161616 guibg=#2E2E2E
          hi BufferInactive guibg=#161616
          hi BufferInactiveMod guibg=#161616 guifg=#ff9e64
          hi BufferInactiveSign guifg=#161616 guibg=#161616
          hi BufferTabpageFill guibg=#161616

          hi NeoTreeTabActive gui=italic
          hi NeoTreeTabInactive guibg=#161616
          hi TelescopePrompt guifg=#6ACBCB 
          hi TelescopePromptCounter guifg=#6ACBCB 
          hi TelescopePromptNormal guibg=#141313
          hi TelescopePromptPrefix guifg=#6ACBCB guibg=#141313
          hi TelescopePromptTitle guifg=#141313 guibg=#6ACBC4
          hi TelescopePreviewTitle guifg=#141313 guibg=#6ACBCB
          hi TelescopeResultsTitle guifg=#141313 guibg=#6ACBCB

          hi IncSearch guibg=#ec2ef2
          hi VincentHeader guifg=#ec2ef2 guibg=#161616
          hi Folded guibg=#0c2624
        ]],
        {output = false}
      )
    end,
  },
}
