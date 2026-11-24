-- map() helper:desc 必填,漏写会直接报错(防止再欠 desc 债)
local function keymap(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc })
end

--Remap space as leader key
vim.keymap.set("", "<Space>", "<Nop>", { silent = true, desc = "Leader key (disabled)" })

-- ============================================================
-- 键位约定（语义类目制，2026-11-20 与 agent 商定）
--   <leader>f*  查找（snacks picker: ff/fg/fb/fh/fr）
--   <leader>a*  OpenCode（aa=提问, as=功能选择）
--   <leader>o/O 大纲（aerial 右/左）
--   <leader>t   主题选择（Themery）
--   <leader>q   诊断列表（LSP attach 时注册）
--   go/goo      发送范围/当前行到 OpenCode（operator，支持 motion 与点重复）
-- 分工：派活收 diff → go/goo/aa（diff 审批自动弹 nvim）；问答会话文本 → 终端跑 opencode TUI 查看
-- 纪律：只设计"入口键"；插件内部键位保持官方默认不动
-- ============================================================

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", "Window: go left")
keymap("n", "<C-j>", "<C-w>j", "Window: go down")
keymap("n", "<C-k>", "<C-w>k", "Window: go up")
keymap("n", "<C-l>", "<C-w>l", "Window: go right")

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", "Window: decrease height")
keymap("n", "<C-Down>", ":resize +2<CR>", "Window: increase height")
keymap("n", "<C-Left>", ":vertical resize -2<CR>", "Window: decrease width")
keymap("n", "<C-Right>", ":vertical resize +2<CR>", "Window: increase width")

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", "Buffer: next")
keymap("n", "<S-h>", ":bprevious<CR>", "Buffer: previous")

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", "Move line down")
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", "Move line up")

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", "Exit insert mode")
keymap("i", "kj", "<ESC>", "Exit insert mode")

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", "Indent left (stay in visual)")
keymap("v", ">", ">gv", "Indent right (stay in visual)")

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", "Move selection down")
keymap("v", "<A-k>", ":m .-2<CR>==", "Move selection up")
keymap("v", "p", '"_dP', "Paste without yanking replaced text")

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", "Move block down")
keymap("x", "K", ":move '<-2<CR>gv-gv", "Move block up")
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", "Move block down")
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", "Move block up")

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", "Window: go left")
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", "Window: go down")
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", "Window: go up")
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", "Window: go right")

-- Snacks picker (file search, grep, etc.)
local snacks_map = vim.keymap.set
snacks_map("n", "<leader>ff", function() require("snacks").picker.files() end, { desc = "Find Files" })
snacks_map("n", "<leader>fg", function() require("snacks").picker.grep() end, { desc = "Live Grep" })
snacks_map("n", "<leader>fb", function() require("snacks").picker.buffers() end, { desc = "Buffers" })
snacks_map("n", "<leader>fh", function() require("snacks").picker.help() end, { desc = "Help" })
snacks_map("n", "<leader>fr", function() require("snacks").picker.recent() end, { desc = "Recent Files" })

-- 数字加减:+ 增大 / - 减小（顺手别名，<C-a>/<C-x> 原生保留）
vim.keymap.set("n", "+", "<C-a>", { desc = "Increment number" })
vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement number" })
