local api = vim.api                 -- neovim api

-- 標準系
for key, val in pairs({
    ['<C-H>'] = '<C-w><C-h>',       -- 左のウィンドウに移動
    ['<C-J>'] = '<C-w><C-j>',       -- 下のウィンドウに移動
    ['<C-K>'] = '<C-w><C-k>',       -- 上のウィンドウに移動
    ['<C-L>'] = '<C-w><C-l>'        -- 右のウィンドウに移動
}) do
    api.nvim_set_keymap('n', key, val, {noremap = true, silent = true})
end

-- ファジーファインダー
api.nvim_set_keymap('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], {noremap = true})
api.nvim_set_keymap('n', '<leader>fg', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], {noremap = true})
api.nvim_set_keymap('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], {noremap = true})
api.nvim_set_keymap('n', '<leader>fh', [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]], {noremap = true})
api.nvim_set_keymap('n', '<leader>gb', [[<cmd>lua require('telescope.builtin').git_branches()<cr>]], {noremap = true})
api.nvim_set_keymap('n', '<leader>gc', [[<cmd>lua require('telescope.builtin').git_commits()<cr>]], {noremap = true})
api.nvim_set_keymap('n', '<leader>gf', [[<cmd>lua require('telescope.builtin').git_files()<cr>]], {noremap = true})
api.nvim_set_keymap('n', '<leader>gs', [[<cmd>lua require('telescope.builtin').git_status()<cr>]], {noremap = true})

-- treesitter
api.nvim_set_keymap('x', 'iu', [[:lua require('treesitter-unit').select()<CR>]], {noremap=true})
api.nvim_set_keymap('x', 'au', [[:lua require('treesitter-unit').select(true)<CR>]], {noremap=true})
api.nvim_set_keymap('o', 'iu', [[:<c-u>lua require('treesitter-unit').select()<CR>]], {noremap=true})
api.nvim_set_keymap('o', 'au', [[:<c-u>lua require('treesitter-unit').select(true)<CR>]], {noremap=true})
vim.cmd[[omap <silent> m :<C-U>lua require('tsht').nodes()<CR>]]
vim.cmd[[vnoremap <silent> m :lua require('tsht').nodes()<CR>]]
api.nvim_set_keymap('n', '<Leader>ss', '<cmd>ISwap<cr>', { noremap = true })
api.nvim_set_keymap('n', '<Leader>sw', '<cmd>ISwapWith<cr>', { noremap = true })
