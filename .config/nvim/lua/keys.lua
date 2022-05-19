local api = vim.api                 -- neovim api

-- 標準系
for key, val in pairs({
    ['<C-h>'] = '<C-w><C-h>',       -- 左のウィンドウに移動
    ['<C-j>'] = '<C-w><C-j>',       -- 下のウィンドウに移動
    ['<C-k>'] = '<C-w><C-k>',       -- 上のウィンドウに移動
    ['<C-l>'] = '<C-w><C-l>'        -- 右のウィンドウに移動
}) do
    api.nvim_set_keymap('n', key, val, {noremap = true, silent = true})
end
