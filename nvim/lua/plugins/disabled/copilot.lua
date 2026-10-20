return {
  {
    'github/copilot.vim',
    ft = { 'html', 'css' },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      -- See Configuration section for options
    },
    ft = { 'html', 'css' }
  },
}
