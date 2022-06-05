require("variable")
require("option")
require("plugin")
require("key")
require("command")

vim.cmd([[autocmd BufWritePost plugin.lua PackerCompile]])
