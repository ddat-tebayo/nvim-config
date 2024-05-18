
return {
    ---------- Language Server Protocol ----------

    -- Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters.
    {
        'williamboman/mason.nvim',
        opts = {},
    },
    
    -- Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim.
    {
        'williamboman/mason-lspconfig.nvim',
        event = "VeryLazy",
        config = function()
            require('plugins.lsp.mason-lspconfig')
        end,
    },

    -- Quickstart configs for Nvim LSP
    {
        'neovim/nvim-lspconfig',
        event = {"BufReadPre", "BufNewFile"},
        config = function()
            require('plugins.lsp.lspconfig')
        end,
        dependencies = {
            -- Neovim setup for init.lua and plugin development with full signature help, docs and completion for the nvim lua API.
            { "folke/neodev.nvim", opts = {} },
        }
    },
    --------------------------------------------------

    ---------- Auto completion ----------

    -- A completion plugin for neovim
    {
        'hrsh7th/nvim-cmp',
        event = "InsertEnter",
        config = function()
            require('plugins.configs.cmp')
        end,
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'zbirenbaum/copilot-cmp',
            -- 'hrsh7th/cmp-emoji',
            -- 'hrsh7th/cmp-calc',

        },
    },

    -- Snippet Engine for Neovim written in Lua.
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = {
            --Set of preconfigured snippets for different languages.
            'rafamadriz/friendly-snippets',
            -- vscode-like pictograms for neovim lsp completion items
            'onsails/lspkind.nvim',
        }
    },
    
    -- Fully featured & enhanced replacement for copilot.vim complete with API for interacting with Github Copilot
    {
        'zbirenbaum/copilot.lua',
        cmd = "Copilot",
        build = ":Copilot auth",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = { enabled = false },
                panel = { enabled = false },
            })
        end,
    },
    --------------------------------------------------

    ---------- Others ----------
    -- Auto pairs
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true,
        opts = {
            disable_filetype = { "TelescopePrompt", "spectre_panel", "vim" }
        }
    },

    -- Add/change/delete surrounding delimiter pairs with ease
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end
    },

    -- Automatically add closing tags for HTML and JSX
    {
        'windwp/nvim-ts-autotag',
        event = "InsertEnter",
        opts = {},
    },

    -- Automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching to find the other instances.
    {
        'RRethy/vim-illuminate',
        event = "VeryLazy",
    },
    
    -- A small Neovim plugin for previewing native LSP's goto definition, type definition, implementation, declaration and references calls in floating windows.
    {
        'rmagatti/goto-preview',
        config = function()
            require('goto-preview').setup {
                default_mappings = true
            }
        end
    },
}