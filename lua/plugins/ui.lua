return {
  -- A snazzy buffer line (with tabpage integration)
  {
    'akinsho/bufferline.nvim',
    event = 'BufRead',
    config = function()
      require('plugins.configs.bufferline')
    end,
  },

  -- Status bar
  {
    "nvim-lualine/lualine.nvim",
    event = "BufEnter",
    config = function()
      require('plugins.configs.lualine')
    end,
  },

  -- Cursor line number mode indicator
  {
    'mawkler/modicator.nvim',
    event = "BufEnter",
    config = function()
      require('plugins.configs.modicator')
    end,
  },

  -- Dashboard
  {
    'goolord/alpha-nvim',
    event = "VimEnter",
    config = function()
      require('plugins.configs.alpha')
    end,
  },

  -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
  {
    'folke/noice.nvim',
    event = "VeryLazy",
    opts = {},
    dependencies = {
      'MunifTanjim/nui.nvim',
      "rcarriga/nvim-notify",
    },
  },

  -- Indentation guides
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    main = 'ibl',
    opts = {
      indent = {
        char = "│",
        -- tab_char = "┊",
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          "help", "alpha", "dashboard", "neo-tree", "NvimTree", "aerial", "Trouble", "trouble", "lazy", "mason", "notify",
          "toggleterm", "lazyterm",
        },
      }
    },
  },

  -- Neovim plugin to improve the default vim.ui interfaces
  {
    'stevearc/dressing.nvim',
    event = "VeryLazy",
    opts = {}
  },

  -- Smooth scrolling neovim
  {
    'karb94/neoscroll.nvim',
    config = function()
      require('neoscroll').setup {}
    end,
  },
}

