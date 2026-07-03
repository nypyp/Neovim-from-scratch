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
    opts = {
      sections = {
        lualine_z = {
          {
            function()
              local ok, opencode = pcall(require, "opencode")
              return ok and opencode.statusline() or ""
            end,
          },
        },
      },
    },
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
    ft = { "markdown" },
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

  -- opencode
  {
    "nickjvandyke/opencode.nvim",
    version = "*",
    lazy = false,
    dependencies = {
      {
        "folke/snacks.nvim",
        opts = {
          input = {},
          picker = {
            actions = {
              opencode_send = function(...)
                return require("opencode").snacks_picker_send(...)
              end,
            },
            win = {
              input = {
                keys = {
                  ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                },
              },
            },
          },
        },
      },
    },
    init = function()
      vim.g.opencode_opts = {
        lsp = { enabled = true },
      }
      vim.api.nvim_create_autocmd("User", {
        pattern = "OpencodeEvent:*",
        callback = function(args)
          local event = args.data.event
          if event.type == "session.idle" then
            vim.notify("opencode 完成回复")
          end
        end,
      })
      vim.o.autoread = true
      vim.keymap.set("n", "+", "<C-a>", { desc = "Increment", noremap = true })
      vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement", noremap = true })
      -- Patch server/init.lua when installed
      local path = vim.fn.stdpath("data") .. "/lazy/opencode.nvim/lua/opencode/server/init.lua"
      local f = io.open(path, "r")
      if f then
        local content = f:read("*a")
        f:close()
        if content:find("vim%.schedule_wrap%(self%.disconnect%)") then
          content = content:gsub("vim%.schedule_wrap%(self%.disconnect%)", "vim.schedule_wrap(function() self:disconnect() end)")
          f = io.open(path, "w")
          f:write(content)
          f:close()
        end
      end
    end,
    keys = {
      { "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end, mode = { "n", "x" }, desc = "Ask opencode" },
      { "<C-x>", function() require("opencode").select() end, mode = { "n", "x" }, desc = "Select opencode" },
      { "<C-t>", function() require("opencode").toggle() end, mode = { "n", "t" }, desc = "Toggle opencode" },
      { "go", function() return require("opencode").operator("@this ") end, mode = { "n", "x" }, expr = true, desc = "Add range" },
      { "goo", function() return require("opencode").operator("@this ") .. "_" end, expr = true, desc = "Add line" },
    },
  },
}
