-- カーソル位置のテストメソッドを実行
vim.cmd([[nmap <silent> <space>t :lua require('dap-go').debug_test()<CR>]])
