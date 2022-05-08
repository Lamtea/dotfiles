-- External scripts.
require('config')
require('plugins')

-- Compiling plugins script.
vim.cmd[[autocmd BufWritePost plugins.lua PackerCompile]]
