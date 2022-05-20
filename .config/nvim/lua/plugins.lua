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

    -- LSPと補完
    use 'neovim/nvim-lspconfig'                         -- LSPクライアント
    use 'williamboman/nvim-lsp-installer'               -- LSPインストーラー(:LspInstall :LspInstallinfo コマンドでlsをインストールする see:github)
    use 'hrsh7th/cmp-nvim-lsp'                          -- LSP補完用ソース
    use 'hrsh7th/cmp-buffer'                            -- バッファ補完用ソース
    use 'hrsh7th/cmp-path'                              -- パス補完用ソース
    use 'hrsh7th/cmp-cmdline'                           -- コマンドライン補完用ソース
    use 'hrsh7th/cmp-nvim-lsp-signature-help'           -- 関数シグネチャ補完用ソース
    use 'hrsh7th/cmp-nvim-lsp-document-symbol'          -- /検索用ソース
    use 'hrsh7th/cmp-nvim-lua'                          -- Lua API用ソース
    use 'hrsh7th/cmp-emoji'                             -- 絵文字用ソース
    use 'hrsh7th/nvim-cmp'                              -- 補完エンジン
    use 'hrsh7th/cmp-vsnip'                             -- vscodeスニペット用ソース
    use 'hrsh7th/vim-vsnip'                             -- vscodeスニペット
    use 'onsails/lspkind-nvim'                          -- 補完にアイコン表示
    use {
        'tami5/lspsaga.nvim',                           -- LSP高性能UI
        config = function()
            require('lspsaga').setup {
	            debug = false,
	            use_saga_diagnostic_sign = true,
	            error_sign = '',
	            warn_sign = '',
	            hint_sign = '',
	            infor_sign = '',
	            diagnostic_header_icon = '   ',
                code_action_icon = ' ',
	            code_action_prompt = {
                    enable = true,
                    sign = true,
                    sign_priority = 40,
                    virtual_text = true
                },
	            finder_definition_icon = '  ',
	            finder_reference_icon = '  ',
	            max_preview_lines = 10,
	            finder_action_keys = {
		            open = 'o',
		            vsplit = 's',
		            split = 'i',
		            quit = 'q',
		            scroll_down = '<C-f>',
		        scroll_up = '<C-b>'
	            },
	            code_action_keys = {
                    quit = 'q',
                    exec = '<CR>'
                },
	            rename_action_keys = {
                    quit = '<C-c>',
                    exec = '<CR>'
                },
	            definition_preview_icon = '  ',
	            border_style = 'single',
	            rename_prompt_prefix = '➤',
	            server_filetype_map = {},
	            diagnostic_prefix_format = '%d. '
            }
        end
    }
    use {
        'folke/lsp-colors.nvim',                        -- LSP用のカラー追加
        config = function()
            require('lsp-colors').setup {
                Error = '#db4b4b',
                Warning = '#e0af68',
                Information = '#0db9d7',
                Hint = '#10B981'
            }
        end
    }
    use {
        'folke/trouble.nvim',                           -- LSP診断UI
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require('trouble').setup {
                height = 10,
                auto_close = true,                      -- 診断がない場合は自動で閉じる
                use_diagnostic_signs = true             -- LSPクライアントと同じ記号を使用
            }
        end
    }
    use {
        'j-hui/fidget.nvim',                            -- LSPプログレス
        config = function()
            require('fidget').setup()
        end
    }
    use 'RRethy/vim-illuminate'                         -- LSP単語ハイライト

    local lsp_on_attach = function(client, bufnr)
        require('illuminate').on_attach(client)

        local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
        end

        local opts = { noremap = true, silent = true }
        buf_set_keymap('n', 'gD', 'lua vim.lsp.buf.declaration()', opts)
        buf_set_keymap('n', 'gd', 'lua vim.lsp.buf.definition()', opts)
        -- buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)                               lspsaga使用
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)                  lspsaga使用
        buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)                      lspsaga使用
        -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)                 lspsaga使用
        buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts) lspsaga使用
        -- buf_set_keymap('n', '<space>p', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)             lspsaga使用
        -- buf_set_keymap('n', '<space>n', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)             lspsaga使用
        buf_set_keymap('n', '<space>q', 'lua vim.lsp.diagnostic.set_loclist()', opts)
        buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    end

    local lsp_installer = require('nvim-lsp-installer')
    local lsp_config = require('lspconfig')
    local lsp_capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    lsp_installer.setup()
    for _, server in ipairs(lsp_installer.get_installed_servers()) do
        lsp_config[server.name].setup {
            on_attach = lsp_on_attach,                  -- キーバインドのアタッチ
            capabilities = lsp_capabilities             -- 補完設定
        }
    end

    lsp_config.sumneko_lua.setup{
        settings = {
            Lua = {
                diagnostics = {
                    globals = {'vim'}                  -- neovim設定ファイル用(vimがグローバルオブジェクトのため)
                }
            }
        }
    }

    vim.g.completeopt = 'menu,menuone,noselect'        -- 補完設定

    local lsp_kind = require('lspkind')
    lsp_kind.init {
        mode = 'symbol_text',
        preset = 'codicons',
        symbol_map = {
          Text = '',
          Method = '',
          Function = '',
          Constructor = '',
          Field = 'ﰠ',
          Variable = '',
          Class = 'ﴯ',
          Interface = '',
          Module = '',
          Property = 'ﰠ',
          Unit = '塞',
          Value = '',
          Enum = '',
          Keyword = '',
          Snippet = '',
          Color = '',
          File = '',
          Reference = '',
          Folder = '',
          EnumMember = '',
          Constant = '',
          Struct = 'פּ',
          Event = '',
          Operator = '',
          TypeParameter = ''
        }
    }

    local cmp_engine = require('cmp')
    cmp_engine.setup {
        formatting = {
            format = lsp_kind.cmp_format {
                mode = 'symbol',
                maxwidth = 50,
                before = function (_, vim_item)
                    return vim_item
                end
            }
        },
        snippet = {
            expand = function(args)
                vim.fn['vsnip#anonymous'](args.body)   -- vscodeスニペット設定
            end
        },
        mapping = {
            ['<C-b>'] = cmp_engine.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp_engine.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp_engine.mapping.complete(),
            ['<C-e>'] = cmp_engine.mapping.close(),
            ['<CR>'] = cmp_engine.mapping.confirm {select = true}
        },
        sources = cmp_engine.config.sources(
            {
                {name = 'nvim_lsp'},
                {name = 'vsnip'},
                {name = 'path'},
                {name = 'emoji', insert = true},
                {name = 'nvim-lua'},
                {name = 'nvim_lsp_signature_help'}
            },
            {
                {name = 'buffer'}
            }
        )
    }

    cmp_engine.setup.cmdline('/', {
        mapping = cmp_engine.mapping.preset.cmdline(),
        sources = cmp_engine.config.sources(
            {
		        {name = 'nvim_lsp_document_symbol'}
	        },
            {
		        {name = 'buffer'}
	        }
        )
    })

    cmp_engine.setup.cmdline(':', {
        mapping = cmp_engine.mapping.preset.cmdline(),
        sources = cmp_engine.config.sources(
            {
                {name = 'path'}
            },
            {
                {name = 'cmdline'}
            }
        )
    })

    vim.keymap.set('n', 'gh', '<cmd>Lspsaga lsp_finder<cr>', { silent = true, noremap = true })
    vim.keymap.set('n', '<space>ca', '<cmd>Lspsaga code_action<cr>', { silent = true, noremap = true })
    vim.keymap.set('x', '<space>ca', ':<C-u>Lspsaga range_code_action<cr>', { silent = true, noremap = true })
    vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<cr>', { silent = true, noremap = true })
    vim.keymap.set('n', '<C-f>', [[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>]], { silent = true, noremap = true })
    vim.keymap.set('n', '<C-b>', [[<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<cr>]], { silent = true, noremap = true })
    vim.keymap.set('n', '<space>k', '<cmd>Lspsaga signature_help<cr>', { silent = true, noremap = true })
    vim.keymap.set('n', '<space>rn', '<cmd>Lspsaga rename<cr>', { silent = true, noremap = true })
    vim.keymap.set('n', '<space>d', '<cmd>Lspsaga preview_definition<cr>', { silent = true, noremap = true })
    vim.keymap.set('n', '<space>e', '<cmd>Lspsaga show_line_diagnostics<cr>', { silent = true, noremap = true })
    vim.keymap.set('n', '<space>E', [[<cmd>lua require('lspsaga.diagnostic').show_cursor_diagnostics()<cr>]], { silent = true, noremap = true })
    vim.keymap.set('n', '<space>n', '<cmd>Lspsaga diagnostic_jump_next<cr>', { silent = true, noremap = true })
    vim.keymap.set('n', '<space>p', '<cmd>Lspsaga diagnostic_jump_prev<cr>', { silent = true, noremap = true })
    vim.keymap.set('n', '<A-d>', '<cmd>Lspsaga open_floaterm<cr>', { silent = true, noremap = true })
    vim.cmd[[tnoremap <silent> <A-d> <C-\><C-n>:Lspsaga close_floaterm<CR>]]
    vim.api.nvim_set_keymap('n', '<leader>xx', '<cmd>Trouble<cr>', { silent = true, noremap = true })
    vim.api.nvim_set_keymap('n', '<leader>xw', '<cmd>Trouble workspace_diagnostics<cr>', { silent = true, noremap = true })
    vim.api.nvim_set_keymap('n', '<leader>xd', '<cmd>Trouble document_diagnostics<cr>', { silent = true, noremap = true })
    vim.api.nvim_set_keymap('n', '<leader>xl', '<cmd>Trouble loclist<cr>', { silent = true, noremap = true })
    vim.api.nvim_set_keymap('n', '<leader>xq', '<cmd>Trouble quickfix<cr>', { silent = true, noremap = true })
    vim.api.nvim_set_keymap('n', 'gR', '<cmd>Trouble lsp_references<cr>', { silent = true, noremap = true })

    -- ファジーファインダー
    use {
        'nvim-telescope/telescope.nvim',                -- ファインダー(ripgrep推奨 see:github)
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = function()
            local trouble = require('trouble.providers.telescope')
            require('telescope').setup {
                defaults = {
                    mappings = {
                        i = {['<c-t>'] = trouble.open_with_trouble},
                        n = {['<c-t>'] = trouble.open_with_trouble},
                    },
                },
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

    vim.api.nvim_set_keymap('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], {noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>fg', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], {noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], {noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>fh', [[<cmd>lua require('telescope.builtin').oldfiles()<cr>]], {noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>fc', [[<cmd>lua require('telescope.builtin').commands()<cr>]], {noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>ft', [[<cmd>lua require('telescope.builtin').treesitter()<cr>]], {noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>gb', [[<cmd>lua require('telescope.builtin').git_branches()<cr>]], {noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>gc', [[<cmd>lua require('telescope.builtin').git_commits()<cr>]], {noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>gm', [[<cmd>lua require('telescope.builtin').git_bcommits()<cr>]], {noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>gf', [[<cmd>lua require('telescope.builtin').git_files()<cr>]], {noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>gs', [[<cmd>lua require('telescope.builtin').git_status()<cr>]], {noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>gt', [[<cmd>lua require('telescope.builtin').git_stash()<cr>]], {noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>ld', [[<cmd>lua require('telescope.builtin').lsp_definitions()<cr>]], {noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>lr', [[<cmd>lua require('telescope.builtin').lsp_references()<cr>]], {noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>ls', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>]], {noremap = true})
    vim.api.nvim_set_keymap('n', '<leader>lw', [[<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>]], {noremap = true})

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
                            ['am'] = '@comment.outer',
                            ['ao'] = '@call.outer',
                            ['io'] = '@call.inner'
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

    vim.api.nvim_set_keymap('x', 'iu', [[:lua require('treesitter-unit').select()<CR>]], {noremap=true})
    vim.api.nvim_set_keymap('x', 'au', [[:lua require('treesitter-unit').select(true)<CR>]], {noremap=true})
    vim.api.nvim_set_keymap('o', 'iu', [[:<c-u>lua require('treesitter-unit').select()<CR>]], {noremap=true})
    vim.api.nvim_set_keymap('o', 'au', [[:<c-u>lua require('treesitter-unit').select(true)<CR>]], {noremap=true})
    vim.cmd[[omap <silent> m :<C-u>lua require('tsht').nodes()<CR>]]
    vim.cmd[[vnoremap <silent> m :lua require('tsht').nodes()<CR>]]
    vim.api.nvim_set_keymap('n', '<Leader>ss', '<cmd>ISwap<cr>', {noremap = true})
    vim.api.nvim_set_keymap('n', '<Leader>sw', '<cmd>ISwapWith<cr>', {noremap = true})

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
                    lualine_a = {
                        'mode'
                    },
                    lualine_b = {
                        'branch', 'diff', 'diagnostics'
                    },
                    lualine_c = {
                        'filename',
				        {gps.get_location, cond = gps.is_available}
			        },
                    lualine_x = {
                        'encoding', 'fileformat', 'filetype'
                    },
                    lualine_y = {
                        'progress'
                    },
                    lualine_z = {
                        'location'
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

    vim.api.nvim_set_keymap('n', 'L', '<Cmd>BufferLineCycleNext<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', 'H', '<Cmd>BufferLineCyclePrev<CR>', { noremap = true, silent = true })
    -- vim.api.nvim_set_keymap('n', 'J', '<Cmd>BufferLineMoveNext<CR>', { noremap = true, silent = true })
    -- vim.api.nvim_set_keymap('n', 'K', '<Cmd>BufferLineMovePrev<CR>', { noremap = true, silent = true })
    -- vim.api.nvim_set_keymap('n', '', '<Cmd>BufferLineSortByExtension<CR>', { noremap = true, silent = true })
    -- vim.api.nvim_set_keymap('n', '', '<Cmd>BufferLineSortByDirectory<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>b', '<Cmd>BufferLinePick<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>1', '<Cmd>BufferLineGoToBuffer 1<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>2', '<Cmd>BufferLineGoToBuffer 2<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>3', '<Cmd>BufferLineGoToBuffer 3<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>4', '<Cmd>BufferLineGoToBuffer 4<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>5', '<Cmd>BufferLineGoToBuffer 5<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>6', '<Cmd>BufferLineGoToBuffer 6<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>7', '<Cmd>BufferLineGoToBuffer 7<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>8', '<Cmd>BufferLineGoToBuffer 8<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>9', '<Cmd>BufferLineGoToBuffer 9<CR>', { noremap = true, silent = true })

    -- ハイライト
    use {
        'norcalli/nvim-colorizer.lua',                  -- 色コードや名称をカラー表示
        config = function()
            require('colorizer').setup()
        end
    }
    use {
        'folke/todo-comments.nvim',                     -- todo系コメントハイライトとtrouble, telecopeに表示(タグについては see:github)
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('todo-comments').setup()
        end
    }

    vim.api.nvim_set_keymap('n', '<Leader>tx', '<cmd>TodoTrouble<cr>', {noremap = true})
    vim.api.nvim_set_keymap('n', '<Leader>tt', '<cmd>TodoTelescope<cr>', {noremap = true})

    -- 行番号
    use 'myusuf3/numbers.vim'                           -- insertモード時は絶対行にする(vimscript)

    -- サイドバー
    use {
        'sidebar-nvim/sidebar.nvim',                    -- 色々な情報を出すサイドバー(ファイラと違って隠しファイルも表示する設定にしてある)
        config = function()
            require('sidebar-nvim').setup {
	            disable_default_keybindings = 0,
	            bindings = {
		            ['q'] = function()
			            require('sidebar-nvim').close() -- qで閉じる
		            end
	            },
	            open = false,
	            side = 'right',
	            initial_width = 40,
                hide_statusline = false,
	            update_interval = 1000,
                sections = {
                    'datetime',
                    'containers',
                    'git',
                    'diagnostics',
                    'todos',
                    'symbols',
                    'buffers',
                    'files'
                },
	            section_separator = '------------------------------',
                datetime = {
                    icon = '',
                    format = '%b %d日 (%a) %H:%M',
                    clocks = {{name = 'local'}}
                },
                ['git'] = {
                    icon = ''
                },
                ['diagnostics'] = {
                    icon = ''
                },
                todos = {
                    icon = '',
                    ignored_paths = {'~'},
                    initially_closed = false
                },
                containers = {
                    icon = '',
                    use_podman = false,
                    attach_shell = '/bin/bash',
                    show_all = true,
                    interval = 5000
                },
                buffers = {
                    icon = '',
                    ignored_buffers = {},
                    sorting = 'id',
                    show_numbers = true
                },
                files = {
                    icon = '',
                    show_hidden = true,
                    ignored_paths = {'%.git$'}
                },
                symbols = {
                    icon = 'ƒ'
                }
            }
        end
    }

    vim.api.nvim_set_keymap('n', 'gs', '<Cmd>SidebarNvimToggle<CR>', {noremap = true, silent = true})

    -- スタート画面
    use {
        'goolord/alpha-nvim',                           -- スタート画面に履歴等表示
        requires = {
            'kyazdani42/nvim-web-devicons'
        },
        config = function ()
            require('alpha').setup(require'alpha.themes.startify'.config)
        end
    }

    -- スクロールバー
    use {
        'petertriho/nvim-scrollbar',                    -- スクロールバーを表示(nvim-hlslensと連携してスクロールバーにハイライト表示)
        config = function()
            require('scrollbar.handlers.search').setup()
            require('scrollbar').setup {
                handlers = {
                    diagnostic = true,
                    search = true
                },
            }
        end
    }

    -- 移動
    use {
        'phaazon/hop.nvim',                             -- ラベルジャンプ(EasyMotion風)
        config = function()
            require('hop').setup()
        end
    }
    use 'unblevable/quick-scope'                        -- 1行内ラベルジャンプ(キーバインドはvariables.luaで定義, vimscript)
    use 'bkad/CamelCaseMotion'                          -- キャメルケースの移動(キーバインドはvariables.luaで定義, vimscript)

    vim.api.nvim_set_keymap('n', '<leader>e', [[<cmd>lua require('hop').hint_words()<CR>]], {})
    vim.api.nvim_set_keymap('x', '<leader>e', [[<cmd>lua require('hop').hint_words()<CR>]], {})

    -- 編集
    use 'machakann/vim-sandwich'                        -- クォートなどでサンドイッチされたテキストの編集(キーバインドについては see:github, vimscript)

    -- ヤンク
    use {
        'AckslD/nvim-neoclip.lua',                      -- ヤンクをセッション間で共有できtelescopeで検索可能
        requires = {
            {'tami5/sqlite.lua', module = 'sqlite'},
            {'nvim-telescope/telescope.nvim'}
        },
        config = function()
            require('neoclip').setup {
                enable_persistent_history = true
            }
            require('telescope').load_extension('neoclip')
        end
    }
    use 'tversteeg/registers.nvim'                      -- レジスタの内容を一覧表示してヤンク(normal mode: ", insert mode: C-r)

    vim.api.nvim_set_keymap('n', '<leader>fy', '<Cmd>Telescope neoclip<CR>', {noremap = true, silent = true})

    -- 検索
    use 'kevinhwang91/nvim-hlslens'                     -- 検索時にカーソルの隣にマッチ情報表示(nvim-scrollbarと連携してスクロールバーにハイライト表示)

    local hlslens_opts = {noremap = true, silent = true}
    vim.api.nvim_set_keymap('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], hlslens_opts)
    vim.api.nvim_set_keymap('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], hlslens_opts)
    vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], hlslens_opts)
    vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], hlslens_opts)
    vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], hlslens_opts)
    vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], hlslens_opts)
    vim.api.nvim_set_keymap('n', '<Leader>h', ':noh<CR>', hlslens_opts)

    -- ファイラ
    use {
        'nvim-neo-tree/neo-tree.nvim',                  -- 軽くて安定したlua製ファイラ(隠しファイルを表示する場合はサイドバーを使用)
        branch = 'v2.x',
        requires = {
            'nvim-lua/plenary.nvim',
            'kyazdani42/nvim-web-devicons',
            'MunifTanjim/nui.nvim'
        },
        config = function()
            require('neo-tree').setup()
        end
    }

    vim.keymap.set('n', 'gx', '<Cmd>Neotree reveal toggle <CR>', { noremap = true, silent = true })

    -- ターミナル
    use {
        'akinsho/toggleterm.nvim',                      -- ターミナルをウィンドウ表示(ターミナルの停止は<C-\><C-n>, これでウィンドウ操作できる)
        tag = 'v1.*',
        config = function()
            require('toggleterm').setup()
        end
    }
    vim.keymap.set('n', '<A-t>', '<cmd>ToggleTerm<cr>', { silent = true, noremap = true })

    -- インデント
    use {
        'lukas-reineke/indent-blankline.nvim',          -- インデントを見やすく表示
        config = function()
            require('indent_blankline').setup {
                space_char_blankline = " ",
                show_current_context = true,
                show_current_context_start = false      -- アンダースコア表示はしない
            }
        end
    }

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
    use {
        'tpope/vim-unimpaired',
        opt = true,
        event = {
            'FocusLost',
            'CursorHold'
        }
    }

    -- コマンド
    use 'mileszs/ack.vim'                               -- :Ack
    use {
        'folke/which-key.nvim',                         -- :WhichKey
        config = function()
            require('which-key').setup()
        end
    }
end)
