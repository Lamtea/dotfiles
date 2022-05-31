-- vscode用フラグ
vim.g.vscode = true

-- 外部ファイル読込
require("variable")
require("option")
require("plugin")
require("key")
require("command")

-- プラグインファイルをコンパイル
vim.cmd([[autocmd BufWritePost plugin.lua PackerCompile]])
