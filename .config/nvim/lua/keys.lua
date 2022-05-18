local api = vim.api                                                                     -- neovim api

-- キーバインドの設定
for key, val in pairs({
    ['<C-H>'] = '<C-w><C-h>',                                                           -- 左のウィンドウに移動
    ['<C-J>'] = '<C-w><C-j>',                                                           -- 下のウィンドウに移動
    ['<C-K>'] = '<C-w><C-k>',                                                           -- 上のウィンドウに移動
    ['<C-L>'] = '<C-w><C-l>',                                                           -- 右のウィンドウに移動
    ['<leader>ff'] = [[<cmd>lua require('telescope.builtin').find_files()<cr>]],        -- ファイル検索
    ['<leader>fg'] = [[<cmd>lua require('telescope.builtin').live_grep()<cr>]],         -- live grep
    ['<leader>fb'] = [[<cmd>lua require('telescope.builtin').buffers()<cr>]],           -- バッファ検索
    ['<leader>fh'] = [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]],          -- ヒストリ検索
    ['<leader>gb'] = [[<cmd>lua require('telescope.builtin').git_branches()<cr>]],      -- git branchリスト
    ['<leader>gc'] = [[<cmd>lua require('telescope.builtin').git_commits()<cr>]],       -- git commitリスト
    ['<leader>gf'] = [[<cmd>lua require('telescope.builtin').git_files()<cr>]],         -- git fileリスト
    ['<leader>gs'] = [[<cmd>lua require('telescope.builtin').git_status()<cr>]],        -- git statusリスト
}) do
    api.nvim_set_keymap('n', key, val, {noremap = true, silent = true})
end
