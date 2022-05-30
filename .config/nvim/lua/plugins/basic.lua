local m = {}

m.setup = function(use)
    -- 移動
    -- ラベルジャンプ(EasyMotion風)
    use("phaazon/hop.nvim")
    -- 1行内文字選択ジャンプ(vimscript)
    use("unblevable/quick-scope")
    -- キャメルケースの移動(vimscript)
    use("bkad/CamelCaseMotion")

    -- 編集
    -- クォートや括弧などのサンドイッチ要素の編集(vimscript)
    -- sa(add), sd(delete), sr(replace)
    use("machakann/vim-sandwich")

    -- コメント
    -- treesitter機能のnvim-ts-context-commentstringを使用してコメンティング
    use("numToStr/Comment.nvim")

    if not vim.g.vscode then
        -- レジスタ
        -- sqliteを使用してレジスタを共有でき, telescope連携可能
        use({
            "AckslD/nvim-neoclip.lua",
            requires = {
                { "tami5/sqlite.lua", module = "sqlite" },
                { "nvim-telescope/telescope.nvim" },
            },
        })

        -- 検索
        -- 検索時にカーソルの隣にマッチ情報表示
        -- nvim-scrollarと連携してスクロールバーにハイライト表示
        use("kevinhwang91/nvim-hlslens")

        -- 括弧
        -- 括弧を自動で閉じてくれる
        use("windwp/nvim-autopairs")
    end

    -- quick-scopeのキー設定
    -- f/tは前方検索, F/Tは後方検索, t版は選択した文字の手前にカーソルする
    vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
    -- camelcasemotionのキー設定
    -- 通常の操作にキャメルケース判定を加えた動作をする(<leader> + w, b, e, ge)
    vim.g.camelcasemotion_key = "<leader>"

    m.setup_hop()
    m.setup_comment()

    if not vim.g.vscode then
        m.setup_neoclip()
        m.setup_autopairs()
    end
end

m.setup_hop = function()
    require("hop").setup()
end

m.setup_neoclip = function()
    require("neoclip").setup({
        enable_persistent_history = true,
    })
    require("telescope").load_extension("neoclip")
end

m.setup_comment = function()
    require("Comment").setup({
        pre_hook = function()
            return require("ts_context_commentstring.internal").calculate_commentstring()
        end,
        post_hook = nil,
    })
end

m.setup_autopairs = function()
    require("nvim-autopairs").setup({
        map_cr = false,
    })
end

-- EasyMotion風ジャンプ(表示されている単語の先頭にジャンプする)
vim.api.nvim_set_keymap("n", "<leader>m", [[<cmd>lua require('hop').hint_words()<CR>]], {})
vim.api.nvim_set_keymap("x", "<leader>m", [[<cmd>lua require('hop').hint_words()<CR>]], {})

if not vim.g.vscode then
    -- レジスタをtelescopeで検索
    -- <CR> select
    -- p(normal) or <C-p>(insert) paste
    -- k(normal) or <C-k>(insert) paste-ehind
    -- q(normal) or <C-q>(insert) replay-macro
    -- d(normal) or <C-d>(insert) delete
    vim.api.nvim_set_keymap("n", "<leader>fr", "<Cmd>Telescope neoclip<CR>", { noremap = true, silent = true })

    -- 標準コマンド拡張(順方向に再検索)
    vim.api.nvim_set_keymap(
        "n",
        "n",
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        { noremap = true, silent = true }
    )
    -- 標準コマンド拡張(逆方向に再検索)
    vim.api.nvim_set_keymap(
        "n",
        "N",
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        { noremap = true, silent = true }
    )
    -- 前方一致検索
    vim.api.nvim_set_keymap("n", "*", [[g*<Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true })
    -- 後方一致検索
    vim.api.nvim_set_keymap("n", "g*", [[g#<Cmd>lua require('hlslens').start()<CR>]], { noremap = true, silent = true })
end

return m
