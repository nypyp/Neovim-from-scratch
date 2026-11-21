---
name: nvim
description: Use when answering questions about Neovim usage — commands, keymaps, LSP, plugins, options, :help lookups ("nvim 中如何…", restart LSP, :LspRestart not found) — or when maintaining the ~/.config/nvim configuration repo (adding keymaps, LSP servers, plugin config).
---

# Neovim 用法与配置维护

## 核心纪律:实测,不凭记忆

Neovim 的命令和插件行为随版本差异巨大。凭记忆回答,就会自信地推荐一个不存在的命令(真实事故:建议 `:LspRestart`,用户执行报 E492)。

**任何关于"有没有这个命令 / 它做什么"的断言,回答前必须在用户的真实 nvim 上验证。**

三条验证手段(按顺序用):

1. **探测活的编辑器**(ground truth):
   ```bash
   nvim --headless "+lua print(vim.fn.exists(':LspRestart'))" +qa 2>&1
   ```
   返回 `2` = 存在,`0` = 不存在。选项用 `vim.o.xxx` 探测,键位用 `vim.fn.maparg('gd','n')`,autocmd 用 `vim.api.nvim_get_autocmds`。
2. **查本机安装的文档**:VIMRUNTIME 路径 = `nvim --headless "+lua print(vim.env.VIMRUNTIME)" +qa 2>/dev/null`,然后 grep 该目录下的 `doc/*.txt`。"怎么做 X" 的答案通常就写在里面。
3. **读实际安装的插件源码**(`~/.local/share/nvim/lazy/<plugin>/`):注意**开头的 guard 条件和版本分支**——grep 到定义 ≠ 这段代码会被执行。

### 合理化对照表

| 借口 | 现实 |
|---|---|
| "我 grep 到插件里定义了这个命令" | 定义上方的 guard 可以整个跳过注册(见下方陷阱)。`vim.fn.exists(':Cmd')` 才是事实。 |
| "0.12 肯定有 X" | 版本差异是 nvim 常态。探测只要 1 秒。 |
| "简单问题,凭经验直接答" | 答错命令浪费用户排查时间,比慢 1 分钟贵得多。 |

**红灯自检**——出现这些念头说明你在凭记忆答,停下来先探测:
"应该有 / 我记得 / 一般是这样 / 这个很常见不用查 / 插件源码里有就是有"。

## 已知陷阱(血泪)

- **Neovim 0.12+ 内置 `:lsp` 命令 ⇒ nvim-lspconfig 不注册任何 `:Lsp*` 命令。**
  `plugin/lspconfig.lua` 开头 `if vim.fn.exists(':lsp') == 2 then return end` 直接返回。
  `:LspRestart`、`:LspStart`、`:LspStop`、`:LspInfo`、`:LspLog` 全部不存在。等价物是内置子命令(`:help lsp-commands`):

  | 想做的事 | 用这个 |
  |---|---|
  | 重启 client(重读 compile_commands.json) | `:lsp restart [client]` |
  | 停止 / 禁止自动启动 | `:lsp stop [client]` / `:lsp disable [name]` |
  | 重新启用 | `:lsp enable [name]` |
  | 查状态 | `:checkhealth vim.lsp` |
  | 看日志 | `:lua print(vim.lsp.log.get_filename())` |

- **Mason 版 clangd 与仓库 `.clangd` 的 `CompilationDatabase` 配合**:重建 `compile_commands.json` 后,clangd 不会自动重读,需要 `:lsp restart clangd`。

## 配置地图(~/.config/nvim,git 仓库 nypyp/Neovim-from-scratch)

| 位置 | 管什么 |
|---|---|
| `init.lua` | 入口,加载 `lua/plugins/` 和 `lua/user/` |
| `lua/plugins/init.lua` | lazy.nvim 插件清单(改插件在这里) |
| `lua/user/options.lua` / `keymaps.lua` / `cmp.lua` / `colorscheme.lua` | 选项 / 全局键位 / 补全 / 主题 |
| `lua/user/lsp/mason.lua` | LSP server 清单(`servers` 表)+ `vim.lsp.config/enable` |
| `lua/user/lsp/handlers.lua` | 诊断显示 + `LspAttach` buffer 级键位 |
| `lua/user/lsp/settings/<server>.lua` | 按 server 覆盖配置;没有该文件 = 用 lspconfig 默认 |

改完配置用 headless 探测或 `:checkhealth` 验证,再告诉用户完成。

## 常见任务配方

| 任务 | 做法 |
|---|---|
| 重启 LSP / 重读编译数据库 | `:lsp restart clangd` |
| 查命令是否存在 | `nvim --headless "+lua print(vim.fn.exists(':Cmd'))" +qa 2>&1` |
| 查内置文档 | grep `$(nvim --headless "+lua print(vim.env.VIMRUNTIME)" +qa 2>/dev/null)/doc/` |
| 加键位 | 全局 → `lua/user/keymaps.lua`;LSP buffer 级 → `handlers.lua` 的 `map()` |
| 加 LSP server | `mason.lua` 的 `servers` 表;需要覆盖再加 `settings/<name>.lua` |
