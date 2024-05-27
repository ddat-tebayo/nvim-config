-- Improve startup time in Neovim 0.9 and later, use this instead of the impatient.nvim plugin
if vim.loader then
  vim.loader.enable()
end

require('core')
require('lazyInit')
