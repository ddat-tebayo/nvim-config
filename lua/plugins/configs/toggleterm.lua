local status, toggleterm = pcall(require,"toggleterm")
if not status then
  return
end

toggleterm.setup {
  size = 20,
  open_mapping = [[<c-\>]],
  highlights = {
    FloatBorder = {
      guifg = '#559dd7',
    },
  },
  float_opts = {
    border = 'curved',
    winblend = 3,
  },
}

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new{ 
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
}

function _lazygit_toggle()
  lazygit:toggle()
end
