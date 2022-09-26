local m = {}

m.setup = function(use)
    -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
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
            if client.name == "jdt.ls" then
                -- jdt.ls in ftplugin/java.lua
                -- java use google-java-format
                return false
            elseif client.name == "tsserver" then
                -- javascript/typescript use prettier
                return false
            elseif client.name == "sumneko_lua" then
                -- lua use stylua
                return false
            elseif client.name == "lemminx" then
                -- xml use tidy
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
            -- NOTE: There is also a lsp version, but still under development.
            null_ls.builtins.code_actions.eslint.with({
                prefer_local = "node_modules/.bin",
                condition = function(utils)
                    return utils.root_has_file({
                        ".eslintrc.js",
                        ".eslintrc.cjs",
                        ".eslintrc.yaml",
                        ".eslintrc.yml",
                        ".eslintrc.json",
                    })
                end,
            }),

            -- for bash
            -- be used by bashls
            -- null_ls.builtins.code_actions.shellcheck,

            -- diagnostics

            -- for spell
            null_ls.builtins.diagnostics.codespell,

            -- for c/cpp
            null_ls.builtins.diagnostics.cppcheck,

            -- for editorconfig
            null_ls.builtins.diagnostics.editorconfig_checker,

            -- for eruby
            null_ls.builtins.diagnostics.erb_lint,

            -- for javascript/typescript/react/vue
            -- NOTE: There is also a lsp version, but still under development.
            null_ls.builtins.diagnostics.eslint.with({
                prefer_local = "node_modules/.bin",
                condition = function(utils)
                    return utils.root_has_file({
                        ".eslintrc.js",
                        ".eslintrc.cjs",
                        ".eslintrc.yaml",
                        ".eslintrc.yml",
                        ".eslintrc.json",
                    })
                end,
            }),

            -- for python
            null_ls.builtins.diagnostics.flake8.with({
                prefer_local = ".venv/bin",
            }),

            -- for go
            -- use lsp version
            -- null_ls.builtins.diagnostics.golangci_lint,

            -- for dockerfile
            null_ls.builtins.diagnostics.hadolint,

            -- for json
            null_ls.builtins.diagnostics.jsonlint.with({
                prefer_local = "node_modules/.bin",
            }),

            -- for kotlin
            null_ls.builtins.diagnostics.ktlint,

            -- for lua
            null_ls.builtins.diagnostics.luacheck.with({
                -- for vim
                extra_args = { "--globals vim" },
            }),

            -- for markdown
            null_ls.builtins.diagnostics.markdownlint.with({
                prefer_local = "node_modules/.bin",
            }),

            -- for php
            null_ls.builtins.diagnostics.php,

            -- for ruby
            -- be used by solargraph
            -- null_ls.builtins.diagnostics.rubocop,

            -- for bash
            -- be used by bashls
            -- null_ls.builtins.diagnostics.shellcheck,

            -- for css
            -- NOTE: If switch to the lsp version eslint, should also switch to the lsp version stylelint.
            null_ls.builtins.diagnostics.stylelint.with({
                prefer_local = "node_modules/.bin",
                condition = function(utils)
                    return utils.root_has_file({
                        ".stylelint.config.js",
                        ".stylelint.config.cjs",
                        ".stylelintrc",
                        ".stylelintrc.js",
                        ".stylelintrc.yaml",
                        ".stylelintrc.yml",
                        ".stylelintrc.json",
                    })
                end,
            }),

            -- for sql
            null_ls.builtins.diagnostics.sqlfluff.with({
                extra_args = { "--dialect", "postgres" },
            }),

            -- for html/xml
            null_ls.builtins.diagnostics.tidy,

            -- for typescript/react
            -- use tsserver
            -- null_ls.builtins.diagnostics.tsc.with({
            -- 	   prefer_local = "node_modules/.bin",
            -- }),

            -- for yaml
            null_ls.builtins.diagnostics.yamllint,

            -- for zsh
            null_ls.builtins.diagnostics.zsh,

            -- formatting

            -- for python
            null_ls.builtins.formatting.black.with({
                prefer_local = ".venv/bin",
            }),

            -- for c/cpp/cs/java
            -- cs/java use formatter of ominisharp/jdtls
            null_ls.builtins.formatting.clang_format.with({
                disabled_filetypes = { "cs", "java" },
            }),

            -- for dart
            -- be used by dartls
            -- null_ls.builtins.formatting.dart_format,

            -- for eruby
            null_ls.builtins.formatting.erb_lint,

            -- for haskell
            -- be used by hls
            -- null_ls.builtins.formatting.fourmolu,

            -- for go
            -- be used by gopls
            -- null_ls.builtins.formatting.gofmt,

            -- for java
            null_ls.builtins.formatting.google_java_format,

            -- for python
            null_ls.builtins.formatting.isort.with({
                prefer_local = ".venv/bin",
            }),

            -- for kotlin
            -- be used by kotlin-language-server
            -- null_ls.builtins.formatting.ktlint,

            -- for php
            null_ls.builtins.formatting.phpcsfixer,

            -- for html/css/sass/javascript/typescript/react/vue/json/yaml/markdown/graphql
            null_ls.builtins.formatting.prettier.with({
                prefer_local = "node_modules/.bin",
            }),

            -- for ruby
            -- be used by solargraph
            -- null_ls.builtins.formatting.rubocop,

            -- for rust
            -- be used by rust_analyzer
            -- null_ls.builtins.formatting.rustfmt,

            -- for bash
            null_ls.builtins.formatting.shfmt,

            -- for sql
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
            -- html use prettier
            null_ls.builtins.formatting.tidy.with({
                disabled_filetypes = { "html" },
            }),

            null_ls.builtins.formatting.trim_whitespace,
        },
    })
end

return m
