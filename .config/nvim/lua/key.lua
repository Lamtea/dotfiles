-- neovim api
local api = vim.api

-- 左のウィンドウに移動
api.nvim_set_keymap("n", "<C-h>", "<C-w><C-h>", { noremap = true, silent = true })
-- 下のウィンドウに移動
api.nvim_set_keymap("n", "<C-j>", "<C-w><C-j>", { noremap = true, silent = true })
-- 上のウィンドウに移動
api.nvim_set_keymap("n", "<C-k>", "<C-w><C-k>", { noremap = true, silent = true })
-- 右のウィンドウに移動
api.nvim_set_keymap("n", "<C-l>", "<C-w><C-l>", { noremap = true, silent = true })
-- タブを閉じる
api.nvim_set_keymap("n", "<M-q>", "<Cmd>tabclose<CR>", { noremap = true, silent = true })
-- ハイライトを消す
api.nvim_set_keymap("n", "<Leader>h", ":noh<CR>", { noremap = true, silent = true })
