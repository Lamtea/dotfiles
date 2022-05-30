local m = {}

m.setup = function(use)
    -- lspクライアント
    use("neovim/nvim-lspconfig")
    -- lspインストーラー
    -- :LspInstall :LspInstallinfo コマンドでlsをインストールする see:github
    -- omnisharpをインストールするとomnisharp-roslynも入る
    use("williamboman/nvim-lsp-installer")
    -- lsp補完用ソース
    use("hrsh7th/cmp-nvim-lsp")
    -- lsp高性能UI
    use("tami5/lspsaga.nvim")
    -- lsp用のカラー追加
    use("folke/lsp-colors.nvim")
    -- lsp診断UI
    use({
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
    })
    -- lspプログレス
    use("j-hui/fidget.nvim")
    -- lsp単語ハイライト(vimscript)
    use("RRethy/vim-illuminate")
    -- neovimがkotlinのファイルタイプを認識しないために必要
    use("udalov/kotlin-vim")

    -- vim-illuminateの単語をハイライトするまでの時間
    vim.g.Illuminate_delay = 500
    -- vim-illuminateのカーソル位置の単語はハイライトしない
    vim.g.Illuminate_highlightUnderCursor = 0

    m.setup_lsp()
    m.setup_lspsaga()
    m.setup_lsp_color()
    m.setup_trouble()
    m.setup_fidget()
end

m.setup_lsp = function()
    local on_attach = function(client, bufnr)
        -- 単語ハイライトをアタッチ
        require("illuminate").on_attach(client)

        -- キーマップ設定
        local function buf_set_keymap(...)
            vim.api.nvim_buf_set_keymap(bufnr, ...)
        end

        local opts = { noremap = true, silent = true }

        -- telescope使用<leader>ld
        -- カーソル下のシンボルの宣言にジャンプする(多くのサーバーがまだ未実装, see: help)
        buf_set_keymap("n", "gD", "lua vim.lsp.buf.declaration()", opts)

        -- telescope使用<leader>ld
        -- カーソル下のシンボルの定義にジャンプする
        buf_set_keymap("n", "gd", "lua vim.lsp.buf.definition()", opts)

        -- lspsaga使用
        -- buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

        -- telescope使用<leader>li
        -- quickfixにカーソル下のシンボルの実装をリストする
        buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)

        -- lspsaga使用
        -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

        buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
        buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
        buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)

        -- telescope使用<leader>lt
        -- カーソル下のシンボルの型定義にジャンプする
        buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)

        -- lspsaga使用
        -- buf_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

        -- lspsaga使用
        -- buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

        -- trouble使用, telescope使用<leader>lr
        -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

        -- lspsaga使用
        -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)

        -- lspsaga使用
        -- buf_set_keymap('n', '<space>p', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)

        -- lspsaga使用
        -- buf_set_keymap('n', '<space>n', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

        buf_set_keymap("n", "<space>l", "lua vim.lsp.diagnostic.set_loclist()", opts)
        buf_set_keymap("n", "<space>q", "lua vim.lsp.diagnostic.set_qflist()", opts)
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
    end

    -- インストール済のlspとlsp用補完をアタッチする
    local lsp_installer = require("nvim-lsp-installer")
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
    lsp_installer.setup()
    for _, server in ipairs(lsp_installer.get_installed_servers()) do
        local serverconfig = lspconfig[server.name]

        -- 言語別の設定
        if server.name == "clangd" then
            -- c/cpp
            -- NOTE: エンコーディング指定しないと警告が出る
            local clangd_capabilities = require("cmp_nvim_lsp").update_capabilities(
                vim.lsp.protocol.make_client_capabilities()
            )
            clangd_capabilities.offsetEncoding = { "utf-16" }
            serverconfig.setup({
                on_attach = on_attach,
                capabilities = clangd_capabilities,
            })
        elseif server.name == "hls" then
            -- haskell
            serverconfig.setup({
                -- formatterはstylish-haskell使用
                haskell = {
                    formattingProvider = "Stylish Haskell",
                },
                on_attach = on_attach,
                capabilities = capabilities,
            })
        elseif server.name == "html" then
            -- html
            serverconfig.setup({
                -- formatterはprettierを使用
                provideFormatter = false,
                on_attach = on_attach,
                capabilities = capabilities,
            })
        elseif server.name == "jsonls" then
            -- json
            serverconfig.setup({
                -- formatterはprettierを使用
                provideFormatter = false,
                on_attach = on_attach,
                capabilities = capabilities,
            })
        elseif server.name == "sumneko_lua" then
            -- lua
            serverconfig.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            -- neovim設定ファイル用(vimがグローバルオブジェクトのため)
                            globals = { "vim" },
                            neededFileStatus = {
                                ["codestyle-check"] = "Any",
                            },
                        },
                        format = {
                            -- formatterはstyluaを使用
                            enable = false,
                        },
                    },
                },
                on_attach = on_attach,
                capabilities = capabilities,
            })
        else
            -- 通常設定
            serverconfig.setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end
    end
end

m.setup_lspsaga = function()
    require("lspsaga").setup({
        debug = false,
        use_saga_diagnostic_sign = true,
        error_sign = "",
        warn_sign = "",
        hint_sign = "",
        infor_sign = "",
        diagnostic_header_icon = "   ",
        code_action_icon = " ",
        code_action_prompt = {
            enable = true,
            sign = true,
            sign_priority = 40,
            virtual_text = true,
        },
        finder_definition_icon = "  ",
        finder_reference_icon = "  ",
        max_preview_lines = 40,
        finder_action_keys = {
            open = "o",
            vsplit = "s",
            split = "i",
            quit = "q",
            scroll_down = "<C-f>",
            scroll_up = "<C-d>",
        },
        code_action_keys = {
            quit = "q",
            exec = "<CR>",
        },
        rename_action_keys = {
            quit = "<C-c>",
            exec = "<CR>",
        },
        definition_preview_icon = "  ",
        border_style = "single",
        rename_prompt_prefix = "➤",
        server_filetype_map = {},
        diagnostic_prefix_format = "%d. ",
    })
end

m.setup_lsp_color = function()
    require("lsp-colors").setup({
        Error = "#db4b4b",
        Warning = "#e0af68",
        Information = "#0db9d7",
        Hint = "#10B981",
    })
end

m.setup_trouble = function()
    -- デフォルトキーマップ
    -- close = "q",                 close the list
    -- cancel = "<esc>",            cancel the preview and get back to your last window / buffer / cursor
    -- refresh = "r",               manually refresh
    -- jump = { "<cr>", "<tab>" },  jump to the diagnostic or open / close folds
    -- open_split = { "<c-x>" },    open buffer in new split
    -- open_vsplit = { "<c-v>" },   open buffer in new vsplit
    -- open_tab = { "<c-t>" },      open buffer in new tab
    -- jump_close = { "o" },        jump to the diagnostic and close the list
    -- toggle_mode = "m",           toggle between "workspace" and "document" diagnostics mode
    -- toggle_preview = "P",        toggle auto_preview
    -- hover = "K",                 opens a small popup with the full multiline message
    -- preview = "p",               preview the diagnostic location
    -- close_folds = { "zM", "zm" },close all folds
    -- open_folds = { "zR", "zr" }, open all folds
    -- toggle_fold = { "zA", "za" },toggle fold of current file
    -- previous = "k",              preview item
    -- next = "j"                   next item
    require("trouble").setup({
        height = 10,
        -- 診断がない場合は自動で閉じる
        auto_close = true,
        -- lspクライアントと同じ記号を使用
        use_diagnostic_signs = true,
    })
end

m.setup_fidget = function()
    require("fidget").setup({
        task = function(task_name, message, percentage)
            return string.format(
                "%s%s [%s]",
                message,
                percentage and string.format(" (%s%%)", percentage) or "",
                task_name
            )
        end,
    })
end

-- カーソル下のシンボルの定義と参照を検索(ワークスペース対象)
vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true, noremap = true })
-- コードアクション
vim.keymap.set("n", "<space>a", "<cmd>Lspsaga code_action<CR>", { silent = true, noremap = true })
-- 範囲コードアクション(ブロックレベルなど)
vim.keymap.set("x", "<space>a", ":<C-u>Lspsaga range_code_action<CR>", { silent = true, noremap = true })
-- インターフェースドキュメント(ドキュメントコメント対応, shellだとmanページが開く)
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true, noremap = true })
-- lspsagaのUIでスクロール
vim.cmd([[nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>]])
vim.cmd([[nnoremap <silent> <C-d> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>]])
-- メソッドの引数シグネチャヘルプ
vim.keymap.set("n", "<C-k>", "<cmd>Lspsaga signature_help<CR>", { silent = true, noremap = true })
-- 識別子のリネーム
vim.keymap.set("n", "<space>r", "<cmd>Lspsaga rename<CR>", { silent = true, noremap = true })
-- 定義のプレビュー
vim.keymap.set("n", "<space>d", "<cmd>Lspsaga preview_definition<CR>", { silent = true, noremap = true })
-- 現在行の診断
vim.keymap.set("n", "<space>e", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true, noremap = true })
-- カーソル下の識別子の診断
vim.keymap.set(
    "n",
    "<space>E",
    [[<cmd>lua require('lspsaga.diagnostic').show_cursor_diagnostics()<CR>]],
    { silent = true, noremap = true }
)
-- 次の診断へジャンプ
vim.keymap.set("n", "<space>n", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true, noremap = true })
-- 前の診断へジャンプ
vim.keymap.set("n", "<space>p", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true, noremap = true })
-- floatingでターミナルを開く(表示中は同じキーで閉じる)
vim.keymap.set("n", "<M-f>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true, noremap = true })
vim.cmd([[tnoremap <silent> <M-f> <C-\><C-n>:Lspsaga close_floaterm<CR>]])
-- 診断ウィンドウを開く(直前のモード, デフォルトはワークスペース)
vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<CR>", { silent = true, noremap = true })
-- 診断ウィンドウを開く(ワークスペースの診断)
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<CR>", { silent = true, noremap = true })
-- 診断ウィンドウを開く(現在ドキュメントの診断)
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<CR>", { silent = true, noremap = true })
-- カーソル下のシンボルの参照(開いているすべてのバッファ対象)を診断ウィンドウで開く
vim.api.nvim_set_keymap("n", "gr", "<cmd>Trouble lsp_references<CR>", { silent = true, noremap = true })

return m
