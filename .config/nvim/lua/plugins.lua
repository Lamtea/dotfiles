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
    use {
        'EdenEast/nightfox.nvim',                       -- lsp, treesitter等に対応したテーマ
        config = function()
            require('nightfox').setup {
                options = {
                    transparent = true
                }
            }
            vim.cmd('colorscheme nightfox')             -- カラーを設定
        end
    }

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
                case_mode = 'smart_case'
            }
        }
    }
    require('telescope').load_extension('fzf')

    -- treesitter
    use {
        'nvim-treesitter/nvim-treesitter',              -- パーサー(モジュールによってはnode.js, gccが必須. エラーがないか :checkhealth で要確認)
        run = ':TSUpdate'
    }
    use 'nvim-treesitter/nvim-treesitter-context'       -- メソッド等のスコープが長いとき先頭行に表示してくれる(context.vimの代替)
    use 'p00f/nvim-ts-rainbow'                          -- 対応する括弧の色分け表示
    use 'JoosepAlviste/nvim-ts-context-commentstring'   -- コメンティングにtreesitterを使用(tsx/jsx等のスタイル混在時に便利, numToStr/Comment.nvimで使用)
    use 'haringsrob/nvim_context_vt'                    -- 閉括弧にvirtual textを表示
    use {
        'm-demare/hlargs.nvim',                         -- 引数を色分け表示
        requires = {
            'nvim-treesitter/nvim-treesitter'
        }
    }
    use 'nvim-treesitter/nvim-treesitter-textobjects'   -- シンタックスベースの編集サポート(キーバインドは textobjects 参照)
    require('nvim-treesitter.configs').setup {
        ensure_installed = 'all',                       -- モジュールはすべてインストール
        sync_install = true,                            -- モジュール自動更新
        highlight = {
            enable = true
        },
        indent = {
            enable = true                               -- インデント有効(実験的 see:github, 代替はnvim-yati see:github)
        },
        rainbow = {
            enable = true,
            extended_mode = true,                       -- 括弧以外の区切り文字を色分け表示
            max_file_line = nil                         -- 大きなファイルで重くなる場合は最大行数を設定
        },
        context_commentstring = {
            enable = true
        },
        textobjects = {
            select = {
                enable = true,
                keymaps = {
                    ['af'] = '@function.outer',
                    ['if'] = '@function.inner',
                    ['ac'] = '@class.outer',
                    ['ic'] = '@class.inner',
				    ['ab'] = '@block.outer',
                    ['ib'] = '@block.inner',
				    ['aC'] = '@conditional.outer',
                    ['iC'] = '@conditional.inner',
				    ['al'] = '@loop.outer',
				    ['il'] = '@loop.inner',
				    ['ap'] = '@parameter.outer',
				    ['ip'] = '@parameter.inner',
				    ['aF'] = '@frame.outer',
                    ['iF'] = '@frame.inner',
                    ['aS'] = '@statement.outer',
                    ['iS'] = '@scopename.inner',
                    ['a/'] = '@comment.outer',          -- コメントの/
                    ['ao'] = '@call.outer',             -- オブジェクトのo
                    ['io'] = '@call.inner',             -- 同上
                }
            },
            swap = {
                enable = true,
                swap_next = {
                    ['<leader>a'] = '@parameter.inner'
                },
                swap_previous = {
                    ['<leader>A'] = '@parameter.inner'
                }
            },
            move = {
                enable = true,
                goto_next_start = {
                    [']m'] = '@function.outer',
                    [']]'] = '@class.outer'
                },
                goto_next_end = {
                    [']M'] = '@function.outer',
                    [']['] = '@class.outer'
                },
                goto_previous_start = {
                    ['[m'] = '@function.outer',
                    ['[['] = '@class.outer'
                },
                goto_previous_end = {
                    ['[M'] = '@function.outer',
                    ['[]'] = '@class.outer'
                }
            },
            lsp_interop = {
                enable = true,
                peek_definition_code = {
                    ['<leader>df'] = '@function.outer',
                    ['<leader>dF'] = '@class.outer'
                }
            }
        }
    }
    require('treesitter-context').setup {
        enable = true
    }
    require('nvim_context_vt').setup {
        enabled = true,
        disable_virtual_lines = true,                   -- pythonなどのインデントベースの場合は非表示(virtual textで行がズレて見にくい)
    }
    require('hlargs').setup()

    -- コメント
    use {
        'numToStr/Comment.nvim',                        -- コメンティング(nvim-ts-context-commentstringを使用, キーバインドは標準 see:github)
        config = function()
            require('Comment').setup {
                pre_hook = function()
		            return require('ts_context_commentstring.internal').calculate_commentstring()
	            end,
                post_hook = nil
            }
        end
    }
end)
