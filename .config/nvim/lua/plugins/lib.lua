local m = {}

m.setup = function(use)
    -- 関数ライブラリ
    use("nvim-lua/plenary.nvim")
    -- popup api
    use("nvim-lua/popup.nvim")
    -- アイコンライブラリ(vim-deviconのluaフォーク)
    use("kyazdani42/nvim-web-devicons")
    -- UIコンポーネントライブラリ
    use("MunifTanjim/nui.nvim")
    -- sqliteライブラリ(sqlite必須 see:github)
    use("tami5/sqlite.lua")
    -- プラグインでの.リピート対応(vimscript)
    use("tpope/vim-repeat")
end

return m
