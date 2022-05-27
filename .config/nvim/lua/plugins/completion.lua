local m = {}

m.setup = function(use)
    -- 補完エンジン
    use("hrsh7th/nvim-cmp")
    -- バッファ補完用ソース
    use("hrsh7th/cmp-buffer")
    -- パス補完用ソース
    use("hrsh7th/cmp-path")
    -- コマンドライン補完用ソース
    use("hrsh7th/cmp-cmdline")
    -- 関数シグネチャ補完用ソース
    use("hrsh7th/cmp-nvim-lsp-signature-help")
    -- /検索用ソース
    use("hrsh7th/cmp-nvim-lsp-document-symbol")
    -- Lua API用ソース
    use("hrsh7th/cmp-nvim-lua")
    -- 絵文字用ソース
    use("hrsh7th/cmp-emoji")
    -- 補完にアイコン表示
    use("onsails/lspkind-nvim")
    -- vscodeスニペット(vimscript)
    use("hrsh7th/vim-vsnip")
    -- vscodeスニペット用ソース
    use("hrsh7th/cmp-vsnip")
    -- vscodeスニペット定義ファイル
    use("rafamadriz/friendly-snippets")

    -- 補完設定
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
                -- vscodeスニペット設定
                vim.fn["vsnip#anonymous"](args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            -- <C-b>はtmuxで使用されるため
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
