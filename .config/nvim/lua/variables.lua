local api = vim.api                                 -- neovim api

-- 変数設定
local vars = {
    python3_host_prog = '/usr/bin/python3',         -- neovimのpythonサポート
    neo_tree_remove_legacy_commands = 1             -- neo-treeのレガシーコマンドは使用しない
}

for key, val in pairs(vars) do
    api.nvim_set_var(key, val)
end
