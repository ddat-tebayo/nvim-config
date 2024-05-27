local status, lualine = pcall(require, "lualine")
if not status then
  return
end

local navic = require("nvim-navic")
local icons = require("utils.icons")

-- Customizing my own color theme
local colors = {
  green = '#608c4d',
  blue = '#559dd7',
  purple = '#c687c1',
  orange = '#e6ac30',
  red = '#d26969',
  black = '#1a1c23',
  light_grey = '#2e303e',
  grey = '#5c5f7e',
  white = '#eeeeee'
}

local my_theme_colors = {
  normal = {
    a = { fg = colors.black, bg = colors.green },
    b = { fg = colors.green, bg = colors.light_grey },
    c = { fg = colors.grey, bg = colors.black },
  },

  insert = {
    a = { fg = colors.black, bg = colors.blue }, b = { fg = colors.blue, bg = colors.light_grey },
  },
  visual = {
    a = { fg = colors.black, bg = colors.purple }, b = { fg = colors.purple, bg = colors.light_grey },
  },
  replace = {
    a = { fg = colors.black, bg = colors.orange }, b = { fg = colors.red, bg = colors.light_grey },
  },
  command = {
    a = { fg = colors.black, bg = colors.white }, b = { fg = colors.white, bg = colors.light_grey },
  },

  inactive = {
    a = { fg = colors.grey, bg = colors.black },
    b = { fg = colors.grey, bg = colors.black },
    c = { fg = colors.grey, bg = colors.black },
  },
}

-- Hide sections as the window width decreases to save space for necessary sections.
local function min_window_width(width)
  return function() return vim.fn.winwidth(0) > width end
end

-- Component options
local diagnostics = {
  "diagnostics",
  -- Table of diagnostic sources, available sources are:
  --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
  sources = { "nvim_lsp" },
  sections = { "error", "warn" },
  symbols = { error = icons.diagnostics.error, warn = icons.diagnostics.warn },
  always_visible = true,
}

local filename = { "filename", cond = min_window_width(55) }
local branch = { "branch", cond = min_window_width(60) }

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end
local diff = {
  "diff",
  symbols = {
    added = icons.git.added,
    modified = icons.git.modified,
    removed = icons.git.removed
  },
  source = diff_source,
  cond = min_window_width(40)
}

local encoding = { "encoding", cond = min_window_width(80) }
local filetype = { "filetype", cond = min_window_width(80) }

lualine.setup {
  options = {
    theme = my_theme_colors,
    component_separators = { left = '', right = '|' },
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { diagnostics },
    lualine_c = { filename },
    lualine_x = { branch, diff },
    lualine_y = { encoding, filetype },
    lualine_z = { 'location' }
  },
  winbar = {
    lualine_c = {
      {
        function()
          return navic.get_location()
        end,
        cond = function()
          return navic.is_available()
        end
      },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { filename },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
}
