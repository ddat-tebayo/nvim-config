return {

    ---------- ! The plugin that serves as a dependency for many other plugins ----------
    -- Plenary: full; complete; entire; absolute; unqualified. All the lua functions I don't want to write twice.
    {'nvim-lua/plenary.nvim'}, 	

    -- Icons
    {'nvim-tree/nvim-web-devicons'}, 

    ---------- ! UI ----------
    -- Colorscheme
    { 'folke/tokyonight.nvim', lazy = false, priority = 1000,},
    { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
    
    -- Tab bar
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
        config = function()
          require('plugins.configs.modicator')
        end,
    },

    -- Dashboard
    {
        'goolord/alpha-nvim', 
        config = function()
          require('plugins.configs.alpha')
        end,
    },

    -- File explorer
    {
        'nvim-tree/nvim-tree.lua', 
        config = function()
          require('plugins.configs.nvim-tree')
        end,
    },

    ---------- ! Editor ----------
    -- Smooth scrolling neovim
    {
        'karb94/neoscroll.nvim',
        config = function()
            require('plugins.configs.neoscroll')
          end,
    },

    -- The superior project management solution for neovim.
    {
        'ahmedkhalf/project.nvim',
    },

    ---------- ! utils ----------
    -- Discord rich presence
    { 'andweeb/presence.nvim', event = 'VeryLazy' },
}