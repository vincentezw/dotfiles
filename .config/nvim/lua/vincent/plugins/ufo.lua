return {
  "kevinhwang91/nvim-ufo",
  config = function()
    vim.opt.foldcolumn = '1'
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
    vim.opt.foldenable = true
    local ftMap = {
      vim = 'indent',
      python = {'indent'},
      git = ''
    }
    require("ufo").setup({
      provider_selector = function(bufnr, filetype, buftype)
        return ftMap[filetype]
      end,
    })
  end,
  dependencies = {
    "kevinhwang91/promise-async",
    "nvim-telescope/telescope.nvim", -- optional
    {
      "luukvbaal/statuscol.nvim",
      config = function()
        local builtin = require("statuscol.builtin")
        require("statuscol").setup({
          relculright = true,
          bt_ignore = { "nofile", "prompt" },
          ft_ignore = {
            "nofile",
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
    },
  },
  event = "BufReadPost",
  opts = {
    provider_selector = function()
      return { "treesitter", "indent" }
    end,
  },
}
