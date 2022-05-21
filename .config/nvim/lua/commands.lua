-- ノーマルモードに戻ったときにfcitx5のIMEをoffにする
vim.cmd("augroup fcitx")
vim.cmd("autocmd!")
vim.cmd([[autocmd InsertLeave * :call system('fcitx5-remote -c')]])
vim.cmd([[autocmd CmdlineLeave * :call system('fcitx5-remote -c')]])
vim.cmd("augroup END")
