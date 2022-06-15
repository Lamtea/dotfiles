local m = {}
local vsext_path = require("os").getenv("HOME") .. "/dev/vscode"

m.setup = function(use)
    -- nvim-dap is a Debug Adapter Protocol client implementation for Neovim. nvim-dap allows you to:
    -- Launch an application to debug
    -- Attach to running applications and debug them
    -- Set breakpoints and step through code
    -- Inspect the state of the application
    use("mfussenegger/nvim-dap")
    -- A UI for nvim-dap which provides a good out of the box configuration.
    use({
        "rcarriga/nvim-dap-ui",
        requires = { "mfussenegger/nvim-dap" },
    })
    -- This plugin adds virtual text support to nvim-dap. nvim-treesitter is used to find variable definitions.
    use("theHamsta/nvim-dap-virtual-text")
    -- Integration for nvim-dap with telescope.nvim.
    -- This plugin is also overriding dap internal ui,
    -- so running any dap command, which makes use of the internal ui, will result in a telescope prompt.
    use("nvim-telescope/telescope-dap.nvim")
    -- one-small-step-for-vimkind is an adapter for the Neovim lua language.
    -- See the DAP protocol to know more about adapters.
    -- It allows you to debug any lua code running in a Neovim instance.
    use("jbyuki/one-small-step-for-vimkind")
    -- An extension for nvim-dap providing default configurations
    -- for python and methods to debug individual test methods or classes.
    use("mfussenegger/nvim-dap-python")
    -- An extension for nvim-dap providing configurations for launching debug.rb.
    -- NOTE: Supports debug.rb from ruby 3.1, not yet for rails.
    use("suketa/nvim-dap-ruby")
    -- An extension for nvim-dap providing configurations
    -- for launching go debugger (delve) and debugging individual tests.
    use("leoluz/nvim-dap-go")
    -- Dap Buddy allows you to manage debuggers provided by nvim-dap.
    -- It should ease out the process of installing, configuring and interacting with said debuggers.
    -- No troubleshooting needed.
    -- Just plug and play.
    -- At the moment the plugin has gone through some problems that could be traced back to the codebase itself;
    -- that's why I'm going to be doing a rewrite:
    -- faster, better, and without all the bugs it originally had. Stay tuned!
    --  NOTE: Debugger installer is under development.
    -- use("Pocco81/dap-buddy.nvim")

    m.setup_dap()
    m.setup_dap_ui()
    m.setup_dap_virtual_text()
    m.setup_dap_telescope()
    m.setup_dap_nlua()
    m.setup_dap_python()
    m.setup_dap_ruby()
    m.setup_dap_php()
    m.setup_dap_javascript_typescript()
    m.setup_dap_go()
    m.setup_dap_haskell()
    m.setup_dap_dotnet()
    m.setup_dap_kotlin()
    m.setup_dap_lldb()
    m.setup_dap_load_launchjs()
end

m.setup_dap = function()
    -- Load dap.
    require("dap")
    -- Sign settings.
    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "", linehl = "", numhl = "" })
    vim.fn.sign_define("DapLogPoint", { text = "🅻", texthl = "", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "", texthl = "", linehl = "", numhl = "" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "", linehl = "", numhl = "" })
end

m.setup_dap_ui = function()
    local dapui = require("dapui")
    dapui.setup({
        icons = { expanded = "▾", collapsed = "▸" },
        mappings = {
            -- Use a table to apply multiple mappings
            expand = { "<CR>", "<2-LeftMouse>" },
            open = "o",
            remove = "d",
            edit = "e",
            repl = "r",
            toggle = "t",
        },
        -- Expand lines larger than the window
        -- Requires >= 0.7
        expand_lines = vim.fn.has("nvim-0.7"),
        sidebar = {
            -- You can change the order of elements in the sidebar
            elements = {
                -- Provide as ID strings or tables with "id" and "size" keys
                {
                    id = "scopes",
                    -- Can be float or integer > 1
                    size = 0.25,
                },
                { id = "breakpoints", size = 0.25 },
                { id = "stacks", size = 0.25 },
                { id = "watches", size = 00.25 },
            },
            size = 40,
            -- Can be "left", "right", "top", "bottom"
            position = "right",
        },
        tray = {
            elements = { "repl" },
            size = 10,
            -- Can be "left", "right", "top", "bottom"
            position = "bottom",
        },
        floating = {
            -- These can be integers or a float between 0 and 1.
            max_height = nil,
            -- Floats will be treated as percentage of your screen.
            max_width = nil,
            -- Border style. Can be "single", "double" or "rounded"
            border = "single",
            mappings = {
                close = { "q", "<Esc>" },
            },
        },
        windows = { indent = 1 },
        render = {
            -- Can be integer or nil.
            max_type_length = nil,
        },
    })
    -- Auto opening/closing.
    local dap = require("dap")
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end
end

m.setup_dap_virtual_text = function()
    require("nvim-dap-virtual-text").setup({
        -- enable this plugin (the default)
        enabled = true,
        -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle,
        -- (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
        enabled_commands = true,
        -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
        highlight_changed_variables = true,
        -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
        highlight_new_as_changed = false,
        -- show stop reason when stopped for exceptions
        show_stop_reason = true,
        -- prefix virtual text with comment string
        commented = true,
        -- only show virtual text at first definition (if there are multiple)
        only_first_definition = true,
        -- show virtual text on all all references of the variable (not only definitions)
        all_references = false,
        -- filter references (not definitions) pattern when all_references is activated
        -- (Lua gmatch pattern, default filters out Python modules)
        filter_references_pattern = "<module",
        -- experimental features:
        -- position of virtual text, see `:h nvim_buf_set_extmark()`
        virt_text_pos = "eol",
        -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
        all_frames = false,
        -- show virtual lines instead of virtual text (will flicker!)
        virt_lines = false,
        -- position the virtual text at a fixed window column (starting from the first text column) ,
        virt_text_win_col = nil,
        -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
    })
end

m.setup_dap_telescope = function()
    require("telescope").load_extension("dap")
end

m.setup_dap_nlua = function()
    local dap = require("dap")
    dap.configurations.lua = {
        {
            type = "nlua",
            request = "attach",
            name = "Attach to running Neovim instance",
            host = function()
                local value = vim.fn.input("Host [127.0.0.1]: ")
                if value ~= "" then
                    return value
                end
                return "127.0.0.1"
            end,
            port = function()
                local val = tonumber(vim.fn.input("Port: "))
                assert(val, "Please provide a port number")
                return val
            end,
        },
    }

    dap.adapters.nlua = function(callback, config)
        callback({ type = "server", host = config.host, port = config.port })
    end
end

m.setup_dap_python = function()
    local dap_python_adapter_path = require("os").getenv("HOME") .. "/.pyenv/shims/python"
    local dap_python = require("dap-python")
    local dap_python_opts = {
        include_configs = true,
        console = "internalConsole",
        pythonPath = function()
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                -- poetry
                return cwd .. "/.venv/bin/python"
            else
                return dap_python_adapter_path
            end
        end,
    }
    dap_python.setup(dap_python_adapter_path, dap_python_opts)
    dap_python.test_runner = "pytest"
end

m.setup_dap_ruby = function()
    local dap_ruby = require("dap-ruby")
    -- Port is 38698 by default.
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
            -- Xdebug default port.
            port = 9003,
        },
    }
end

m.setup_dap_javascript_typescript = function()
    local dap = require("dap")
    -- NOTE: For now nvim-dap vscode-js-debug is out of support.
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
    }
    local chrome_configuration = {
        name = "Launch(chrome)",
        type = "chrome",
        request = "launch",
        -- live-server/webpack-dev-server default port.
        url = "http://localhost:8080",
        -- webpack-dev-server default.
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
            name = "Launch",
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
                return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
            end,
        },
    }
end

m.setup_dap_kotlin = function()
    local dap = require("dap")
    dap.adapters.kotlin = {
        type = "executable",
        command = vsext_path .. "/kotlin-debug-adapter/adapter/build/install/adapter/bin/kotlin-debug-adapter",
        args = { "--interpreter=vscode" },
    }
    dap.configurations.kotlin = {
        {
            type = "kotlin",
            name = "Launch",
            request = "launch",
            projectRoot = vim.fn.getcwd() .. "/app",
            mainClass = function()
                return vim.fn.input("Path to main class: ", "", "file")
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
            name = "Launch",
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

m.setup_dap_load_launchjs = function()
    require("dap.ext.vscode").load_launchjs()
end

-- neovim lua.
-- Launch the server in the debuggee using require"osv".launch().
-- Open another Neovim instance with the source file.
-- Place breakpoint.
-- Connect using the DAP client.
-- Run your script/plugin in the debuggee.
vim.api.nvim_set_keymap("n", "<F2>", "<Cmd>lua require'osv'.launch()<CR>", { noremap = true, silent = true })
-- Open a lua file.
-- Place breakpoint.
-- Invoke require"osv".run_this().
vim.api.nvim_set_keymap("n", "<F3>", "<Cmd>lua require'osv'.run_this()<CR>", { noremap = true, silent = true })

-- dap.
-- vscode like.
vim.api.nvim_set_keymap("n", "<F4>", "<Cmd>lua require'dap'.disconnect({})<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F5>", "<Cmd>lua require'dap'.continue()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F6>", "<Cmd>lua require'dap'.run_last()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
    "n",
    "<F7>",
    "<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
    "n",
    "<F8>",
    "<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
    { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<F9>", "<Cmd>lua require'dap'.toggle_breakpoint()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F10>", "<Cmd>lua require'dap'.step_over()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F11>", "<Cmd>lua require'dap'.step_into()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-F11>", "<Cmd>lua require'dap'.step_out()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F12>", "<Cmd>lua require'dap'.repl.open()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap(
    "n",
    "<S-F12>",
    "<Cmd>lua require'dap.ext.vscode'.load_launchjs()<CR>",
    { noremap = true, silent = true }
)

-- dapui.
-- Toggle show/close of dapui windows.
vim.api.nvim_set_keymap("n", "<space>u", '<Cmd>lua require("dapui").toggle()<CR>', { noremap = true, silent = true })
-- Pop up the evaluation results of the selection.
vim.api.nvim_set_keymap("v", "<space>u", '<Cmd>lua require("dapui").eval()<CR>', { noremap = true, silent = true })

-- telescope.
-- Show dap commands.
vim.api.nvim_set_keymap(
    "n",
    "<leader>dr",
    "lua require'telescope'.extensions.dap.commands{}",
    { noremap = true, silent = true }
)
-- Show dap configurations.
vim.api.nvim_set_keymap(
    "n",
    "<leader>dc",
    "<Cmd>lua require'telescope'.extensions.dap.configurations{}<CR>",
    { noremap = true, silent = true }
)
-- Show breakpoints.
vim.api.nvim_set_keymap(
    "n",
    "<leader>db",
    "<Cmd>lua require'telescope'.extensions.dap.list_breakpoints{}<CR>",
    { noremap = true, silent = true }
)
-- Show variables.
vim.api.nvim_set_keymap(
    "n",
    "<leader>dv",
    "<Cmd>lua require'telescope'.extensions.dap.variables{}<CR>",
    { noremap = true, silent = true }
)

return m
