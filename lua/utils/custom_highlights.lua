local M = {}

M.colors = {
  Red = "#F7768E",
  Orange = "#ff966c",
  Yellow = "#E0AF68",
  Green = "#9ECE6A",
  White = "#C0CAF4",
  Blue = "#7297E6",
  Cyan = "#7DCFFF",
  Violet = "#9d7cd8"
}

function M.set_custom_highlights()
  for name, color in pairs(M.colors) do
    vim.cmd(string.format("highlight Custom%s guifg=%s", name, color))
  end
end

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    M.set_custom_highlights()
  end
})

M.set_custom_highlights()

return M