-- Snippet support
local luasnip_ok, luasnip = pcall(require, "luasnip")
if luasnip_ok then
  require("luasnip/loaders/from_vscode").lazy_load()
end

-- Snippet navigation (jump between tabstops)
vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if vim.snippet.active({ direction = 1 }) then
    vim.snippet.jump(1)
  end
end, { desc = "Next snippet tabstop" })

vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if vim.snippet.active({ direction = -1 }) then
    vim.snippet.jump(-1)
  end
end, { desc = "Prev snippet tabstop" })
