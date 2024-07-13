return {
  "svampkorg/moody.nvim",
  event = { "ModeChanged", "BufWinEnter", "WinEnter" },
  dependencies = {
    "catppuccin/nvim",
  },
  opts = {
    blends = {
      normal = 0.3,
      insert = 0.2,
      visual = 0.35,
      command = 0.2,
      operator = 0.2,
      replace = 0.2,
      select = 0.2,
      terminal = 0.2,
      terminal_n = 0.2,
    },
    colors = {
      normal = "#81A9F8",
      insert = "#78bf7c",
      command = "#9b78bf",
      visual = "#dedc71",
      operator = "#FF8F40",
      replace = "#E66767",
      select = "#AD6FF7",
      terminal = "#c261bf",
      terminal_n = "#00BBCC",
    },
  },
}
