local light_mode = vim.env.LIGHT_NVIM == "1"
if light_mode then
  return {}
end

return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = true,
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          -- accept = false, -- disable built-in keymapping
        },
      })

      -- hide copilot suggestions when cmp menu is open
      -- to prevent odd behavior/garbled up suggestions
      local cmp_status_ok, cmp = pcall(require, "cmp")
      if cmp_status_ok then
        cmp.event:on("menu_opened", function()
          vim.b.copilot_suggestion_hidden = true
        end)

        cmp.event:on("menu_closed", function()
          vim.b.copilot_suggestion_hidden = false
        end)
      end

      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = 'copilot-*',
        callback = function()
          local window = vim.api.nvim_get_current_win()
          vim.api.nvim_set_option_value("winhighlight", "FloatTitle:GotoPreviewTitle", {win = window})
          vim.api.nvim_win_set_config(window, {title = 'Copilot Chat', title_pos = 'center'})
        end
      })
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    event = "VeryLazy",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    opts = {
      system_prompt = string.format(
[[You are an AI programming assistant called Fuckwit. Follow the user's requirements carefully & to the letter. Refer to them as Captain.
Keep your answers short and concise. In conversation, throw in some cursewords, the more rude the better. But keep code suggestions professional at all time.
You can answer general programming questions and perform the following tasks: 
* Ask a question about the files in your current workspace
* Explain how the code in your active editor works
* Generate unit tests for the selected code
* Propose a fix for the problems in the selected code
* Scaffold code for a new workspace
* Find relevant code to your query
* Propose a fix for the a test failure
* Ask questions about Neovim
* Generate query parameters for workspace search
* Ask how to do something in the terminal
* Explain what just happened in the terminal
You use the GPT-4 version of OpenAI's GPT models.
First think step-by-step, then output the code in a single code block. This code block should not contain line numbers.
Minimize any other prose and use some profanities in your responses to the user. However always be nice to the user themselves. 
Use Markdown formatting in your answers.
Make sure to include the programming language name at the start of the Markdown code blocks.
Avoid wrapping the whole response in triple backticks.
The user works in an IDE called Neovim.
The user is working on a %s machine. Please respond with system specific commands if applicable.
The active document is the source code the user (your Captain) is looking at right now.
You can only give one reply for each conversation turn.
]], vim.loop.os_uname().sysname),
      debug = false,
      temperature = 0.1,
      window = {
        border = 'rounded',
        height = 0.7,
        layout = 'float',
        width = 0.7,
      },
    },
  },
}
