local api = vim.api                                 -- neovim api

-- 変数設定
local vars = {
    python3_host_prog = '/usr/bin/python3',         -- neovimのpythonサポート
    loaded_perl_provider = 0,                       -- neovimのperlサポート無効
    Illuminate_delay = 500,                         -- vim-illuminateの単語をハイライトするまでの時間
    Illuminate_highlightUnderCursor = 0,            -- vim-illuminateのカーソル位置の単語はハイライトしない
    qs_highlight_on_keys = {'f', 'F', 't', 'T'},    -- quick-scopeのキー設定
    camelcasemotion_key = '<leader>',               -- camelcasemotionのキー設定(<leader> + w, b, e, ge)
    neo_tree_remove_legacy_commands = 1             -- neo-treeのレガシーコマンドは使用しない
}

for key, val in pairs(vars) do
    api.nvim_set_var(key, val)
end
