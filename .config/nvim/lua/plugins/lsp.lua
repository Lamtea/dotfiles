local m = {}

m.setup = function(use)
    -- A collection of common configurations for Neovim's built-in language server client.
    -- This plugin allows for declaratively configuring, launching,
    -- and initializing language servers you have installed on your system.
    -- Disclaimer: Language server configurations are provided on a best-effort basis and are community-maintained.
    -- See contributions.
    -- lspconfig has extensive help documentation, see :help lspconfig.
    use("neovim/nvim-lspconfig")
    -- Neovim plugin that allow you to manage LSP servers
    -- (servers are installed inside :echo stdpath("data") by default).
    -- It works in tandem with lspconfig1 by registering a hook that enhances the PATH environment variable,
    -- allowing neovim's LSP client to locate the server executable installed by nvim-lsp-installer.
    use("williamboman/nvim-lsp-installer")
    -- nvim-cmp source for neovim's built-in language server client.
    use("hrsh7th/cmp-nvim-lsp")
    -- A maintained fork of glepnir/lspsaga.nvim.
    -- Lspsaga is light-weight lsp plugin based on neovim built-in lsp with highly a performant UI.
    use("tami5/lspsaga.nvim")
    -- Automatically creates missing LSP diagnostics highlight groups for color schemes
    -- that don't yet support the Neovim 0.5 builtin lsp client.
    use("folke/lsp-colors.nvim")
    -- A pretty list for showing diagnostics, references, telescope results,
    -- quickfix and location lists to help you solve all the trouble your code is causing.
    use({
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
    })
    -- Standalone UI for nvim-lsp progress. Eye candy for the impatient.
    use("j-hui/fidget.nvim")
    -- Vim plugin for automatically highlighting other uses of the current word under the cursor.
    use("RRethy/vim-illuminate")

    -- vim-illuminate
    vim.g.Illuminate_delay = 500
    vim.g.Illuminate_highlightUnderCursor = 0

    m.setup_lsp()
    m.setup_lspsaga()
    m.setup_lsp_color()
    m.setup_trouble()
    m.setup_fidget()
end

m.on_attach = function(client, bufnr)
    require("illuminate").on_attach(client)

    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    local opts = { noremap = true, silent = true }

    -- telescope <leader>ld
    buf_set_keymap("n", "gD", "lua vim.lsp.buf.declaration()", opts)

    -- telescope <leader>ld
    buf_set_keymap("n", "gd", "lua vim.lsp.buf.definition()", opts)

    -- lspsaga
    -- buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

    -- telescope <leader>li
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)

    -- lspsaga
    -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

    buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)

    -- telescope <leader>lt
    buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)

    -- lspsaga
    -- buf_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

    -- lspsaga
    -- buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

    -- trouble, telescope <leader>lr
    -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)

    -- lspsaga
    -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)

    -- lspsaga
    -- buf_set_keymap('n', '<space>p', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)

    -- lspsaga
    -- buf_set_keymap('n', '<space>n', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

    buf_set_keymap("n", "<space>l", "lua vim.lsp.diagnostic.set_loclist()", opts)
    buf_set_keymap("n", "<space>q", "lua vim.lsp.diagnostic.set_qflist()", opts)
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
end

m.get_capabilities = function()
    return require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
end

local function get_clang_capabilities()
    -- NOTE: Warning will be issued if encoding is not specified.
    local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
    capabilities.offsetEncoding = { "utf-16" }
    return capabilities
end

local function setup_lsp_clangd(serverconfig, on_attach)
    serverconfig.setup({
        on_attach = on_attach,
        capabilities = get_clang_capabilities(),
    })
end

local function setup_lsp_rust_analyzer(serverconfig, on_attach, capabilities)
    serverconfig.setup({
        settings = {
            ["rust-analyzer"] = {
                cargo = {
                    loadOutDirsFromCheck = true,
                },
                procMacro = {
                    enable = true,
                },
                checkOnSave = {
                    command = "clippy",
                },
            },
        },
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

local function setup_lsp_hls(serverconfig, on_attach, capabilities)
    serverconfig.setup({
        settings = {
            haskell = {
                hlintOn = true,
                formattingProvider = "fourmolu",
            },
        },
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

local function setup_lsp_html(serverconfig, on_attach, capabilities)
    serverconfig.setup({
        init_options = {
            -- Use prettier
            provideFormatter = false,
        },
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

local function setup_lsp_jsonls(serverconfig, on_attach, capabilities)
    serverconfig.setup({
        init_options = {
            -- Use prettier
            provideFormatter = false,
        },
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

local function setup_lsp_sumneko_lua(serverconfig, on_attach, capabilities)
    serverconfig.setup({
        settings = {
            Lua = {
                diagnostics = {
                    -- For neovim.
                    globals = { "vim" },
                    neededFileStatus = {
                        ["codestyle-check"] = "Any",
                    },
                },
                format = {
                    -- Use stylua.
                    enable = false,
                },
            },
        },
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

local function setup_lsp_any(serverconfig, on_attach, capabilities)
    serverconfig.setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

m.setup_lsp = function()
    local lsp_installer = require("nvim-lsp-installer")
    local lspconfig = require("lspconfig")
    local capabilities = m.get_capabilities()
    local on_attach = m.on_attach
    lsp_installer.setup()
    for _, server in ipairs(lsp_installer.get_installed_servers()) do
        local serverconfig = lspconfig[server.name]

        if server.name == "clangd" then
            -- c/cpp
            setup_lsp_clangd(serverconfig, on_attach)
        elseif server.name == "rust_analyzer" then
            -- rust
            setup_lsp_rust_analyzer(serverconfig, on_attach, capabilities)
        elseif server.name == "hls" then
            -- haskell
            setup_lsp_hls(serverconfig, on_attach, capabilities)
        elseif server.name == "html" then
            -- html
            setup_lsp_html(serverconfig, on_attach, capabilities)
        elseif server.name == "jsonls" then
            -- json
            setup_lsp_jsonls(serverconfig, on_attach, capabilities)
        elseif server.name == "sumneko_lua" then
            -- lua
            setup_lsp_sumneko_lua(serverconfig, on_attach, capabilities)
        else
            setup_lsp_any(serverconfig, on_attach, capabilities)
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
    -- Key mappings by default.
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
        -- Auto closing.
        auto_close = true,
        -- Use the same symbol as the lsp client.
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

-- Find definitions and references of identifier on cursor (workspace target).
vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true, noremap = true })
-- code action.
vim.keymap.set("n", "<space>a", "<cmd>Lspsaga code_action<CR>", { silent = true, noremap = true })
-- range code action.
vim.keymap.set("x", "<space>a", ":<C-u>Lspsaga range_code_action<CR>", { silent = true, noremap = true })
-- Show doc.
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true, noremap = true })
-- Scroll.
vim.cmd([[nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>]])
vim.cmd([[nnoremap <silent> <C-d> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>]])
-- Show doc of arguments of method.
vim.keymap.set("n", "<C-k>", "<cmd>Lspsaga signature_help<CR>", { silent = true, noremap = true })
-- Rename identifier on cursor.
vim.keymap.set("n", "<space>r", "<cmd>Lspsaga rename<CR>", { silent = true, noremap = true })
-- Preview definition of identifier on cursor.
vim.keymap.set("n", "<space>d", "<cmd>Lspsaga preview_definition<CR>", { silent = true, noremap = true })
-- Show diagnostics of current line.
vim.keymap.set("n", "<space>e", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true, noremap = true })
-- Show diagnostics of identifier on cursor.
vim.keymap.set(
    "n",
    "<space>E",
    [[<cmd>lua require('lspsaga.diagnostic').show_cursor_diagnostics()<CR>]],
    { silent = true, noremap = true }
)
-- Jump next/prev diagnostic.
vim.keymap.set("n", "<space>n", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<space>p", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true, noremap = true })
-- Open/Close a terminal (floating window).
vim.keymap.set("n", "<M-f>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true, noremap = true })
vim.cmd([[tnoremap <silent> <M-f> <C-\><C-n>:Lspsaga close_floaterm<CR>]])
-- Open a trouble window (previous mode, default workspace).
vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<CR>", { silent = true, noremap = true })
-- Open a trouble window (workspace target).
vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<CR>", { silent = true, noremap = true })
-- Open a trouble window (currently opened document target).
vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<CR>", { silent = true, noremap = true })
-- Open references of identifier on cursor in the trouble window.
vim.api.nvim_set_keymap("n", "gr", "<cmd>Trouble lsp_references<CR>", { silent = true, noremap = true })

return m
