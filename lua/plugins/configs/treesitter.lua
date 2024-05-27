local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

treesitter.setup {
  ensure_installed = {
    "vim",
    "bash",
    "html",
    "css",
    "scss",
    "javascript",
    "json",
    "tsx",
    "typescript",
    "python",
    "prisma",
    "svelte",
    "graphql",
    "dockerfile",
    "query",
    "lua",
    "toml",
    "yaml",
    "markdown",
    "markdown_inline",
    "regex",
  },
  sync_install = false,
  auto_install = true,
  ignore_install = { "" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      node_incremental = '<CR>',
      scope_incremental = false,
      node_decremental = '<BS>',
    },
  },
  indent = { enable = true, },
  autotag = { enable = true, },
  textobjects = {
    move = {
      enable = true,
      goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
      goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
      goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
      goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
    },
  },
}

