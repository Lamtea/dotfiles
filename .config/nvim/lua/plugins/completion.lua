local m = {}

m.setup = function(use)
    -- A completion engine plugin for neovim written in Lua.
    -- Completion sources are installed from external repositories and "sourced".
    use("hrsh7th/nvim-cmp")
    -- nvim-cmp source for buffer words.
    use("hrsh7th/cmp-buffer")
    -- nvim-cmp source for filesystem paths.
    use("hrsh7th/cmp-path")
    -- nvim-cmp source for vim's cmdline.
    use("hrsh7th/cmp-cmdline")
    -- nvim-cmp source for displaying function signatures with the current parameter emphasized.
    use("hrsh7th/cmp-nvim-lsp-signature-help")
    -- nvim-cmp source for textDocument/documentSymbol via nvim-lsp.
    -- The purpose is the demonstration customize / search by nvim-cmp.
    use("hrsh7th/cmp-nvim-lsp-document-symbol")
    -- nvim-cmp source for neovim Lua API.
    use("hrsh7th/cmp-nvim-lua")
    -- nvim-cmp source for emojis.
    use("hrsh7th/cmp-emoji")
    -- This tiny plugin adds vscode-like pictograms to neovim built-in lsp.
    use("onsails/lspkind-nvim")
    -- VSCode(LSP)'s snippet feature in vim.
    use("hrsh7th/vim-vsnip")
    -- nvim-cmp source for vim-vsnip.
    use("hrsh7th/cmp-vsnip")
    -- Snippets collection for a set of different programming languages for faster development.
    -- The only goal is to have one community driven repository for all kinds of snippets in all programming languages,
    -- this way you can have it all in one place.
    use("rafamadriz/friendly-snippets")

    -- For completion.
    vim.g.completeopt = "menu,menuone,noselect"

    m.setup_lspkind()
    m.setup_cmp()
end

m.setup_lspkind = function()
    require("lspkind").init({
        mode = "symbol_text",
        preset = "codicons",
        symbol_map = {
            Text = "",
            Method = "",
            Function = "",
            Constructor = "",
            Field = "ﰠ",
            Variable = "",
            Class = "ﴯ",
            Interface = "",
            Module = "",
            Property = "ﰠ",
            Unit = "塞",
            Value = "",
            Enum = "",
            Keyword = "",
            Snippet = "",
            Color = "",
            File = "",
            Reference = "",
            Folder = "",
            EnumMember = "",
            Constant = "",
            Struct = "פּ",
            Event = "",
            Operator = "",
            TypeParameter = "",
        },
    })
end

m.setup_cmp = function()
    local lspkind = require("lspkind")
    local cmp = require("cmp")
    cmp.setup({
        formatting = {
            format = lspkind.cmp_format({
                mode = "symbol",
                maxwidth = 100,
                before = function(_, vim_item)
                    return vim_item
                end,
            }),
        },
        snippet = {
            expand = function(args)
                -- For vscode snippet.
                vim.fn["vsnip#anonymous"](args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            -- <C-b> is tmux key binding.
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.close(),
            ["<CR>"] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            }),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.ConfirmBehavior.Select })
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.ConfirmBehavior.Select })
                else
                    fallback()
                end
            end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "vsnip" },
            { name = "path" },
            { name = "emoji", insert = true },
            { name = "nvim-lua" },
            { name = "nvim_lsp_signature_help" },
        }, {
            { name = "buffer" },
        }),
    })

    cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = "nvim_lsp_document_symbol" },
        }, {
            { name = "buffer" },
        }),
    })

    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = "path" },
        }, {
            { name = "cmdline" },
        }),
    })
end

return m
