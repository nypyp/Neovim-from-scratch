-- Restore themery saved theme, fallback catppuccin
local state_file = vim.fn.stdpath("data") .. "/themery/state.json"
local ok, lines = pcall(vim.fn.readfile, state_file)
if ok and lines then
  local ok2, data = pcall(vim.json.decode, table.concat(lines))
  if ok2 and data and data.colorscheme then
    pcall(vim.cmd.colorscheme, data.colorscheme)
    return
  end
end
pcall(vim.cmd.colorscheme, "catppuccin")

