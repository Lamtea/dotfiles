-- プラグイン読込
vim.cmd([[packadd packer.nvim]])
require("packer").startup(function(use)
    -- lua製プラグインマネージャ
    use({
        "wbthomason/packer.nvim",
        opt = true,
    })

    -- ライブラリ
    require("plugins.lib").setup(use)

    if not vim.g.vscode then
        -- 通知
        require("plugins.notify").setup(use)

        -- カラースキーム
        require("plugins.colorscheme").setup(use)

        -- lsp
        require("plugins.lsp").setup(use)

        -- linter/formatter
        require("plugins.null-ls").setup(use)

        -- lsp/スニペット補完
        require("plugins.completion").setup(use)

        -- ファジーファインダー
        require("plugins.fzf").setup(use)
    end

    -- treesitter
    require("plugins.treesitter").setup(use)

    if not vim.g.vscode then
        -- ステータスライン
        require("plugins.status-line").setup(use)

        -- バッファライン
        require("plugins.buffer-line").setup(use)

        -- サイドバー
        require("plugins.sidebar").setup(use)

        -- ファイラ
        require("plugins.filer").setup(use)

        -- スクロールバー
        require("plugins.scrollbar").setup(use)

        -- スタート画面
        require("plugins.start-page").setup(use)

        -- ターミナル
        require("plugins.terminal").setup(use)

        -- ヘルプ
        require("plugins.help").setup(use)

        -- ハイライト
        require("plugins.highlight").setup(use)
    end

    -- 基本機能
    require("plugins.basic").setup(use)

    -- コマンド
    require("plugins.command").setup(use)

    if not vim.g.vscode then
        -- git
        require("plugins.git").setup(use)

        -- github
        require("plugins.github").setup(use)

        -- テスト
        require("plugins.test").setup(use)

        -- dap
        require("plugins.dap").setup(use)
    end
end)
