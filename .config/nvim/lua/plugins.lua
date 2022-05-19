local api = vim.api                                     -- neovim api

-- プラグイン読込
vim.cmd[[packadd packer.nvim]]
require'packer'.startup(function(use)
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
            vim.cmd('colorscheme nightfox')
        end
    }

    -- LSP
    use 'neovim/nvim-lspconfig'                         -- LSPクライアント
    use 'williamboman/nvim-lsp-installer'               -- LSPインストーラー
    local on_attach = function(_, bufnr)
        local function buf_set_keymap(...)
            api.nvim_buf_set_keymap(bufnr, ...)
        end

        local opts = { noremap = true, silent = true }
        buf_set_keymap('n', 'gD', 'lua vim.lsp.buf.declaration()', opts)
        buf_set_keymap('n', 'gd', 'lua vim.lsp.buf.definition()', opts)
        buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
        buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
        buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
        buf_set_keymap('n', '<space>q', 'lua vim.lsp.diagnostic.set_loclist()', opts)
        buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    end
    local lsp_installer = require('nvim-lsp-installer')
    local lspconfig = require('lspconfig')
    lsp_installer.setup()
    for _, server in ipairs(lsp_installer.get_installed_servers()) do
        lspconfig[server.name].setup {
            on_attach = on_attach
        }
    end
    lspconfig.sumneko_lua.setup{
        settings = {
            Lua = {
                diagnostics = {
                    globals = { 'vim' }
                }
            }
        }
    }

    -- ファジーファインダー
    use {
        'nvim-telescope/telescope.nvim',                -- ファインダー(ripgrep推奨 see:github)
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
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
        end
    }
    use {
        'nvim-telescope/telescope-fzf-native.nvim',     -- ソーター(cmake必須 see:github)
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    }

    -- treesitter
    use {
        'nvim-treesitter/nvim-treesitter',              -- パーサー(モジュールによってはnode.jsが必須. エラーがないか :checkhealth で要確認)
        run = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = 'all',
                sync_install = true,
                highlight = {
                    enable = true
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<CR>',
                        node_incremental = '<CR>',
                        scope_incremental = '<TAB>',
                        node_decremental = '<S-TAB>'
                    }
                },
                indent = {
                    enable = true                           -- インデント有効(実験的 see:github, 代替はnvim-yati see:github)
                },
                rainbow = {
                    enable = true,
                    extended_mode = true,
                    max_file_line = nil                     -- 大きなファイルで重くなる場合は最大行数を設定
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
                            ['a/'] = '@comment.outer',      -- コメントの/
                            ['ao'] = '@call.outer',         -- オブジェクトのo
                            ['io'] = '@call.inner'          -- 同上
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
                },
                textsubjects = {
                    enable = true,
                    prev_selection = ',',
                    keymaps = {
                        ['.'] = 'textsubjects-smart',
                        [';'] = 'textsubjects-container-outer',
                        ['i;'] = 'textsubjects-container-inner'
                    }
                }
            }
        end
    }
    use {
        'nvim-treesitter/nvim-treesitter-context',      -- メソッド等のスコープが長いとき先頭行に表示してくれる(context.vimの代替)
        config = function()
            require('treesitter-context').setup {
                enable = true
            }
        end
    }
    use 'p00f/nvim-ts-rainbow'                          -- 対応する括弧の色分け表示
    use 'JoosepAlviste/nvim-ts-context-commentstring'   -- コメンティングにtreesitterを使用(tsx/jsx等のスタイル混在時に便利, numToStr/Comment.nvimで使用)
    use {
        'haringsrob/nvim_context_vt',                   -- 閉括弧にvirtual textを表示
        config = function()
            require('nvim_context_vt').setup {
                enabled = true,
                disable_virtual_lines = true,           -- pythonなどのインデントベースの場合は非表示(virtual textで行がズレて見にくい)
            }
        end
    }
    use {
        'm-demare/hlargs.nvim',                         -- 引数を色分け表示
        requires = {
            'nvim-treesitter/nvim-treesitter'
        },
        config = function()
            require('hlargs').setup()
        end
    }
    use 'nvim-treesitter/nvim-treesitter-textobjects'   -- シンタックスベースの編集サポート(キーバインドは textobjects 参照, 言語別対応については see:github)
    use 'RRethy/nvim-treesitter-textsubjects'           -- シンタックスベースの範囲選択(キーバインドは textsubjects 参照)
    use 'mfussenegger/nvim-ts-hint-textobject'          -- シンタックスベースの範囲選択(EasyMotion系)
    use 'David-Kunz/treesitter-unit'                    -- シンタックスベースの範囲選択(ユニット単位, ざっくり系)
    use 'mizlan/iswap.nvim'                             -- シンタックスベースのスワップ(EasyMotion系)

    -- ステータスライン
    use {
        'nvim-lualine/lualine.nvim',                    -- lua製のステータスライン
        requires = {
            'kyazdani42/nvim-web-devicons',
            opt = true
        },
        config = function()
            local gps = require('nvim-gps')
            require('lualine').setup {
                options = {
                    theme = 'nightfox'
                },
                sections = {
                    lualine_c = {
                        'filename',
				        {gps.get_location, cond = gps.is_available}
			        }
                }
            }
        end
    }
    use {
	    'SmiteshP/nvim-gps',                            -- ステータスバーにカーソル位置のコンテキストを表示
	    requires = {
            'nvim-treesitter/nvim-treesitter'
        },
        config = function()
            require('nvim-gps').setup()
        end
    }

    -- バッファライン
    use {
        'akinsho/bufferline.nvim',                      -- バッファをタブ表示
        tag = 'v2.*',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require('bufferline').setup {
                options = {
                    numbers = 'both',
                    diagnostics = 'nvim_lsp',
		            show_buffer_close_icons = false,
		            show_close_icon = false
                }
            }
        end
    }

    -- ハイライト

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
end)
