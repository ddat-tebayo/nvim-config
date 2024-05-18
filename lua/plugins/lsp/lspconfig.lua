local keymap = vim.keymap -- for conciseness

function lsp_keymaps()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local opts = { buffer = ev.buf, silent = true, noremap = true }

      -- set keybinds
      opts.desc = "Show LSP references"
      keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

      opts.desc = "Go to declaration"
      keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

      opts.desc = "Show LSP definitions"
      keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

      opts.desc = "Show LSP implementations"
      keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

      opts.desc = "Show LSP type definitions"
      keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

      -- opts.desc = "See available code actions"
      -- keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

      opts.desc = "Smart rename"
      keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

      opts.desc = "Show buffer diagnostics"
      keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

      opts.desc = "Show line diagnostics"
      keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

      opts.desc = "Go to previous diagnostic"
      keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

      opts.desc = "Go to next diagnostic"
      keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

      opts.desc = "Show documentation for what is under cursor"
      keymap.set("n", "K", vim.lsp.buf.hover, opts)

      opts.desc = "Restart LSP"
      keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
    end,
  })
end

local on_attach = function(client, bufnr)
  lsp_keymaps()

  if client.supports_method "textDocument/inlayHint" then
    vim.lsp.inlay_hint.enable(true)
  end
end

local toggle_inlay_hints = function()
  local bufnr = vim.api.nvim_get_current_buf()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
end

function common_capabilities()
  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    return cmp_nvim_lsp.default_capabilities()
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  return capabilities
end
------------------------------------

----- Change the Diagnostic symbols
for type, icon in pairs(require("utils.icons").diagnostics) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

----- Handlers
local function set_handler_opts_if_not_set(name, handler, opts)
  if debug.getinfo(vim.lsp.handlers[name], "S").source:find(vim.env.VIMRUNTIME, 1, true) then
    vim.lsp.handlers[name] = vim.lsp.with(handler, opts)
  end
end

set_handler_opts_if_not_set("textDocument/hover", vim.lsp.handlers.hover, { border = "rounded" })
set_handler_opts_if_not_set("textDocument/signatureHelp", vim.lsp.handlers.signature_help, { border = "rounded" })

-- Enable rounded borders in :LspInfo window.
require("lspconfig.ui.windows").default_options.border = "rounded"

local servers = {"html", "cssls", "tailwindcss", "tsserver", "prismals", "svelte", "pyright", "lua_ls", "graphql", "emmet_ls"}

for _, server in pairs(servers) do
  local opts = {
    on_attach = on_attach,
    capabilities = common_capabilities(),
  }
  local has_custom_opts, server_custom_opts = pcall(require, "plugins.lsp.providers." .. server)
  if has_custom_opts then
      opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
  end
  require("lspconfig")[server].setup(opts)
end
