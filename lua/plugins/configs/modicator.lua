local status, modicator = pcall(require, "modicator")
if not status then
    return
end

local autocmd = vim.api.nvim_create_autocmd
local set_hl = vim.api.nvim_set_hl

-- NOTE: Modicator requires line_numbers and cursorline to be enabled
modicator.setup({
	-- Show warning if any required option is missing
	-- show_warnings = true,
	highlights = {
		-- Default options for bold/italic. You can override these individually
		-- for each mode if you'd like as seen below.
		defaults = {
			bold = true,
			italic = true,
		},
		integration = {
			lualine = {
			  enabled = false,
			  -- Letter of lualine section to use (if `nil`, gets detected automatically)
			  mode_section = nil,
			  -- Whether to use lualine's mode highlight's foreground or background
			  highlight = 'bg',
			},
		  },
		-- Color and bold/italic options for each mode. You can add a bold and/or
		-- italic key pair to override the default highlight for a specific mode if
		-- you would like.
	},
})

autocmd("VimEnter",{
	pattern = "*",
	callback = function()
		set_hl(0, "NormalMode", { fg = "#37a807" })
		set_hl(0, "InsertMode", { fg = "#559dd7" })
		set_hl(0, "VisualMode", { fg = "#c687c1" })
		set_hl(0, "CommandMode", { fg = "#eeeeee" })
		set_hl(0, "ReplaceMode", { fg = "#f0a400" })
		set_hl(0, "SelectMode", { fg = "#c687c1" })
		-- set_hl(0, "TerminalMode", { fg = "#eeeeee" })
		-- set_hl(0, "TerminalNormalMode", { fg = "#eeeeee" })
	end,
})