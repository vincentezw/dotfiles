return {
  "luukvbaal/statuscol.nvim",
  config = function()
    local builtin = require("statuscol.builtin")
    require("statuscol").setup({
      relculright = true,
      bt_ignore = { "nofile", "prompt" },
      ft_ignore = {
        "neo-tree",
        "TelescopePrompt",
        "TelescopeResults",
        "help",
        "dashboard",
        "lazy",
        "toggleterm",
      },
      segments = {
        {
          text = { builtin.foldfunc },
          colwidth = 2,
          click = "v:lua.ScFa",
        },
        { text = { " %s" }, click = "v:lua.ScSa" },
        { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
      },
    })
    vim.api.nvim_set_hl(0, "FoldColumn", { fg = "#b0b0b0" })
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
  end,
}
