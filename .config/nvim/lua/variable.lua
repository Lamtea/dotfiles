-- グローバル変数
local g = vim.g

-- neovimのpythonサポート
g.python3_host_prog = require("os").getenv("HOME") .. "/.pyenv/shims/python"

-- neovimのperlサポート無効
g.loaded_perl_provider = 0
