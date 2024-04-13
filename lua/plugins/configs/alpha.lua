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
  local leader = '<LD>'

  local function button(usr_opts, txt, leader_txt, keybind, keybind_opts)
    
    local default_opts = {
      position = 'center',
      cursor = 5,
      width = 50,
      align_shortcut = 'right',
      hl_shortcut = 'Number'
    }
    local opts = vim.tbl_deep_extend('force', default_opts, usr_opts)
    
    local sc_after = usr_opts.shortcut:gsub('%s', ''):gsub(leader_txt, '<leader>')

    local function on_press()
      local key = vim.api.nvim_replace_termcodes(keybind or sc_after .. '<Ignore>', true, false, true)
      vim.api.nvim_feedkeys(key, 't', false)
    end

    if keybind then
      keybind_opts = vim.F.if_nil(keybind_opts, { noremap = true, silent = true, nowait = true })
      opts.keymap = { 'n', sc_after, keybind, keybind_opts }
    end

    return { type = 'button', val = txt, on_press = on_press, opts = opts, }
  end

  dashboard.section.buttons.val = {
    button({shortcut = "r", hl = {{'RainbowDelimiterViolet', 2, 3}}}, "  Recently opened files", leader, ":Telescope oldfiles <CR>"),
    button({shortcut = "e", hl = {{'RainbowDelimiterGreen', 2, 3}}}, "  New file", leader, ":ene <BAR> startinsert <CR>"),
    button({shortcut = "f", hl = {{'RainbowDelimiterCyan', 2, 3}}}, "  Find file", leader, ":cd $HOME/Workspace | Telescope find_files hidden=true path_display=smart<CR>"),
    button({shortcut = "t", hl = {{'Normal', 2, 3}}}, "  Find text", leader, ":Telescope live_grep path_display=smart<CR>"),
    button({shortcut = "p", hl = {{'RainbowDelimiterYellow', 2, 3}}}, "  Switch to project", leader, ":Telescope projects <CR>"),
    button({shortcut = "u", hl = {{'RainbowDelimiterBlue', 2, 3}}}, "  Update plugins", leader, ":Lazy sync<CR>"),
    button({shortcut = "q", hl = {{'RainbowDelimiterRed', 2, 3}}}, "  Quit Neovim", leader, ":qa<CR>"),
    -- button({shortcut = leader .. " f c", hl = {{'RainbowDelimiterOrange', 2, 3}}}, "  Configuration" , leader, ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
  }

----- Footer section -----
local function footer()
  local stats = require("lazy").stats()
  local plugins_count = stats.loaded .. "/" .. stats.count

  local datetime = os.date(" |  %H:%M   %d-%m-%Y | ")

  local version = vim.version()
  local nvim_version_info = "  v" .. version.major .. "." .. version.minor .. "." .. version.patch
  -----
  return  plugins_count .. " plugins  " .. datetime .. nvim_version_info
end

dashboard.section.footer.val = footer()
dashboard.section.footer.opts.hl = "RainbowDelimiterGreen"

----- Quote or texts section -----
local custom_texts = {
  type = "text",
  val = "Coup de Burst at the ready !",
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