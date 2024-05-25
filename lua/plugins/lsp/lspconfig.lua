----- Diagnostics -----
local icons = require("utils.icons")

vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  virtual_text = {
    spacing = 4,
    source = "if_many",
    prefix = "󱅶 ",
    suffix = "  ",
  },
  severity_sort = true,
  signs = {},
})

for type, icon in pairs(icons.diagnostics) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

----- Handlers -----

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "rounded",
})

require("lspconfig.ui.windows").default_options.border = "rounded"

----- Capabilities -----

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities = vim.lsp.protocol.make_client_capabilities()
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

----- On attach -----

local on_attach = function(client, bufnr)
  require('plugins.lsp.lsp_keymaps').lsp_keymaps()

  --  Inlay hints: I have temporarily disabled inlay hints because I am not yet familiar with using.
  if client.supports_method "textDocument/inlayHint" then
    vim.lsp.inlay_hint.enable(false)
  end
end

------------------------------
local servers = { "html", "cssls", "tailwindcss", "tsserver", "prismals", "svelte", "pyright", "lua_ls", "graphql", "emmet_ls" }

for _, server in pairs(servers) do
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }
  local has_custom_opts, server_custom_opts = pcall(require, "plugins.lsp.providers." .. server)
  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", server_custom_opts, opts)
  end
  require("lspconfig")[server].setup(opts)
end