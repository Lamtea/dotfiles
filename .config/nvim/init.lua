-- 外部ファイル読込
require("variables")
require("options")
require("plugins")
require("keys")
require("commands")

-- プラグインファイルをコンパイル
vim.cmd([[autocmd BufWritePost plugins.lua PackerCompile]])
