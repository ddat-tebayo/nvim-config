return {
  -- Plenary: full; complete; entire; absolute; unqualified. All the lua functions I don't want to write twice.
  { 'nvim-lua/plenary.nvim' },

  -- Icons
  { 'nvim-tree/nvim-web-devicons' },

  -- measure startuptime
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
}

