local opt = vim.opt
local g = vim.g

local default_options = {

  clipboard = "unnamedplus", --allows neovim to access the system clipboard
  completeopt = {"noinsert", "menuone", "noselect"}, --mostly just for completion
  fileencoding = "utf-8", --the encoding written to a file
  undofile = true, --enable persistent undo
  swapfile = false, --creates a swapfile

  updatetime = 300, --faster completion (4000ms default)
  timeoutlen = 100, --time to wait for a mapped sequence to complete (in milliseconds)

  ignorecase = true, --ignore case in search patterns
  smartcase = true, --smart case

  splitbelow = true, --force all horizontal splits to go below current window
  splitright = true, --force all vertical splits to go to the right of current window


  mouse = "a", --allow the mouse to be used in neovim
  showmode = false, --we don't need to see things like -- INSERT -- anymore
  wrap = false, --display lines as one long line
  hlsearch = true, --highlight all matches on previous search pattern
  signcolumn = "yes",
  inccommand = "split",
  termguicolors = true, --set term gui colors
  cmdheight = 1, --more space in the neovim command line for displaying messages (default 1)

  expandtab = true, --convert tabs to spaces
  shiftwidth = 2, --the number of spaces inserted for each indentation
  tabstop = 2, --insert 2 spaces for a tab
    --set numbered lines, ralative numbered lines
  number = true,
  relativenumber = true,
  cursorline = true,
    --keep the cursor to the center of screen, default is first line/last line
  scrolloff = 8,          
  sidescrolloff = 8,
}

for k, v in pairs(default_options) do
  opt[k] = v
end

---  SETTINGS  ---
opt.spelllang:append "cjk" -- disable spellchecking for asian characters (VIM algorithm does not support it)
opt.shortmess:append "c" -- don't show redundant messages from ins-completion-menu
opt.shortmess:append "I" -- don't show the default intro message
opt.whichwrap:append "<,>,[,],h,l" -- go to previous/next line with h,l,l/right arrow when cursor reaches end beginning of line
opt.iskeyword:append("-")
opt.formatoptions:remove { "c", "r", "o" } -- Disabling autocommenting for all filetypes

--- Disable some unused built-in vim plugins ---
local default_plugins = {
	"2html_plugin",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"matchit",
	"tar",
	"tarPlugin",
	"rrhelper",
	"spellfile_plugin",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
	"tutor",
	"rplugin",
	"syntax",
	"synmenu",
	"optwin",
	"compiler",
	"bugreport",
	"ftplugin",
}

for _, plugin in pairs(default_plugins) do
	g["loaded_" .. plugin] = 1
end
-----------------------------------
--- NEOVIDE SETTINGS  ---
if g.neovide then
  opt.guifont = "JetBrainsMono_Nerd_Font:h9.5"
  g.neovide_hide_mouse_when_typing = true
end
