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

    -- treesitter
    require("plugins.treesitter").setup(use)

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

    -- 標準機能
    require("plugins.basic").setup(use)

    -- テスト
    require("plugins.test").setup(use)

    -- git
    require("plugins.git").setup(use)

    -- github
    use({
        "pwntester/octo.nvim", -- :Octo <object> <action> [argument] コマンド(TAB補完推奨)でgithub-cliと同じようなことができる(github-cli必須)
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "kyazdani42/nvim-web-devicons",
        },
        config = function()
            require("octo").setup()
        end,
    })

    -- デバッガー
    use("mfussenegger/nvim-dap") -- noevim用デバッガアダプタプロトコル(各種debugger必須, インストール後に :helptags ALL を実行しておく)
    use("mfussenegger/nvim-dap-python") -- python用dap(poetryサポートがpull request中なのでそのうち入るはず)
    use("suketa/nvim-dap-ruby") -- ruby用dap(ruby 3.1から入ったdebug.rbに対応, railsについてはnot yet)
    use("leoluz/nvim-dap-go") -- go用dap
    -- use("Pocco81/dap-buddy.nvim") -- デバッガインストーラーが開発中

    local dap = require("dap")
    local dap_ext_vscode = require("dap.ext.vscode")
    dap_ext_vscode.load_launchjs(".vscode/launch.json") -- vscodeと違って標準JSONなので末尾のコンマはエラーになる点に注意

    local dap_python = require("dap-python")
    dap_python.setup(require("os").getenv("HOME") .. "/.pyenv/shims/python")
    dap_python.test_runner = "pytest"

    local dap_ruby = require("dap-ruby")
    dap_ruby.setup()

    dap.adapters.lldb = {
        type = "executable",
        command = "/usr/bin/lldb-vscode",
        name = "lldb",
    }
    dap.configurations.cpp = {
        {
            name = "Launch file",
            type = "lldb",
            request = "launch",
            program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = {},
        },
    }
    dap.configurations.c = dap.configurations.cpp
    dap.configurations.rust = dap.configurations.cpp

    local dap_go = require("dap-go")
    dap_go.setup()

    dap.adapters.haskell = {
        type = "executable",
        command = "haskell-debug-adapter",
        args = { "--hackage-version=0.0.35.0" },
    }
    dap.configurations.haskell = {
        {
            type = "haskell",
            request = "launch",
            name = "Launch file",
            workspace = "${workspaceFolder}",
            startup = "${file}",
            stopOnEntry = true,
            logFile = vim.fn.stdpath("data") .. "/haskell-dap.log",
            logLevel = "WARNING",
            ghciEnv = vim.empty_dict(),
            ghciPrompt = "> ",
            ghciInitialPrompt = "> ",
            ghciCmd = "stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show",
        },
    }

    vim.api.nvim_set_keymap("n", "<F4>", "<Cmd>lua require'dap'.disconnect({})<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<F5>", "<Cmd>lua require'dap'.continue()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<F6>", "<Cmd>lua require'dap'.load_launchjs()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<F7>", "lua require'dap'.run_last()", { noremap = true, silent = true })
    vim.api.nvim_set_keymap(
        "n",
        "<F8>",
        "lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))",
        { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
        "n",
        "<F9>",
        "<Cmd>lua require'dap'.toggle_breakpoint()<CR>",
        { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap("n", "<F10>", "<Cmd>lua require'dap'.step_over()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<F11>", "<Cmd>lua require'dap'.step_into()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<S-F11>", "<Cmd>lua require'dap'.step_out()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<F12>", "<Cmd>lua require'dap'.repl.open()<CR>", { noremap = true, silent = true })

    vim.api.nvim_set_keymap(
        "n",
        "<leader>dr",
        "lua require'telescope'.extensions.dap.commands{}",
        { noremap = true, silent = true }
    ) -- run
    vim.api.nvim_set_keymap(
        "n",
        "<leader>dc",
        "<Cmd>lua require'telescope'.extensions.dap.configurations{}<CR>",
        { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
        "n",
        "<leader>dd",
        "<Cmd>lua require'telescope'.extensions.dap.list_breakpoints{}<CR>",
        { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
        "n",
        "<leader>dv",
        "<Cmd>lua require'telescope'.extensions.dap.variables{}<CR>",
        { noremap = true, silent = true }
    )

    vim.cmd([[nnoremap <silent> <leader>tpp :lua require('dap-python').test_method()<CR>]])
    vim.cmd([[nnoremap <silent> <leader>tpa :lua require('dap-python').test_class()<CR>]])
    vim.cmd([[vnoremap <silent> <leader>tps <ESC>:lua require('dap-python').debug_selection()<CR>]])
    vim.cmd([[nmap <silent> <leader>tg :lua require('dap-go').debug_test()<CR>]])

    -- コマンド
    use("mileszs/ack.vim") -- :Ack
end)
