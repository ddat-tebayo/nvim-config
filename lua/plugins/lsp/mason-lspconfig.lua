local status, mason_lsp = pcall(require, "mason-lspconfig")
if not status then
    return
end

require('mason').setup()
mason_lsp.setup({
    -- list of servers for mason to install
    ensure_installed = {
        "html",
        "cssls",
        "tailwindcss",
        "tsserver",
        "prismals",
        "svelte",
        "pyright",
        "lua_ls",
        "graphql",
        "emmet_ls",
    },
})