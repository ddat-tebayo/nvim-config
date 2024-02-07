local status, nvimtree = pcall(require, "nvim-tree")
if not status then
  return
end

local HEIGHT_RATIO = 0.8 -- You can change this
local WIDTH_RATIO = 0.5  -- You can change this too

nvimtree.setup({
      renderer = {
        root_folder_label = true,
      },
      filters = {
        dotfiles = true,
      },
      actions = {
        open_file = {
          resize_window = true,
          window_picker = {
            enable = false,  -- disable window_picker for explorer to work well with window splits
          },
        },
      },
      -- -- Left-side view
      -- view = {
      --   width = 25,
      -- },

      -- Float view
      view = {
        float = {
          enable = true,
          open_win_config = function()
            local screen_w = vim.opt.columns:get()
            local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
            local window_w = screen_w * WIDTH_RATIO
            local window_h = screen_h * HEIGHT_RATIO
            local window_w_int = math.floor(window_w)
            local window_h_int = math.floor(window_h)
            local center_x = (screen_w - window_w) / 2
            local center_y = ((vim.opt.lines:get() - window_h) / 2)
                             - vim.opt.cmdheight:get()
            return {
              border = "rounded",
              relative = "editor",
              row = center_y,
              col = center_x,
              width = window_w_int,
              height = window_h_int,
            }
            end,
        },
        width = function()
          return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
        end,
      },
    }
  )

-- transparent background for tree (if nvim bg is transparent and not work with float view)
vim.cmd[[hi NvimTreeNormal guibg=NONE ctermbg=NONE ]]
-- change color for arrows in tree to light blue
vim.cmd([[ highlight NvimTreeIndentMarker guifg=#3FC5FF ]])
