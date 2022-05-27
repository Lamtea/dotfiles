local m = {}

m.setup = function(use)
    -- パーサー(モジュールによってはnode.jsが必須. エラーがないか :checkhealth で要確認)
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    })
    -- メソッド等のスコープが長いとき先頭行に表示してくれる(context.vimの代替)
    use("nvim-treesitter/nvim-treesitter-context")
    -- 対応する括弧の色分け表示
    use("p00f/nvim-ts-rainbow")
    -- コメンティングにtreesitterを使用(tsx/jsx等のスタイル混在時に便利, numToStr/Comment.nvimで使用)
    use("JoosepAlviste/nvim-ts-context-commentstring")
    -- 閉括弧にvirtual textを表示
    use("haringsrob/nvim_context_vt")
    -- マッチングペアをハイライト, 移動, 編集(キーバインドについては see:github, vimscript)
    use("andymass/vim-matchup")
    -- タグを自動で閉じてくれる
    use("windwp/nvim-ts-autotag")
    -- 引数を色分け表示
    use({
        "m-demare/hlargs.nvim",
        requires = {
            "nvim-treesitter/nvim-treesitter",
        },
    })
    -- シンタックスベースの編集サポート(キーバインドは textobjects 参照, 言語別対応については see:github)
    use("nvim-treesitter/nvim-treesitter-textobjects")
    -- シンタックスベースの範囲選択(キーバインドは textsubjects 参照)
    use("RRethy/nvim-treesitter-textsubjects")
    -- シンタックスベースの範囲選択(EasyMotion系)
    use("mfussenegger/nvim-ts-hint-textobject")
    -- シンタックスベースの範囲選択(ユニット単位, ざっくり系)
    use("David-Kunz/treesitter-unit")
    -- シンタックスベースのスワップ(EasyMotion系)
    use("mizlan/iswap.nvim")

    m.setup_treesitter()
    m.setup_context()
    m.setup_context_vt()
    m.setup_autotag()
    m.setup_hlargs()
end

m.setup_treesitter = function()
    require("nvim-treesitter.configs").setup({
        ensure_installed = "all",
        sync_install = true,
        highlight = {
            enable = true,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                -- normal modeからnodeを初期選択してvisual modeに入れる
                init_selection = "<CR>",
                -- 親nodeをたどって選択
                node_incremental = "<CR>",
                -- scope範囲で親nodeをたどって選択
                scope_incremental = "<TAB>",
                -- 子nodeまで選択を戻す
                node_decremental = "<S-TAB>",
            },
        },
        indent = {
            -- インデント有効(実験的 see:github, 代替はnvim-yati see:github)
            enable = true,
        },
        textobjects = {
            select = {
                enable = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                    ["ab"] = "@block.outer",
                    ["ib"] = "@block.inner",
                    ["aC"] = "@conditional.outer",
                    ["iC"] = "@conditional.inner",
                    ["al"] = "@loop.outer",
                    ["il"] = "@loop.inner",
                    ["ap"] = "@parameter.outer",
                    ["ip"] = "@parameter.inner",
                    ["aF"] = "@frame.outer",
                    ["iF"] = "@frame.inner",
                    ["aS"] = "@statement.outer",
                    ["iS"] = "@scopename.inner",
                    ["am"] = "@comment.outer", -- comment
                    ["ao"] = "@call.outer", -- object
                    ["io"] = "@call.inner", -- object
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    ["<leader>sn"] = "@parameter.inner",
                },
                swap_previous = {
                    ["<leader>sp"] = "@parameter.inner",
                },
            },
            move = {
                enable = true,
                goto_next_start = {
                    ["]f"] = "@function.outer",
                    ["]c"] = "@class.outer",
                    ["]b"] = "@block.outer",
                },
                goto_next_end = {
                    ["]F"] = "@function.outer",
                    ["]C"] = "@class.outer",
                    ["]B"] = "@block.outer",
                },
                goto_previous_start = {
                    ["[f"] = "@function.outer",
                    ["[c"] = "@class.outer",
                    ["[b"] = "@block.outer",
                },
                goto_previous_end = {
                    ["[F"] = "@function.outer",
                    ["[C"] = "@class.outer",
                    ["[B"] = "@block.outer",
                },
            },
            lsp_interop = {
                enable = true,
                peek_definition_code = {
                    ["<leader>lf"] = "@function.outer",
                    ["<leader>lc"] = "@class.outer",
                },
            },
        },
        textsubjects = {
            -- incremental_selectionと違いトリビアごと選択できる
            enable = true,
            prev_selection = ",",
            keymaps = {
                ["."] = "textsubjects-smart",
                [";"] = "textsubjects-container-outer",
                ["i;"] = "textsubjects-container-inner",
            },
        },
        rainbow = {
            enable = true,
            extended_mode = true,
            -- 大きなファイルで重くなる場合は最大行数を設定
            max_file_line = nil,
        },
        context_commentstring = {
            enable = true,
        },
        matchup = {
            enable = true,
        },
        autotag = {
            enable = true,
        },
    })
end

m.setup_context = function()
    require("treesitter-context").setup({
        enable = true,
    })
end

m.setup_context_vt = function()
    require("nvim_context_vt").setup({
        enabled = true,
        -- pythonなどのインデントベースの場合は非表示(virtual textで行がズレて見にくい)
        disable_virtual_lines = true,
    })
end

m.setup_autotag = function()
    require("nvim-ts-autotag").setup()
end

m.setup_hlargs = function()
    require("hlargs").setup()
end

-- ユニット単位の選択
-- カーソル位置がステートメント, ブロックなどによって選択範囲が変わる
-- auを使用するとカーソル位置より下のユニットを選択するので, 真下のメソッド等を選択するのに良い
vim.api.nvim_set_keymap("x", "iu", [[:lua require('treesitter-unit').select()<CR>]], { noremap = true })
vim.api.nvim_set_keymap("x", "au", [[:lua require('treesitter-unit').select(true)<CR>]], { noremap = true })
vim.api.nvim_set_keymap("o", "iu", [[:<c-u>lua require('treesitter-unit').select()<CR>]], { noremap = true })
vim.api.nvim_set_keymap("o", "au", [[:<c-u>lua require('treesitter-unit').select(true)<CR>]], { noremap = true })
-- 現在行の範囲選択をEasyMotion風に行う
-- 現在位置より後ろを選ぶと先頭から選んだ位置までを選択
-- 現在位置より前を選ぶと選んだ位置から末尾までを選択
vim.cmd([[omap <silent> m :<C-u>lua require('tsht').nodes()<CR>]]) -- motion
vim.cmd([[vnoremap <silent> m :lua require('tsht').nodes()<CR>]]) -- motion
-- 引数の入れ替えをEasyMotion風に行う
-- ssは2つ選択するが, swはカーソル位置の引数と入れ替える
vim.api.nvim_set_keymap("n", "<Leader>ss", "<cmd>ISwap<CR>", { noremap = true }) -- swap motion
vim.api.nvim_set_keymap("n", "<Leader>sw", "<cmd>ISwapWith<CR>", { noremap = true }) -- swap motion with

return m
