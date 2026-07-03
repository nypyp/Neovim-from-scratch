return {
  -- Colorscheme (loaded early)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
      integrations = {
        lualine = true,
        snacks = true,
        which_key = true,
        noice = true,
        gitsigns = true,
        indent_blankline = true,
        treesitter = true,
      },
    },
  },

  -- Alternative colorschemes (for themery switcher)
  -- opencode TUI built-in theme ports:
  {
    "folke/tokyonight.nvim",
    lazy = true,
    priority = 900,
    opts = { style = "night" },
  },
  {
    "Mofiqul/vscode.nvim",
    lazy = true,
    priority = 900,
    opts = {},
  },
  {
    "D0nw0r/dark2026.nvim",
    lazy = true,
    priority = 900,
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    priority = 900,
    opts = {},
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    priority = 900,
    opts = { compile = false },
  },
  {
    "shaunsingh/nord.nvim",
    lazy = true,
    priority = 900,
  },
  {
    "olimorris/onedarkpro.nvim",
    lazy = true,
    priority = 900,
    opts = {},
  },
  {
    "Mofiqul/dracula.nvim",
    lazy = true,
    priority = 900,
    opts = {},
  },
  {
    "neanias/everforest-nvim",
    lazy = true,
    priority = 900,
    config = function()
      vim.g.everforest_background = "soft"
    end,
  },
  {
    "Shatur/neovim-ayu",
    lazy = true,
    priority = 900,
    config = function()
      vim.g.ayu_termcolors = 256
    end,
  },

  -- Icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- Utility
  "nvim-lua/popup.nvim",
  "nvim-lua/plenary.nvim",

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
  },

  -- LSP
  "neovim/nvim-lspconfig",
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
  },
  "williamboman/mason-lspconfig.nvim",
  "nvimtools/none-ls.nvim",

  -- Clangd extras (type hierarchy, symbol info)
  {
    "p00f/clangd_extensions.nvim",
    opts = {},
  },

  -- UI
  {
    "nvim-lualine/lualine.nvim",
    opts = {},
  },
  "cbochs/grapple.nvim",

  -- File tree (replaces netrw)
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>e", ":Neotree toggle<CR>", desc = "Toggle file tree" },
    },
    opts = {
      filesystem = {
        follow_current_file = { enabled = true },
        hijack_netrw_behavior = "open_current",
        filtered_items = {
          visible = true,        -- 显示隐藏文件/点文件
          hide_dotfiles = false, -- 不隐藏 .xxx 文件
          hide_gitignore = false,
        },
      },
    },
  },

  -- Markdown rendering
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {},
    ft = { "markdown", "codecompanion" },
  },

  -- Key popup
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Modern cmdline / notification UI
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {
      lsp = { progress = { enabled = true } },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
      },
    },
  },

  -- Git signs in gutter
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Aerial: code outline / symbol tree
  {
    "stevearc/aerial.nvim",
    lazy = true,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>a", "<cmd>AerialToggle right<CR>", desc = "Toggle outline (right)" },
      { "<leader>A", "<cmd>AerialToggle left<CR>", desc = "Toggle outline (left)" },
    },
    opts = {
      layout = {
        max_width = { 50, 0.25 },
        min_width = 30,
      },
      show_guides = true,
      filter_kind = {
        "Class",
        "Constructor",
        "Enum",
        "Function",
        "Interface",
        "Method",
        "Struct",
      },
      keymaps = {
        ["<Esc>"] = "actions.close",
        ["l"] = "actions.toggle_node",
        ["h"] = "actions.parent_node",
        ["J"] = "actions.prev",
        ["K"] = "actions.next",
      },
    },
  },

  -- Indent guide lines
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VeryLazy",
    opts = {
      indent = { char = "│" },
    },
  },

  -- Treesitter (better syntax highlighting, folding)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = {
        "c", "cpp", "lua", "vim", "vimdoc", "query",
        "python", "markdown", "markdown_inline",
        "yaml", "json", "bash", "cmake",
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    },
  },

  -- Theme switcher (like VSCode)
  {
    "zaldih/themery.nvim",
    lazy = true,
    cmd = "Themery",
    opts = {
      themes = {
        { name = "Catppuccin",  colorscheme = "catppuccin" },
        { name = "Tokyonight",  colorscheme = "tokyonight" },
        { name = "VSCode",          colorscheme = "vscode" },
        { name = "Dark 2026",       colorscheme = "dark2026" },
        { name = "Gruvbox",     colorscheme = "gruvbox" },
        { name = "Kanagawa",    colorscheme = "kanagawa" },
        { name = "Nord",        colorscheme = "nord" },
        { name = "OneDark",     colorscheme = "onedark" },
        { name = "Dracula",     colorscheme = "dracula" },
        { name = "Everforest",  colorscheme = "everforest" },
        { name = "Ayu",         colorscheme = "ayu" },
      },
      livePreview = true,
    },
    keys = {
      { "<leader>c", "<cmd>Themery<CR>", desc = "Theme picker" },
    },
  },

  -- snacks.nvim —— 提供 picker / input 等 UI 能力
  -- （原先作为 opencode 的依赖被引入，opencode 删除后提升为独立插件；
  --   文件查找键位 <leader>ff/fg/fb 与 CodeCompanion 历史选择器都依赖它）
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      input = {},
      picker = {},
    },
  },

  -- 补全引擎：blink.cmp
  -- 为 LSP、代码片段、路径、缓冲区提供自动补全；
  -- 同时驱动 CodeCompanion 聊天里的 / # @ \ 补全菜单
  {
    "saghen/blink.cmp",
    version = "1.*", -- 使用发布版，自动下载预编译的 fuzzy 二进制
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      keymap = {
        preset = "super-tab", -- Tab 接受/跳转，S-Tab 上一项，<C-space> 手动唤出，<C-e> 关闭
        ["<C-k>"] = { "fallback" }, -- 让出 <C-k>，保留你已有的片段跳转键位
      },
      appearance = { nerd_font_variant = "mono" },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
        menu = { border = "rounded" },
      },
      cmdline = { enabled = false }, -- 命令行交给 noice，避免冲突
      sources = {
        default = { "lsp", "snippets", "path", "buffer" },
        per_filetype = {
          codecompanion = { "codecompanion" }, -- 启用 CodeCompanion 补全（兼容所有版本）
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },

  -- Kiro CLI —— 通过 codecompanion.nvim 的 ACP 适配器集成
  {
    "olimorris/codecompanion.nvim",
    version = "^19.0.0",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/codecompanion-history.nvim", -- 聊天历史：保存 / 浏览 / 恢复
    },
    opts = {
      -- 把 kiro 适配器设为聊天与内联改写的默认
      -- kiro 适配器底层执行 `kiro-cli acp`，复用终端已登录的认证，无需 API key
      interactions = {
        chat = { adapter = "kiro" },
        inline = { adapter = "kiro" },
      },
      extensions = {
        history = {
          enabled = true,
          opts = {
            keymap = "gh",              -- 聊天缓冲区内打开历史浏览器
            save_chat_keymap = "sc",    -- 手动保存当前聊天
            auto_save = true,           -- 自动保存聊天
            continue_last_chat = false, -- 不在打开聊天时自动载入上一次对话
            picker = "snacks",          -- 使用已安装的 snacks.nvim 作为选择器
            auto_generate_title = true, -- 自动为聊天生成标题
          },
        },
      },
    },
    cmd = {
      "CodeCompanion",
      "CodeCompanionChat",
      "CodeCompanionActions",
      "CodeCompanionCmd",
    },
    keys = {
      -- 官方推荐键位（https://codecompanion.olimorris.dev getting-started）
      { "<C-a>",          "<cmd>CodeCompanionActions<CR>",     mode = { "n", "v" }, desc = "CodeCompanion: 动作面板 (Actions)" },
      { "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<CR>", mode = { "n", "v" }, desc = "CodeCompanion: 切换聊天 (Toggle Chat)" },
      { "ga",             "<cmd>CodeCompanionChat Add<CR>",    mode = { "v" },      desc = "CodeCompanion: 添加选区到聊天 (Add)" },
    },
  },
}
