-- Commands.
vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')
-- vim.cmd('colorscheme murphy')

-- Auto commands.
vim.cmd('augroup fcitx')
vim.cmd('autocmd!')
vim.cmd([[autocmd InsertLeave * :call system('fcitx5-remote -c')]])
vim.cmd([[autocmd CmdlineLeave * :call system('fcitx5-remote -c')]])
vim.cmd('augroup END')
