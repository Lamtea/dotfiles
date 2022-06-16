local m = {}

m.setup = function(use)
    use({
        "akinsho/flutter-tools.nvim",
        requires = "nvim-lua/plenary.nvim",
    })

    m.setup_flutter_tools()
end

m.setup_flutter_tools = function()
    local lsp = require("plugins.lsp")
    require("flutter-tools").setup({
        decorations = {
            statusline = {
                -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
                -- this will show the current version of the flutter app from the pubspec.yaml file
                app_version = true,
                -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
                -- this will show the currently running device if an application was started with a specific
                -- device
                device = true,
            },
        },
        -- integrate with nvim dap + install dart code debugger
        debugger = {
            enabled = true,
            -- use dap instead of a plenary job to run flutter apps
            run_via_dap = true,
        },
        -- example "dirname $(which flutter)" or "asdf where flutter"
        flutter_lookup_cmd = "asdf where flutter",
        widget_guides = {
            enabled = true,
        },
        dev_log = {
            enabled = false,
        },
        lsp = {
            -- show the derived colours for dart variables
            color = {
                -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
                enabled = true,
                -- highlight the background
                background = true,
            },
            on_attach = lsp.on_attach,
            capabilities = lsp.get_capabilities(),
        },
    })
end

return m
