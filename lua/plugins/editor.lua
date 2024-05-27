return {
  -- File explorer
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('plugins.configs.nvim-tree')
    end,
  },

  -- A highly extendable fuzzy finder over lists
  -- 'BurntSushi/ripgrep' is required for live_grep and grep_string and is the first priority for find_files.
  {
    'nvim-telescope/telescope.nvim',
    config = function()
      require("plugins.configs.telescope")
    end,
    dependencies = {
      -- Native telescope sorter to significantly improve sorting performance.
      -- You have to install 'fzf', 'make' and 'gcc'
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

      -- The superior project management solution for neovim.
      -- Access your recently opened projects from telescope!
      { 'ahmedkhalf/project.nvim' },
    }
  },

  -- A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
  {
    'folke/trouble.nvim',
    opts = { use_diagnostic_signs = true },
  },

  -- A neovim lua plugin to help easily manage multiple terminal windows
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require('plugins.configs.toggleterm')
    end,
  },

  -- Git integration for buffers
  {
    'lewis6991/gitsigns.nvim',
    event = "BufRead",
    config = function()
      require("gitsigns").setup {}
    end,
  },

  -- Neovim plugin for a code outline window
  {
    'stevearc/aerial.nvim',
    opts = {
      backends = { "treesitter", "lsp", "markdown" },
      layout = {
        width = 40,
        default_direction = "prefer_left",
      }
    }
  },

  -- Smart and powerful comment plugin for neovim. Supports treesitter, dot repeat, left-right/up-down motions, hooks, and more
  {
    'numToStr/Comment.nvim',
    opts = {},
    dependencies = {
      -- Tiny plugin to enhance Neovim's native comments
      {
        "folke/ts-comments.nvim",
        opts = {},
        event = "VeryLazy",
        enabled = vim.fn.has("nvim-0.10.0") == 1,
      }
      -- Highlight, list and search todo comments in your projects
      {
        "folke/todo-comments.nvim",
        opts = {}
      },
    }
  },

  -- Simple winbar/statusline plugin that shows your current code context
  {
    'SmiteshP/nvim-navic',
    config = function()
      require("nvim-navic").setup({
        icons = require("utils.icons").kinds,
        highlight = true,
        lsp = {
          auto_attach = true,
          preference = nil,
        }
      })
    end
  },

  -- Make Neovim's fold look modern and keep high performance.
  {
    'kevinhwang91/nvim-ufo',
    event = "VeryLazy",
    config = function()
      require('plugins.configs.ufo')
    end,
    dependencies = {
      'kevinhwang91/promise-async',

      -- Status column plugin that provides a configurable 'statuscolumn' and click handlers
      -- getting rid of folding level numbers in nvim-ufo
      {
        'luukvbaal/statuscol.nvim',
        event = "VeryLazy",
      },
    },
  },

  -- Color picker and highlighter
  {
    'uga-rosa/ccc.nvim',
    event = "BufEnter",
    config = function()
      require('ccc').setup({
        highlighter = {
          auto_enable = true,
          lsp = true,
        },
      })
    end,
  },

  -- Displays a popup with possible keybindings of the command you started typing
  {
    'folke/which-key.nvim',
    event = "VeryLazy",
    config = function()
      require('plugins.configs.whichkey')
    end,
  },
}
