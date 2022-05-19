local api = vim.api                                 -- neovim api

-- 変数設定
local vars = {
    python3_host_prog = '/usr/bin/python3',         -- neovimのpythonサポート
    Illuminate_delay = 500,                         -- vim-illuminateの単語をハイライトするまでの時間
    Illuminate_highlightUnderCursor = 0,            -- vim-illuminateのカーソル位置の単語はハイライトしない
    neo_tree_remove_legacy_commands = 1             -- neo-treeのレガシーコマンドは使用しない
}

for key, val in pairs(vars) do
    api.nvim_set_var(key, val)
end
