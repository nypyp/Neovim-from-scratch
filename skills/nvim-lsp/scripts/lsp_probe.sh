#!/usr/bin/env bash
# lsp_probe: ask a live LSP server what a request actually returns, headlessly.
#
#   lsp_probe.sh <file> <line> <col> [method ...]
#
# line is 1-based, col is 0-based (LSP convention). Methods default to
# textDocument/definition. Prints one JSON line per method with the raw result,
# so "jump in place" bugs can be pinned to keymap / attach / request / server
# without touching the UI.
set -euo pipefail

file=${1:?usage: lsp_probe.sh <file> <line> <col> [method ...]}
line=${2:?}
col=${3:?}
shift 3
methods=("$@")
[ ${#methods[@]} -gt 0 ] || methods=(textDocument/definition)

lua_methods=$(printf '"%s",' "${methods[@]}")
lua_methods=${lua_methods%,}

timeout 60 nvim --headless "$file" \
  "+lua vim.wait(30000, function() return #vim.lsp.get_clients() > 0 end)
local n = #vim.lsp.get_clients()
if n == 0 then print('PROBE-ERROR: no LSP client attached within 30s') vim.cmd('cquit 1') end
vim.api.nvim_win_set_cursor(0, {$line, $col})
local enc = vim.lsp.get_clients()[1].offset_encoding
for _, m in ipairs({$lua_methods}) do
  local p = vim.lsp.util.make_position_params(0, enc)
  local r = vim.lsp.buf_request_sync(0, m, p, 15000)
  print('METHOD: '..m)
  print(vim.inspect(r))
end" +qa 2>&1 | grep -v "^$"
