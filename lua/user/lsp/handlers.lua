-- Diagnostic display config
vim.diagnostic.config({
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.HINT] = "",
      [vim.diagnostic.severity.INFO] = "",
    },
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- LSP attach: keymaps and server-specific tweaks
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local bufnr = ev.buf
    if not client then
      return
    end

    -- Use prettier instead of tsserver for formatting
    if client.name == "tsserver" then
      client.server_capabilities.documentFormattingProvider = false
    end

    -- Buffer-local keymaps
    local opts = { noremap = true, silent = true, buffer = bufnr }

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover({ border = "rounded" })
    end, vim.tbl_extend("force", opts, { desc = "Hover" }))
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    if client.server_capabilities.signatureHelpProvider then
      vim.keymap.set("n", "<C-k>", function()
        vim.lsp.buf.signature_help({ border = "rounded" })
      end, opts)
    end
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "[d", function()
      vim.diagnostic.goto_prev({ border = "rounded" })
    end, opts)
    vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "]d", function()
      vim.diagnostic.goto_next({ border = "rounded" })
    end, opts)
    vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)

    -- Enable built-in LSP completion
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
    end

    -- :Format command
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
      vim.lsp.buf.format({ bufnr = bufnr })
    end, { desc = "Format buffer with LSP" })
  end,
})

-- LSP capabilities for nvim-cmp
local M = {}

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if status_ok then
  -- Apply as global default so all servers pick it up
  vim.lsp.config("*", {
    capabilities = cmp_nvim_lsp.default_capabilities(),
  })
  M.capabilities = cmp_nvim_lsp.default_capabilities()
end

return M
