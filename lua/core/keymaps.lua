local function get_opts(desc, expr)
  return { noremap = true, silent = true, desc = desc, expr = expr or false }
end

local map = function(modes, key, cmd, opts)
  vim.keymap.set(modes, key, cmd, opts)
end

--Remap space as leader key
map("", "<Space>", "<Nop>", get_opts('Leader Key'))
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

--  _  __
-- | |/ /___ _   _ _ __ ___   __ _ _ __  ___
-- | ' // _ \ | | | '_ ` _ \ / _` | '_ \/ __|
-- | . \  __/ |_| | | | | | | (_| | |_) \__ \
-- |_|\_\___|\__, |_| |_| |_|\__,_| .__/|___/
--           |___/                |_|

-- Basic Keymaps
map("i", "jk", "<ESC>", get_opts("Exit Insert Mode"))
map("n", ";", ":", get_opts('Command Mode'))
map({ "n", "i" }, "<C-s>", "<cmd>w!<cr>", get_opts('Save'))
map("n", "<C-a>", "gg<S-v>G", get_opts('Select all'))

-- Movement
map("i", "<C-d>", "<C-o><C-d>", get_opts("Scroll down in insert mode"))
map("i", "<C-u>", "<C-o><C-u>", get_opts("Scroll up in insert mode"))

-- Increment/decrement
map("n", "+", "<C-a>", get_opts('Increment'))
map("n", "-", "<C-x>", get_opts('Decrement'))

-- -- Navigate buffers
map("n", "<leader>b",
  "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
  get_opts("Select buffer"))
map("n", "<S-l>", ":bnext<CR>", get_opts('Next Buffer'))
map("n", "<S-h>", ":bprevious<CR>", get_opts('Previous Buffer'))


-- Split window
map("n", "<leader>wv", "<C-w>v", get_opts("Vertical split"))
map("n", "<leader>wh", "<C-w>s", get_opts("Horizontal split"))
map("n", "<leader>wr", "<C-w>r", get_opts("Rotate splits"))
map("n", "<leader>wq", "<C-w>q", get_opts("Close split"))
map("n", "<leader>w=", "<C-w>=", get_opts("Make split equal"))
map("n", "<leader>w|", "<C-w>|", get_opts("Maximize split"))

-- Better window navigation
map("n", "<C-h>", "<C-w>h", get_opts("Move to left window"))
map("n", "<C-l>", "<C-w>l", get_opts("Move to right window"))
map("n", "<C-j>", "<C-w>j", get_opts("Move to down window"))
map("n", "<C-k>", "<C-w>k", get_opts("Move to up window"))

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<cr>", get_opts("Resize Up"))
map("n", "<C-Down>", ":resize +2<cr>", get_opts("Resize Down"))
map("n", "<C-Left>", ":vertical resize -2<cr>", get_opts("Resize Left"))
map("n", "<C-Right>", ":vertical resize +2<cr>", get_opts("Resize Right"))

-- Stay in indent mode
map("v", "<", "<gv", get_opts("Left indent"))
map("v", ">", ">gv", get_opts("Right indent"))

-- Move text up and down
map("v", "<A-j>", ":m .+1<cr>==", get_opts("Move text up"))
map("v", "<A-k>", ":m .-2<cr>==", get_opts("Move text down"))
map("x", "<A-j>", ":move '>+1<cr>gv-gv", get_opts("Move line down"))
map("x", "<A-k>", ":move '<-2<cr>gv-gv", get_opts("Move text up"))
map("i", "<A-j>", "<Esc>:m .+1<cr>==gi", get_opts("Move line down"))
map("i", "<A-k>", "<Esc>:m .-2<cr>==gi", get_opts("Move line up"))

-- Tabs
map("n", "<C-n>", "<cmd>tabnew<cr>", get_opts("Create a new tab"))
map("n", "<A-,>", "<cmd>tabprevious<cr>", get_opts("Previous tab"))
map("n", "<A-.>", "<cmd>tabnext<cr>", get_opts("Next tab"))
