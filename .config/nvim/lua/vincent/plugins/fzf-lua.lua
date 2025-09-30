return {
  "ibhagwan/fzf-lua",
  -- dependencies = { "nvim-tree/nvim-web-devicons" },
  dependencies = { "DaikyXendo/nvim-material-icon" },
  config = function()
    local fzf = require("fzf-lua")
    fzf.setup({
      grep = {
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
        git_icons = true,
        file_icons = true,
      },
      files = {
        rg_opts = "--files --hidden --follow -g '!.git'",
        fd_opts = "--color=never --type f --hidden --follow --exclude .git",
      }
    })
    local keymap = vim.keymap -- for conciseness
    --
    keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fF", "<cmd>FzfLua grep_last<cr>", { desc = "Search again" })
    keymap.set("n", "<leader>fr", "<cmd>FzfLua oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>FzfLua live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fS", "<cmd>FzfLua live_grep_resume<cr>", { desc = "Resume last string find" })
    keymap.set("n", "<leader>fc", "<cmd>FzfLua grep_cword<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "Fuzzy find buffers" })
  end
}
