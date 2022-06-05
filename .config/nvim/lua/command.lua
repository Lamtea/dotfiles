-- fcitx5.
if vim.fn.executable("fcitx5") then
    vim.cmd("augroup fcitx5")
    vim.cmd("autocmd!")
    vim.cmd([[autocmd InsertLeave * :call system('fcitx5-remote -c')]])
    vim.cmd([[autocmd CmdlineLeave * :call system('fcitx5-remote -c')]])
    vim.cmd("augroup END")
end
