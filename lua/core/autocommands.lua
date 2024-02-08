local autocmd = vim.api.nvim_create_autocmd

-- Disable the statusline, tabline and cmdline while the alpha dashboard is open
autocmd('User', {
  pattern = 'AlphaReady',
  desc = 'disable status, tabline and cmdline for alpha',
  callback = function()
	  vim.go.laststatus = 0
    vim.opt.showtabline = 0
	  vim.opt.cmdheight = 0
  end,
  })
-- Enable the statusline, tabline and cmdline after the dashboard was opened
autocmd('BufUnload', {
  buffer = 0,
  desc = 'enable status, tabline and cmdline after alpha',
  callback = function()
    vim.go.laststatus = 3 
    vim.opt.showtabline = 2
    vim.opt.cmdheight = 1
  end,
  })
-- Closes neovim automatically when nvim-tree is the last window in the view
local function is_modified_buffer_open(buffers)
  for _, v in pairs(buffers) do
      if v.name:match("NvimTree_") == nil then
          return true
      end
  end
  return false
end

autocmd("BufEnter", {
  nested = true,
  callback = function()
      if
          #vim.api.nvim_list_wins() == 1
          and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil
          and is_modified_buffer_open(vim.fn.getbufinfo({ bufmodified = 1 })) == false
      then
          vim.cmd("quit")
      end
  end,
})
---------------

