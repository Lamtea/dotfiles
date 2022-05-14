-- External scripts.
require('variables')
require('keys')
require('options')
require('commands')
require('plugins')

-- Compiling plugins script.
vim.cmd([[autocmd BufWritePost plugins.lua PackerCompile]])
