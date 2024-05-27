local status, cmp = pcall(require, "cmp")
if not status then
  return
end

local luasnip = require("luasnip")
local lspkind = require('lspkind')

-- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
require("luasnip.loaders.from_vscode").lazy_load()

-- loading snippets relative to the directory of $MYVIMRC
require("luasnip.loaders.from_vscode").load({ paths = "./snippets/rust" })
require("luasnip.loaders.from_vscode").load({ paths = "./snippets/python" })
require("luasnip.loaders.from_vscode").load({ paths = "./snippets/typescript" })

local border = {
  { "╭", "CmpBorder" },
  { "─", "CmpBorder" },
  { "╮", "CmpBorder" },
  { "│", "CmpBorder" },
  { "╯", "CmpBorder" },
  { "─", "CmpBorder" },
  { "╰", "CmpBorder" },
  { "│", "CmpBorder" },
}

local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered({
      border = border,
    }),
    documentation = {
      border = border,
    },
  },
  mapping = cmp.mapping.preset.insert({
    ['C-k'] = cmp.mapping.select_prev_item(), -- previous suggestion
    ['C-j'] = cmp.mapping.select_next_item(), -- next suggestion
    ['C-b'] = cmp.mapping.scroll_docs(-4),
    ['C-f'] = cmp.mapping.scroll_docs(4),
    ['C-Space'] = cmp.mapping.complete(), -- show completion suggestions
    ['C-e'] = cmp.mapping.abort(),        -- close completion window
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      elseif require('luasnip').expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end, { "i", "s", }
    ),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() and has_words_before() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
      elseif require('luasnip').jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end, { "i", "s", }
    ),
  }),

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = "luasnip", },
    { name = "buffer", },
    { name = "path", },
    { name = "copilot", },
    -- { name = "emoji"},
    -- { name = "calc"},
  }),
  formatting = {
    fields = { "menu", "abbr", "kind" },
    format = lspkind.cmp_format({
      before = function(entry, vim_item)
        local icons = require("utils.icons").kinds
        if icons[vim_item.kind] then
          vim_item.kind = icons[vim_item.kind] .. vim_item.kind
        end

        local duplicates = {
          buffer = 1,
          path = 1,
          nvim_lsp = 0,
          luasnip = 1,
        }

        vim_item.menu = ({
          nvim_lsp = '[λ LSP]',
          luasnip = '[󰘦 Snippet]',
          buffer = '[ Buffer]',
          path = '[ Path]',
          copilot = '[ Copilot]',
          -- emoji = '[󰞅 Emoji]',
          -- calc = '[󱖦 Calc]',
        })[entry.source.name]

        -- if entry.source.name == "vsnip" or entry.source.name == "nvim_lsp" or entry.source.name == "luasnip" then
        vim_item.dup = duplicates[entry.source.name] or 0
        -- end

        return vim_item
      end
    })
  },
}

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false },
})
