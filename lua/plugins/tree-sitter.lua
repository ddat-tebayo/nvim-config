local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
    return
end

treesitter.setup {
	ensure_installed = { "vim", "html", "css", "javascript", "json", "tsx", "typescript", "php", "phpdoc", "graphql", "dockerfile", "lua", "toml", "markdown", "regex" },
	sync_install = false,
	auto_install = true,
	highlight = {
	  enable = true,
	  additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = '<CR>',
			node_incremental = '<CR>',
			scope_incremental = false,
			node_decremental = '<BS>',
		},
	},
	indent = { enable = true, },
	autotag = { enable = true, },
	rainbow = { enable = true, disable = {"html"},},
	-- textobjects = {
	-- 	move = {
	-- 		enable = true,
	-- 		set_jumps = true,
	-- 		goto_next_start = {
	-- 			[']f'] = '@function.outer',
	-- 		},
	-- 		goto_next_end = {
	-- 			[']F'] = '@function.outer',
	-- 		},
	-- 		goto_previous_start = {
	-- 			['[f'] = '@function.outer',
	-- 		},
	-- 		goto_previous_end = {
	-- 			['[F'] = '@function.outer',
	-- 		},
	-- 	},
	-- },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
parser_config.typescript.filetype_to_parsername = { "javascript", "typescript.tsx" }