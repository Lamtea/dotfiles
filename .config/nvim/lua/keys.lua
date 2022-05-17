local api = vim.api                                                                     -- neovim api

-- キーバインドの設定
for key, val in pairs({
    ['<C-H>'] = '<C-w><C-h>',                                                           -- Ctrl+Hで左のウィンドウに移動
    ['<C-J>'] = '<C-w><C-j>',                                                           -- Ctrl+Jで下のウィンドウに移動
    ['<C-K>'] = '<C-w><C-k>',                                                           -- Ctrl+Kで上のウィンドウに移動
    ['<C-L>'] = '<C-w><C-l>',                                                           -- Ctrl+Lで右のウィンドウに移動
    ['<leader>ff'] = [[<cmd>lua require('telescope.builtin').find_files()<cr>]],        -- \ffでファイル検索
    ['<leader>fg'] = [[<cmd>lua require('telescope.builtin').live_grep()<cr>]],         -- \fgでlive grep
    ['<leader>fb'] = [[<cmd>lua require('telescope.builtin').buffers()<cr>]],           -- \fbでバッファ検索
    ['<leader>fh'] = [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]],          -- \fhでヒストリ検索
    ['<leader>gb'] = [[<cmd>lua require('telescope.builtin').git_branches()<cr>]],      -- \gbでgit branchリスト
    ['<leader>gc'] = [[<cmd>lua require('telescope.builtin').git_commits()<cr>]],       -- \gcでgit commitリスト
    ['<leader>gf'] = [[<cmd>lua require('telescope.builtin').git_files()<cr>]],         -- \gfでgit fileリスト
    ['<leader>gs'] = [[<cmd>lua require('telescope.builtin').git_status()<cr>]],        -- \gsでgit statusリスト
}) do
    api.nvim_set_keymap('n', key, val, {noremap = true, silent = true})
end
