local status, alpha = pcall(require, "alpha")
if not status then
    return
end

local dashboard = require("alpha.themes.dashboard")

----- Header section -----
math.randomseed(os.time())

local function pick_color()
    local colors = {"RainbowDelimiterRed", "RainbowDelimiterYellow", "RainbowDelimiterGreen", "RainbowDelimiterBlue", "RainbowDelimiterCyan", "RainbowDelimiterViolet"}
    return colors[math.random(#colors)]
end

dashboard.section.header.val = require("utils.dashboard_imgs").random()
dashboard.section.header.opts.hl = pick_color()

----- Buttons section -----
local leader = '<SPC>'

local function button(hl_group, sc, txt, keybind, keybind_opts, opts )
  local default_opts = {
    position = 'center',
    cursor = 5,
    width = 50,
    align_shortcut = 'right',
    hl_shortcut = 'Number'
  }

  local opts = opts and vim.tbl_deep_extend('force', default_opts, opts) or default_opts
  
  opts.hl = {{hl_group, 0, 3}} -- only highlight icon

  opts.shortcut = sc
  local sc_after = sc:gsub('%s', ''):gsub(leader, '<leader>')

  local function on_press()
    local key = vim.api.nvim_replace_termcodes(keybind or sc_after .. '<Ignore>', true, false, true)
    vim.api.nvim_feedkeys(key, 't', false)
  end

  if keybind then
    keybind_opts = vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
    opts.keymap = { 'n', sc_after, keybind, keybind_opts }
  end

  return { type = 'button', val = txt, on_press = on_press, opts = opts}
end
  
dashboard.section.buttons.val = {
  button('RainbowDelimiterViolet', "r", "  Recently opened files", "<cmd>Telescope oldfiles<cr>"),
  button('RainbowDelimiterGreen', "n", "  New file", ":ene <BAR> startinsert <CR>"),
  button('RainbowDelimiterCyan', "f", "  Find file", ":cd $HOME/Workspace | Telescope find_files hidden=true path_display=smart<CR>"),
  button('RainbowDelimiterBlue', "t", "  Find text", ":Telescope live_grep path_display=smart<CR>"),
  button('RainbowDelimiterYellow', "p", "  Switch to project", ":Telescope projects <CR>"),
  button('RainbowDelimiterBlue', "u", "  Update plugins", ":Lazy sync<CR>"),
  button('RainbowDelimiterRed', "q", "  Quit Neovim", ":qa<CR>"),
  -- button('RainbowDelimiterOrange', leader .. " c f", "  Configuration", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>")
}

----- Footer section -----
local function footer()
  local stats = require("lazy").stats()
  -- local plugins_count = stats.loaded .. "/" .. stats.count

  local datetime = os.date(" |  %H:%M   %d-%m-%Y | ")

  local version = vim.version()
  local nvim_version_info = "  v" .. version.major .. "." .. version.minor .. "." .. version.patch
  -----
  return  stats.count .. " plugins  " .. datetime .. nvim_version_info
end

dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = "RainbowDelimiterGreen"

----- Quote or texts section -----
local custom_texts = {
  type = "text",
  val = "󰀱 Coup de Burst at the ready 󱓞",
  opts = {
    position = "center",
    hl = "RainbowDelimiterCyan",
  },
}

--------- Layout ----------
dashboard.config.layout = {
  { type = "padding", val = 1 },
  dashboard.section.header,
  { type = "padding", val = 3 },
  dashboard.section.buttons,
  { type = "padding", val = 1 },
  dashboard.section.footer,
  { type = "padding", val = 1 },
  custom_texts,
}
  
dashboard.opts.opts.noautocmd = true

require("alpha").setup(dashboard.config)
