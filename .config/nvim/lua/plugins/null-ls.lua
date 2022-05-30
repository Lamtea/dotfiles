local m = {}

m.setup = function(use)
    -- LSP用linter, formatter(各種linter, 各種formatter必須 see: setup)
    use({
        "jose-elias-alvarez/null-ls.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
        },
    })

    m.setup_null_ls()
end

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            -- javascript/typescriptはprettierを使用
            if client.name == "tsserver" then
                return false
            end
            -- luaはstyluaを使用
            if client.name == "sumneko_lua" then
                return false
            end
            -- xmlはtidyを使用
            if client.name == "lemminx" then
                return false
            end

            return true
        end,
        bufnr = bufnr,
    })
end

local on_attach = function(client, bufnr)
    local null_ls_augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = null_ls_augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = null_ls_augroup,
            buffer = bufnr,
            callback = function()
                lsp_formatting(bufnr)
            end,
        })
    end
end

m.setup_null_ls = function()
    local null_ls = require("null-ls")
    null_ls.setup({
        on_attach = on_attach,
        sources = {
            -- code action

            -- for javascript/typescript/react/vue
            -- NOTE: lsp版を使用しない理由はdiagnostics.eslint_d参照
            null_ls.builtins.code_actions.eslint_d.with({
                prefer_local = "node_modules/.bin",
            }),

            -- for bash
            -- 使用しない理由はdiagnostics.shellcheck参照
            -- null_ls.builtins.code_actions.shellcheck,

            -- diagnostics

            -- for spell
            null_ls.builtins.diagnostics.codespell,

            -- for c/cpp
            null_ls.builtins.diagnostics.cppcheck,

            -- for editorconfig
            null_ls.builtins.diagnostics.editorconfig_checker.with({
                prefer_local = "node_modules/.bin",
            }),

            -- for eruby
            null_ls.builtins.diagnostics.erb_lint,

            -- for javascript/typescript/react/vue
            -- NOTE: eslint-lspもあるがまだ開発中
            null_ls.builtins.diagnostics.eslint_d.with({
                prefer_local = "node_modules/.bin",
            }),

            -- for python
            null_ls.builtins.diagnostics.flake8.with({
                prefer_local = ".venv/bin",
            }),

            -- for go
            -- lsp版を使用する
            -- null_ls.builtins.diagnostics.golangci_lint,

            -- for dockerfile
            null_ls.builtins.diagnostics.hadolint,

            -- for json
            null_ls.builtins.diagnostics.jsonlint.with({
                prefer_local = "node_modules/.bin",
            }),

            -- kotlin
            null_ls.builtins.diagnostics.ktlint,

            -- for lua
            null_ls.builtins.diagnostics.luacheck.with({
                -- vimのグローバルオブジェクト警告のため
                extra_args = { "--globals vim" },
            }),

            -- for markdown
            null_ls.builtins.diagnostics.markdownlint.with({
                prefer_local = "node_modules/.bin",
            }),

            -- for php
            null_ls.builtins.diagnostics.php,

            -- for ruby
            -- solargraphで使用される
            -- null_ls.builtins.diagnostics.rubocop,

            -- for bash
            -- bashlsで使用される
            -- null_ls.builtins.diagnostics.shellcheck,

            -- for css
            -- NOTE: eslint-lsp(まだ開発中)に切り替えるなら合わせてstylelint-lspにしたほうが良い
            null_ls.builtins.diagnostics.stylelint.with({
                prefer_local = "node_modules/.bin",
            }),

            -- for sql
            -- NOTE: sqlsを使用しない理由はformatting.sqlfluff参照
            null_ls.builtins.diagnostics.sqlfluff.with({
                extra_args = { "--dialect", "postgres" },
            }),

            -- for html/xml
            null_ls.builtins.diagnostics.tidy.with({
                prefer_local = "node_modules/.bin",
            }),

            -- for typescript/react
            -- tsserverを使用する
            -- null_ls.builtins.diagnostics.tsc.with({
            -- 	   prefer_local = "node_modules/.bin",
            -- }),

            -- for yaml
            null_ls.builtins.diagnostics.yamllint.with({
                prefer_local = "node_modules/.bin",
            }),

            -- for zsh
            null_ls.builtins.diagnostics.zsh,

            -- formatting

            -- for python
            null_ls.builtins.formatting.black.with({
                prefer_local = ".venv/bin",
            }),

            -- for c/cpp/cs/java
            -- cs/javaはominisharp/jdtlsのformattingを使用する
            null_ls.builtins.formatting.clang_format.with({
                disabled_filetypes = { "cs", "java" },
            }),

            -- for dart
            -- dartlsで使用される
            -- null_ls.builtins.formatting.dart_format,

            -- for eruby
            null_ls.builtins.formatting.erb_lint,

            -- for haskell
            -- hls(stylish haskell)を使用
            -- null_ls.builtins.formatting.fourmolu,

            -- for go
            null_ls.builtins.formatting.gofmt,

            -- for python
            null_ls.builtins.formatting.isort.with({
                prefer_local = ".venv/bin",
            }),

            -- for kotlin
            null_ls.builtins.formatting.ktlint,

            -- for php
            null_ls.builtins.formatting.phpcsfixer,

            -- for html/css/sass/javascript/typescript/react/vue/json/yaml/markdown/graphql
            null_ls.builtins.formatting.prettier.with({
                prefer_local = "node_modules/.bin",
            }),

            -- for ruby
            null_ls.builtins.formatting.rubocop,

            -- for rust
            -- rust_analyzerで使用される
            -- null_ls.builtins.formatting.rustfmt,

            -- for bash
            null_ls.builtins.formatting.shfmt,

            -- for sql
            -- NOTE: db定義補完はsqlsに切替(db接続必須, まだ開発途中)
            -- デフォルトはposgresだがpwdに.sqlfluffを配置すれば設定できる
            null_ls.builtins.formatting.sqlfluff.with({
                extra_args = { "--dialect", "postgres" },
            }),

            -- for lua
            null_ls.builtins.formatting.stylua.with({
                extra_args = {
                    "--column-width",
                    "120",
                    "--line-endings",
                    "Unix",
                    "--indent-type",
                    "Spaces",
                    "--indent-width",
                    "4",
                    "--quote-style",
                    "AutoPreferDouble",
                    "--call-parentheses",
                    "Always",
                },
            }),

            -- for xml
            null_ls.builtins.formatting.tidy.with({
                prefer_local = "node_modules/.bin",
                disabled_filetypes = { "html" },
            }),

            -- 末尾の空白除去
            null_ls.builtins.formatting.trim_whitespace,
        },
    })
end

return m
