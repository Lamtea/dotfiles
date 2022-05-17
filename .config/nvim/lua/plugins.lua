local api = vim.api                                     -- neovim api

-- 変数設定
local vars = {
    neo_tree_remove_legacy_commands = 1,                -- neo-treeのレガシーコマンドは使用しない
}

for key, val in pairs(vars) do
    api.nvim_set_var(key, val)
end

-- プラグイン読込
vim.cmd[[packadd packer.nvim]]
require'packer'.startup(function()
    -- プラグインマネージャ
    use {
        'wbthomason/packer.nvim',                       -- lua製プラグインマネージャ
        opt = true
    }

    -- ライブラリ
    use 'nvim-lua/plenary.nvim'                         -- 関数ライブラリ
    use 'nvim-lua/popup.nvim'                           -- popup api
    use 'kyazdani42/nvim-web-devicons'                  -- アイコンライブラリ(vim-deviconのluaフォーク)
    use 'MunifTanjim/nui.nvim'                          -- UIコンポーネントライブラリ
    use 'tami5/sqlite.lua'                              -- sqliteライブラリ(sqlite必須 see:github)
    use 'tpope/vim-repeat'                              -- プラグインでの.リピート対応(vimscript)

    -- 通知
    use {
        'rcarriga/nvim-notify',                         -- ポップアップ通知
        config = function()
            require('notify').setup {
                stages = 'fade_in_slide_out',
                background_colour = 'FloatShadow',
                timeout = 3000,
            }
            vim.notify = require('notify')
        end
    }

    -- カラースキーム
    use 'EdenEast/nightfox.nvim'                        -- lsp, treesitter等に対応したテーマ
    require('nightfox').setup {
        options = {
            transparent = true
        }
    }
    vim.cmd('colorscheme nordfox')                      -- カラーをnordに設定

    -- Basics.
    use 'tpope/vim-fugitive'
    use 'tpope/vim-surround'
    use {
        'tpope/vim-unimpaired',
        opt = true,
        event = {
            'FocusLost',
            'CursorHold'
        }
    }
    use 'easymotion/vim-easymotion'
    use 'mileszs/ack.vim'

    -- Filer.
    use {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v2.x',
        requires = { 
            'nvim-lua/plenary.nvim',
            'kyazdani42/nvim-web-devicons',
            'MunifTanjim/nui.nvim'
        }
    }

    -- ファジーファインダー
    use {
        'nvim-telescope/telescope.nvim',                -- ファインダー(ripgrep推奨 see:github)
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }
    use {
        'nvim-telescope/telescope-fzf-native.nvim',     -- ソーター(cmake, make, gcc必須 see:github)
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    }
    require('telescope').setup {
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case"
            }
        }
    }
    require('telescope').load_extension('fzf')

    -- treesitter
    use {
        'nvim-treesitter/nvim-treesitter',              -- パーサー(モジュールによってはnode.js, gccが必須. エラーがないか :checkhealth で要確認)
        run = ':TSUpdate'
    }
    require('nvim-treesitter.configs').setup {
        ensure_installed = 'all',                       -- モジュールはすべてインストール
        sync_install = true,                            -- 同期する
        highlight = {
            enabled = true                              -- シンタックスハイライト有効
        },
        indent = {
            enabled = true                              -- treesitterのインデント有効(実験的 see:github)
        }
    }
end)
