-- Run test method on cursor.
vim.cmd([[nnoremap <silent> <space>t :lua require('dap-python').test_method()<CR>]])
-- Run test class on cursor.
vim.cmd([[nnoremap <silent> <space>T :lua require('dap-python').test_class()<CR>]])
-- Run selection.
vim.cmd([[vnoremap <silent> <space>s <ESC>:lua require('dap-python').debug_selection()<CR>]])
