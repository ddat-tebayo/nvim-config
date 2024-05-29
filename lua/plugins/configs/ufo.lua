-------------------- UFO config --------------------
local status, ufo = pcall(require, "ufo")
if not status then
  return
end

-- Adding number suffix of folded lines instead of the default ellipsis
local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local suffix = (' 󰁂 %d '):format(endLnum - lnum)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  table.insert(newVirtText, { suffix, 'MoreMsg' })
  return newVirtText
end

ufo.setup({
  -- close_fold_kinds_for_ft = {
  --   default = {"imports", "comment"},
  --   json = {"array"},
  --   c = {"comment", "region"},
  -- },
  provider_selector = function(bufnr, filetype, buftype)
    -- return {'treesitter', 'indent'}
    return { 'lsp', 'indent' }
  end,
  fold_virt_text_handler = handler
})

-------------------- Statuscol config --------------------
local builtin = require('statuscol.builtin')

require("statuscol").setup({
  setopt = true,
  relculright = true,
  ft_ignore = { "NvimTree", "toggleterm" },
  bt_ignore = nil,
  -- -- segments (sign -> linenumber + separator -> fold)
  segments = {
    { text = { ' %s' }, click = 'v:lua.ScSa' },
    {
      text = { builtin.lnumfunc, ' ' },
      condition = { true, builtin.not_empty },
      click = 'v:lua.ScLa',
    },
    { text = { builtin.foldfunc, '  ' }, click = 'v:lua.ScFa' },
  }
})
