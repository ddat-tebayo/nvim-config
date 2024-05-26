local M = {}
local map = vim.keymap.set

M.create_select_menu = function(prompt, options_table)
  -- Given the table of options, populate a list with option display names
  local option_names = {}
  local n = 0
  for i, _ in pairs(options_table) do
    n = n + 1
    option_names[n] = i
  end
  table.sort(option_names)

  -- Return the prompt function. These global function var will be used when assigning keybindings
  local menu = function()
    vim.ui.select(
      option_names,      --> the list we populated above
      {
        prompt = prompt, --> Prompt passed as the argument Remove this variable if you want to keep the numbering in front of option names
        format_item = function(item)
          return item:gsub("%d. ", "")
        end,
      },

      function(choice)
        local action = options_table[choice]
        -- When user inputs ESC or q, don't take any actions
        if action ~= nil then
          if type(action) == "string" then
            vim.cmd(action)
          elseif type(action) == "function" then
            action()
          end
        end
      end
    )
  end

  return menu
end
-----------------------------

function M.lsp_keymaps()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      local bufnr = ev.buf
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

      local function opts(desc, expr)
        return { noremap = true, silent = true, buffer = bufnr, desc = desc, expr = expr or false }
      end

      map(
        "n", "<leader>c<leader>", function()
          local options = {
            ["1. Start LSP"] = "LspStart",
            ["2. Stop LSP"] = "LspStop",
            ["3. Restart LSP"] = "LspRestart",
            ["4. Lsp Info"] = "LspInfo",
            ["5. Lsp Log"] = "LspLog",
            ["6. Toggle LSP Diagnostics"] = "ToggleLspDiag",
            ["7. Toggle InlayHints"] = "ToggleInlayHints",
          }
          M.create_select_menu("Lsp Options", options)()
        end,
        opts("LSP Menu Options")
      )

      -- set keybinds
      map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts("Goto definitions"))
      map("n", "gD", vim.lsp.buf.declaration, opts("Goto declaration"))
      map("n", "gI", "<cmd>Telescope lsp_implementations<CR>", opts("Goto implementations"))
      map("n", "gr", "<cmd>Telescope lsp_references<CR>", opts("Show LSP references"))
      map("n", "gy", "<cmd>Telescope lsp_type_definitions<CR>", opts("Goto T[y]pe definition"))

      map("n", "<leader>ca", vim.lsp.buf.code_action, opts("Code Actions"))

      map("n", "<leader>cf", "<cmd>LspFormat<cr>", opts("Format"))

      map("n", "K", vim.lsp.buf.hover, opts("Hover documentation"))

      map("n", "<leader>ch", vim.lsp.buf.signature_help, opts("LSP Signature help"))
      map("i", "<C-h>", vim.lsp.buf.signature_help, opts("LSP Signature help"))

      map("n", "<leader>cC", vim.lsp.codelens.refresh, opts("Refresh & Display Codelens"))
      map("n", "<leader>cc", vim.lsp.codelens.run, opts("Run Codelens"))

      map("n", "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>", opts("Document Symbols"))
      map("n", "<leader>sS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", opts("Workspace Symbols"))

      map(
        "n", "<leader>cr",
        -- use inc-rename.nvim plugin or "vim.lsp.buf.rename"
        function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end,
        opts("Smart rename", true)
      )
    end,
  })
end

---------- Create user commands ----------
local notify = require('notify')
local cmd = vim.api.nvim_create_user_command

local enabled = true
cmd("ToggleLspDiag", function()
  -- if this Neovim version supports checking if diagnostics are enabled
  -- then use that for the current state
  if vim.diagnostic.is_enabled then
    enabled = vim.diagnostic.is_enabled()
  elseif vim.diagnostic.is_disabled then
    enabled = not vim.diagnostic.is_disabled()
  end
  enabled = not enabled

  if enabled then
    vim.diagnostic.enable()
    notify("Enabled diagnostics", "info", { title = "Diagnostics" })
  else
    vim.diagnostic.disable()
    notify("Disabled diagnostics", "warn", { title = "Diagnostics" })
  end
end, {})

cmd("ToggleInlayHints", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {})
end, {})

cmd("LspFormat", function()
  require("conform").format({ async = true, bufnr = 0, lsp_fallback = true })
end, { desc = "Format with LSP" })

------------------------------

return M
