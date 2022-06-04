-- カーソル位置のテストメソッドを実行
vim.cmd([[nnoremap <silent> <space>t :lua require('dap-python').test_method()<CR>]])
-- カーソル位置のテストクラスを実行
vim.cmd([[nnoremap <silent> <space>T :lua require('dap-python').test_class()<CR>]])
-- 選択範囲のデバッグを実行
vim.cmd([[vnoremap <silent> <space>s <ESC>:lua require('dap-python').debug_selection()<CR>]])
