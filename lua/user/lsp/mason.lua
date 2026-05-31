local servers = { "lua_ls", "pyright", "jsonls", "clangd", "cmake" }

-- Mason: package manager for LSP servers
require("mason").setup({
  ui = {
    border = "none",
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
})

-- mason-lspconfig: auto-install servers via Mason
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_installation = true,
})

-- Apply per-server settings overrides
for _, server in ipairs(servers) do
  local ok, conf = pcall(require, "user.lsp.settings." .. server)
  if ok and type(conf) == "table" and not vim.tbl_isempty(conf) then
    vim.lsp.config(server, conf)
  end
end

-- Enable LSP servers (auto-activates by filetype)
vim.lsp.enable(servers)
