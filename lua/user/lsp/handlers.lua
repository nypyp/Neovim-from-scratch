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
    -- 纪律:desc 必填(经 map() 强制)。Neovim 内置自带 desc 的键位
    -- (grn/gra/grx/grr/gri/grt/gO、[d/]d、<C-W>d 等)勿重复映射。
    local function map(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
    end

    map("gD", vim.lsp.buf.declaration, "Go to declaration")
    map("gd", vim.lsp.buf.definition, "Go to definition")
    map("gl", vim.diagnostic.open_float, "Line diagnostics")
    map("[d", function()
      vim.diagnostic.jump({ count = -vim.v.count1, float = { border = "rounded" } })
    end, "Prev diagnostic")
    map("]d", function()
      vim.diagnostic.jump({ count = vim.v.count1, float = { border = "rounded" } })
    end, "Next diagnostic")
    map("<leader>q", vim.diagnostic.setloclist, "Diagnostics to loclist")
    map("K", function()
      vim.lsp.buf.hover({ border = "rounded" })
    end, "Hover")
    if client.server_capabilities.signatureHelpProvider then
      map("<C-k>", function()
        vim.lsp.buf.signature_help({ border = "rounded" })
      end, "Signature help")
    end

    -- 补全交给 blink.cmp（不再使用内置自动补全，避免两个菜单同时弹出）
    -- if client:supports_method("textDocument/completion") then
    --   vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
    -- end

    -- :Format command
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
      vim.lsp.buf.format({ bufnr = bufnr })
    end, { desc = "Format buffer with LSP" })
  end,
})

-- LSP capabilities（由 blink.cmp 提供）
local M = {}

local caps = vim.lsp.protocol.make_client_capabilities()
local ok_blink, blink = pcall(require, "blink.cmp")
if ok_blink then
  caps = blink.get_lsp_capabilities(caps)
end

-- 作为全局默认，所有 LSP server 都会继承
vim.lsp.config("*", {
  capabilities = caps,
})
M.capabilities = caps

return M
