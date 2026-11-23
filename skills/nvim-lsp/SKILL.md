---
name: nvim-lsp
description: Use when a Neovim LSP feature misbehaves — jump stays in place (gd/gD 不跳或跳错), hover/K shows nothing, completion doesn't pop, diagnostics missing or stale, LSP not attaching, clangd/lua_ls/pyright errors — or when asked about LSP behavior differences across servers ("为什么 gd 不跳", ":LspRestart 不存在", "clangd --check 是好的但跳转坏了"), or when changing ~/.config/nvim LSP config (mason.lua, handlers.lua, settings/).
---

# Neovim LSP 行为诊断

**纪律:实测,不凭记忆**——任何"应该能跳/应该 attach"的断言,先在用户的真实 nvim 上探测。行为问题用探针问协议层,别看 UI 猜。

## 观测点地图(每层在哪拿到事实)

| 层 | 观测手段 | 健康签名 |
|---|---|---|
| 键位 | `vim.fn.maparg('gd','n',false,true)`(headless 可测) | buffer-local 映射存在 |
| attach | `vim.lsp.get_clients()` | 目标 server 在列表 |
| 请求 | `scripts/lsp_probe.sh <file> <line> <col> [method...]` | 返回位置 ≠ 请求位置 |
| 服务端 | `:lua print(vim.lsp.log.get_filename())` 后 grep | 有该文件的 `Indexed`/无 `Failed` |

`scripts/lsp_probe.sh` headless 打开文件、发任意 LSP method、打印原始返回。
快速分界:**同一 .cpp 内跳转好、hpp→cpp 不好 = 服务端索引/编译数据库问题;全都不好 = 键位/attach 层。**

## 已知陷阱(会骗人的绿灯)

- **`clangd --check` 通过 ≠ 后台索引健康。** `--check` 走单文件解析+命令推断;后台索引要求编译数据库条目路径与真实打开路径**逐字符一致**(含软链解析前后的差异),不一致就**静默跳过所有 TU、不报错**。索引真正落地的证据:`lsp.log` 有 `Indexed <file>` 行;`<CDB目录>/.cache/clangd/index/` 有分片文件。两者都没有 = 跨翻译单元跳转(gd 从声明到 .cpp 定义)必然失败。排查软链别名:`find <工程> -type l` + `stat -c %i <两路径>`(同 inode = 同一文件的别名,拼写不一致就是问题)。注意 `clangd --check` 必须写 `clangd --check=<file>`(clangd 22 上位置参数报 Unknown command line argument)。
- **Mason 版 clangd 不自动重读 compile_commands.json**:重建/修复 CDB 后需 `:lsp restart clangd`。
- **nvim 0.12+ 无 `:Lsp*` 命令**(内置 `:lsp` 子命令取代):重启=`:lsp restart`,状态=`:checkhealth vim.lsp`,日志=`vim.lsp.log.get_filename()`。

## LSP 配置地图

| 位置 | 管什么 |
|---|---|
| `lua/user/lsp/mason.lua` | server 清单(`servers` 表)+ `vim.lsp.config/enable` |
| `lua/user/lsp/handlers.lua` | 诊断显示 + `LspAttach` buffer 键位 |
| `lua/user/lsp/settings/<server>.lua` | 按 server 覆盖;缺文件 = lspconfig 默认 |

## Intake 规则(沉淀前自检)

本 skill 只收:**会让用户被骗的 LSP 服务端行为事实**(附验证命令)。
不收:症状排障树(方法论归 systematic-debugging)、业务工程配方(归业务仓库)、`:help` 已有的语义(查 `:help lsp-defaults`)。
