local options = {
  autoread = true,                         -- auto-reload files changed outside neovim
  backup = false,                          -- creates a backup file
  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
  cmdheight = 0,                           -- hide command line; shows on : or when messages appear
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0,                        -- so that `` is visible in markdown files
  fileencoding = "utf-8",                  -- the encoding written to a file
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  mouse = "a",                             -- allow the mouse to be used in neovim
  pumheight = 10,                          -- pop up menu height
  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2,                         -- always show tabs
  smartcase = true,                        -- smart case
  smartindent = true,                      -- make indenting smarter again
  splitbelow = true,                       -- force all horizontal splits to go below current window
  splitright = true,                       -- force all vertical splits to go to the right of current window
  swapfile = false,                        -- creates a swapfile
  termguicolors = true,                      -- set term gui colors (most terminals support this)
  inccommand = "split",                      -- live preview of substitute results
  timeoutlen = 1000,                        -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,                         -- enable persistent undo
  updatetime = 300,                        -- faster completion (4000ms default)
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                        -- convert tabs to spaces
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  tabstop = 2,                             -- insert 2 spaces for a tab
  cursorline = true,                       -- highlight the current line
  number = true,                           -- set numbered lines
  relativenumber = true,                   -- set relative numbered lines
  numberwidth = 4,                         -- set number column width to 2 {default 4}
  foldmethod = "expr",                     -- treesitter 折叠: 按函数/类/代码块折叠
  foldexpr = "v:lua.vim.treesitter.foldexpr()",
  foldlevel = 99,                          -- 默认全展开，需要时 zM
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  laststatus = 3,                          -- global statusline across all windows
  wrap = true,                            -- display lines as one long line, or true to wrap within screen
  linebreak = true,                        -- companion to wrap, don't split words
  scrolloff = 8,                           -- is one of my fav
  sidescrolloff = 8,
  guifont = "monospace:h17",               -- the font used in graphical neovim applications
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- 确保全局状态栏始终生效（themery 等插件切换主题后可能重置此选项）
-- 用 vim.schedule 延迟执行，使得 colorscheme 插件的所有初始化代码先跑完，再覆盖 laststatus
vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
  callback = function()
    vim.schedule(function()
      vim.opt.laststatus = 3
      vim.opt.showtabline = 2
    end)
  end,
})

-- 终端 buffer 中禁用 cursorline，避免 TUI 应用（如 opencode）中出现多余的高亮横条
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.wo.cursorline = false
  end,
})

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work
