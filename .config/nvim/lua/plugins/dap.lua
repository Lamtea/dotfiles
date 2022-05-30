local m = {}
local vsext_path = require("os").getenv("HOME") .. "/dev/vscode"

m.setup = function(use)
    -- noevim用デバッガアダプタプロトコル
    -- 各種debugger必須, インストール後に :helptags ALL を実行しておく
    use("mfussenegger/nvim-dap")
    -- python用dap
    -- poetryサポートがpull request中なのでそのうち入るはず
    use("mfussenegger/nvim-dap-python")
    -- ruby用dap
    -- ruby 3.1から入ったdebug.rbに対応, railsについてはnot yet
    use("suketa/nvim-dap-ruby")
    -- go用dap
    use("leoluz/nvim-dap-go")
    -- NOTE: デバッガインストーラーが開発中
    -- use("Pocco81/dap-buddy.nvim")

    m.setup_dap_python()
    m.setup_dap_ruby()
    m.setup_dap_php()
    m.setup_dap_javascript_typescript()
    m.setup_dap_go()
    m.setup_dap_haskell()
    m.setup_dap_dotnet()
    m.setup_dap_lldb()
    m.setup_dap_load_launchjs()
end

m.setup_dap_load_launchjs = function()
    -- vscodeと違って標準JSONなので末尾のコンマはエラーになる点に注意
    require("dap.ext.vscode").load_launchjs()
end

m.setup_dap_python = function()
    local dap_python = require("dap-python")
    dap_python.setup(require("os").getenv("HOME") .. "/.pyenv/shims/python")
    dap_python.test_runner = "pytest"
end

m.setup_dap_ruby = function()
    local dap_ruby = require("dap-ruby")
    -- portは38698がデフォルト設定
    dap_ruby.setup()
end

m.setup_dap_php = function()
    local dap = require("dap")
    dap.adapters.php = {
        type = "executable",
        command = "node",
        args = { vsext_path .. "/vscode-php-debug/out/phpDebug.js" },
    }
    dap.configurations.php = {
        {
            type = "php",
            request = "launch",
            name = "Listen for Xdebug",
            -- Xdebugのデフォルト
            port = 9003,
        },
    }
end

m.setup_dap_javascript_typescript = function()
    local dap = require("dap")
    -- NOTE: 今のところnvim-dapでvscode-js-debugはサポート外になっている
    dap.adapters.node2 = {
        type = "executable",
        command = "node",
        args = { vsext_path .. "/vscode-node-debug2/out/src/nodeDebug.js" },
    }
    dap.adapters.chrome = {
        type = "executable",
        command = "node",
        args = { vsext_path .. "/vscode-chrome-debug/out/src/chromeDebug.js" },
    }
    dap.adapters.firefox = {
        type = "executable",
        command = "node",
        args = { vsext_path .. "/vscode-firefox-debug/dist/adapter.bundle.js" },
    }
    local node2_configuration_javascript = {
        name = "Launch(node)",
        type = "node2",
        request = "launch",
        program = "${file}",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        console = "integratedTerminal",
    }
    local node2_configuration_typescript = {
        name = "Launch(node)",
        type = "node2",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        console = "integratedTerminal",
    }
    local chrome_configuration = {
        name = "Launch(chrome)",
        type = "chrome",
        request = "launch",
        -- live-server/webpack-dev-serverのデフォルト
        url = "http://localhost:8080",
        -- webpack-dev-serverのデフォルト
        webRoot = "${workspaceFolder}/public",
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = "inspector",
        runtimeExecutable = "/usr/bin/google-chrome-stable",
    }
    dap.configurations.javascript = {
        node2_configuration_javascript,
        chrome_configuration,
    }
    dap.configurations.typescript = {
        node2_configuration_typescript,
        chrome_configuration,
    }
    dap.configurations.javascriptreact = {
        chrome_configuration,
    }
    dap.configurations.vue = dap.configurations.javascriptreact
    dap.configurations.typescriptreact = dap.configurations.javascriptreact
end

m.setup_dap_go = function()
    local dap_go = require("dap-go")
    dap_go.setup()
end

m.setup_dap_haskell = function()
    local dap = require("dap")
    dap.adapters.haskell = {
        type = "executable",
        command = "haskell-debug-adapter",
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
end

m.setup_dap_dotnet = function()
    local dap = require("dap")
    dap.adapters.coreclr = {
        type = "executable",
        command = "netcoredbg",
        args = { "--interpreter=vscode" },
    }
    dap.configurations.cs = {
        {
            type = "coreclr",
            name = "Launch",
            request = "launch",
            program = function()
                return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
            end,
        },
    }
end

m.setup_dap_lldb = function()
    local dap = require("dap")
    dap.adapters.lldb = {
        type = "executable",
        command = "lldb-vscode",
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
end

-- dap
-- アダプタ切断
vim.api.nvim_set_keymap("n", "<F4>", "<Cmd>lua require'dap'.disconnect({})<CR>", { noremap = true, silent = true })
-- プロセス続行
vim.api.nvim_set_keymap("n", "<F5>", "<Cmd>lua require'dap'.continue()<CR>", { noremap = true, silent = true })
-- launch.jsonの読込
vim.api.nvim_set_keymap(
    "n",
    "<F6>",
    "<Cmd>lua require'dap.ext.vscode'.load_launchjs()<CR>",
    { noremap = true, silent = true }
)
-- 最後に実行したデバッグを再実行
vim.api.nvim_set_keymap("n", "<F7>", "lua require'dap'.run_last()", { noremap = true, silent = true })
-- ブレークポイントの条件設定
vim.api.nvim_set_keymap(
    "n",
    "<F8>",
    "lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))",
    { noremap = true, silent = true }
)
-- ブレークポイントのトグル
vim.api.nvim_set_keymap("n", "<F9>", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", { noremap = true, silent = true })
-- ステップオーバー実行
vim.api.nvim_set_keymap("n", "<F10>", "<Cmd>lua require'dap'.step_over()<CR>", { noremap = true, silent = true })
-- ステップイン実行
vim.api.nvim_set_keymap("n", "<F11>", "<Cmd>lua require'dap'.step_into()<CR>", { noremap = true, silent = true })
-- ステップアウト実行
vim.api.nvim_set_keymap("n", "<S-F11>", "<Cmd>lua require'dap'.step_out()<CR>", { noremap = true, silent = true })
-- REPL
vim.api.nvim_set_keymap("n", "<F12>", "<Cmd>lua require'dap'.repl.open()<CR>", { noremap = true, silent = true })
-- デバッグコマンドをtelescopeで表示
vim.api.nvim_set_keymap(
    "n",
    "<leader>dr",
    "lua require'telescope'.extensions.dap.commands{}",
    { noremap = true, silent = true }
)
-- デバッグ設定をtelescopeで表示
vim.api.nvim_set_keymap(
    "n",
    "<leader>dc",
    "<Cmd>lua require'telescope'.extensions.dap.configurations{}<CR>",
    { noremap = true, silent = true }
)
-- ブレークポイントリストをtelescopeで表示
vim.api.nvim_set_keymap(
    "n",
    "<leader>dd",
    "<Cmd>lua require'telescope'.extensions.dap.list_breakpoints{}<CR>",
    { noremap = true, silent = true }
)
-- 変数リストをtelescopeで表示
vim.api.nvim_set_keymap(
    "n",
    "<leader>dv",
    "<Cmd>lua require'telescope'.extensions.dap.variables{}<CR>",
    { noremap = true, silent = true }
)

-- python
-- カーソル位置のテストメソッドを実行
vim.cmd([[nnoremap <silent> <leader>tpp :lua require('dap-python').test_method()<CR>]])
-- カーソル位置のテストクラスを実行
vim.cmd([[nnoremap <silent> <leader>tpa :lua require('dap-python').test_class()<CR>]])
-- 選択範囲のデバッグを実行
vim.cmd([[vnoremap <silent> <leader>tps <ESC>:lua require('dap-python').debug_selection()<CR>]])

-- go
-- カーソル位置のテストメソッドを実行
vim.cmd([[nmap <silent> <leader>tg :lua require('dap-go').debug_test()<CR>]])

return m
