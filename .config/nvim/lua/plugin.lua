-- プラグイン読込
vim.cmd([[packadd packer.nvim]])
require("packer").startup(function(use)
    -- プラグインマネージャ
    use({
        "wbthomason/packer.nvim", -- lua製プラグインマネージャ
        opt = true,
    })

    -- ライブラリ
    require("plugins/lib").setup(use)

    -- 通知
    require("plugins/notify").setup(use)

    -- カラースキーム
    require("plugins/colorscheme").setup(use)

    -- lsp
    require("plugins/lsp").setup(use)

    -- linter/formatter
    require("plugins/null-ls").setup(use)

    -- lsp/スニペット補完
    require("plugins/completion").setup(use)

    -- ファジーファインダー
    require("plugins/fzf").setup(use)

    -- treesitter
    require("plugins/treesitter").setup(use)

    -- ステータスライン
    use({
        "nvim-lualine/lualine.nvim", -- lua製のステータスライン
        requires = {
            "kyazdani42/nvim-web-devicons",
            opt = true,
        },
        config = function()
            local gps = require("nvim-gps")
            require("lualine").setup({
                options = {
                    theme = "nightfox",
                },
                sections = {
                    lualine_a = {
                        "mode",
                    },
                    lualine_b = {
                        "branch",
                        "diff",
                        "diagnostics",
                    },
                    lualine_c = {
                        "filename",
                        { gps.get_location, cond = gps.is_available },
                    },
                    lualine_x = {
                        "encoding",
                        "fileformat",
                        "filetype",
                    },
                    lualine_y = {
                        "progress",
                    },
                    lualine_z = {
                        "location",
                    },
                },
            })
        end,
    })
    use({
        "SmiteshP/nvim-gps", -- ステータスバーにカーソル位置のコンテキストを表示
        requires = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            require("nvim-gps").setup()
        end,
    })

    -- バッファライン
    use({
        "akinsho/bufferline.nvim", -- バッファをタブ表示
        tag = "v2.*",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("bufferline").setup({
                options = {
                    numbers = "both",
                    diagnostics = "nvim_lsp",
                    show_buffer_close_icons = false,
                    show_close_icon = false,
                },
            })
        end,
    })

    vim.api.nvim_set_keymap("n", "<leader>n", "<Cmd>BufferLineCycleNext<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>p", "<Cmd>BufferLineCyclePrev<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>N", "<Cmd>BufferLineMoveNext<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>P", "<Cmd>BufferLineMovePrev<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>E", "<Cmd>BufferLineSortByExtension<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>D", "<Cmd>BufferLineSortByDirectory<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<Leader>b", "<Cmd>BufferLinePick<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<Leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<Leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<Leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<Leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<Leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<Leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<Leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<Leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<Leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<Leader>q", "<Cmd>BufferLinePickClose<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<Leader>L", "<Cmd>BufferLineCloseLeft<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<Leader>R", "<Cmd>BufferLineCloseRight<CR>", { noremap = true, silent = true })

    -- サイドバー
    use({
        "sidebar-nvim/sidebar.nvim", -- 色々な情報を出すサイドバー(ファイラと違って隠しファイルも表示する設定にしてある)
        config = function()
            require("sidebar-nvim").setup({
                disable_default_keybindings = 0,
                bindings = {
                    ["q"] = function()
                        require("sidebar-nvim").close() -- qで閉じる
                    end,
                },
                open = false,
                side = "right",
                initial_width = 40,
                hide_statusline = false,
                update_interval = 1000,
                sections = {
                    "datetime",
                    "containers",
                    "git",
                    "diagnostics",
                    "todos",
                    "symbols",
                    "buffers",
                    "files",
                },
                section_separator = "------------------------------",
                datetime = {
                    icon = "",
                    format = "%b %d日 (%a) %H:%M",
                    clocks = { { name = "local" } },
                },
                ["git"] = {
                    icon = "",
                },
                ["diagnostics"] = {
                    icon = "",
                },
                todos = {
                    icon = "",
                    ignored_paths = { "~" },
                    initially_closed = false,
                },
                containers = {
                    icon = "",
                    use_podman = false,
                    attach_shell = "/bin/bash",
                    show_all = true,
                    interval = 5000,
                },
                buffers = {
                    icon = "",
                    ignored_buffers = {},
                    sorting = "id",
                    show_numbers = true,
                },
                files = {
                    icon = "",
                    show_hidden = true,
                    ignored_paths = { "%.git$" },
                },
                symbols = {
                    icon = "ƒ",
                },
            })
        end,
    })

    vim.api.nvim_set_keymap("n", "gs", "<Cmd>SidebarNvimToggle<CR>", { noremap = true, silent = true })

    -- ファイラ
    -- neo-treeのレガシーコマンドは使用しない
    vim.g.neo_tree_remove_legacy_commands = 1
    use({
        "nvim-neo-tree/neo-tree.nvim", -- 軽くて安定したlua製ファイラ(隠しファイルを表示する場合はサイドバーを使用)
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require("neo-tree").setup()
        end,
    })

    -- xは特に意味はないが公式キーマップ((s)idebarの下の段)
    vim.keymap.set("n", "gx", "<Cmd>Neotree reveal toggle <CR>", { noremap = true, silent = true })

    -- スクロールバー
    use({
        "petertriho/nvim-scrollbar", -- スクロールバーを表示(nvim-hlslensと連携してスクロールバーにハイライト表示)
        config = function()
            require("scrollbar.handlers.search").setup()
            require("scrollbar").setup({
                handlers = {
                    diagnostic = true,
                    search = true,
                },
            })
        end,
    })

    -- スタート画面
    use({
        "goolord/alpha-nvim", -- スタート画面に履歴等表示
        requires = {
            "kyazdani42/nvim-web-devicons",
        },
        config = function()
            require("alpha").setup(require("alpha.themes.startify").config)
        end,
    })

    -- ターミナル
    use({
        "akinsho/toggleterm.nvim", -- ターミナルをウィンドウ表示(floatingはlspsagaのほうを使用, ターミナルの停止は<C-\><C-n>)
        tag = "v1.*",
        config = function()
            require("toggleterm").setup()
        end,
    })
    vim.keymap.set("n", "<M-t>", "<cmd>ToggleTerm<CR>", { silent = true, noremap = true })

    -- ヘルプ
    use({
        "folke/which-key.nvim", -- キーを一覧表示(`or'でマーク, "(normal)or<C-r>(insert)でレジスタ, <leader>kでキー)
        config = function()
            require("which-key").setup()
        end,
    })

    vim.api.nvim_set_keymap("n", "<leader>k", "<Cmd>WhichKey<CR>", { noremap = true, silent = true }) -- (k)ey

    -- ハイライト
    use({
        "norcalli/nvim-colorizer.lua", -- 色コードや名称をカラー表示
        config = function()
            require("colorizer").setup()
        end,
    })
    use({
        "folke/todo-comments.nvim", -- todo系コメントハイライトとtrouble, telecopeに表示(タグについては see:github)
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup()
        end,
    })
    use("myusuf3/numbers.vim") -- insertモード時は絶対行にする(vimscript)
    use({
        "lukas-reineke/indent-blankline.nvim", -- インデントを見やすく表示
        config = function()
            require("indent_blankline").setup({
                space_char_blankline = " ",
                show_current_context = true, -- treesitterベースでスコープを表示
                show_current_context_start = false, -- アンダースコア表示はしない
            })
        end,
    })

    vim.api.nvim_set_keymap("n", "<Leader>xt", "<cmd>TodoTrouble<CR>", { noremap = true })
    vim.api.nvim_set_keymap("n", "<Leader>ft", "<cmd>TodoTelescope<CR>", { noremap = true })

    -- 移動
    -- quick-scopeのキー設定
    vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
    use({
        "phaazon/hop.nvim", -- ラベルジャンプ(EasyMotion風)
        config = function()
            require("hop").setup()
        end,
    })
    use("unblevable/quick-scope") -- 1行内ラベルジャンプ(キーバインドはvariables.luaで定義, vimscript)
    -- camelcasemotionのキー設定(<leader> + w, b, e, ge)
    vim.g.camelcasemotion_key = "<leader>"
    use("bkad/CamelCaseMotion") -- キャメルケースの移動(キーバインドはvariables.luaで定義, vimscript)

    vim.api.nvim_set_keymap("n", "<leader>m", [[<cmd>lua require('hop').hint_words()<CR>]], {}) -- motion
    vim.api.nvim_set_keymap("x", "<leader>m", [[<cmd>lua require('hop').hint_words()<CR>]], {}) -- motion

    -- 編集
    use("machakann/vim-sandwich") -- クォートなどでサンドイッチされたテキストの編集(キーバインドは標準(標準コマンドの拡張あり) see:github, vimscript)

    -- レジスタ
    use({
        -- レジスタを共有できtelescope可(insert modeではselect以外<C->: <CR> select, p paste, k paste-behind, q replay-macro, d delete)
        "AckslD/nvim-neoclip.lua",
        requires = {
            { "tami5/sqlite.lua", module = "sqlite" },
            { "nvim-telescope/telescope.nvim" },
        },
        config = function()
            require("neoclip").setup({
                enable_persistent_history = true,
            })
            require("telescope").load_extension("neoclip")
        end,
    })

    vim.api.nvim_set_keymap("n", "<leader>fr", "<Cmd>Telescope neoclip<CR>", { noremap = true, silent = true })

    -- 検索
    use("kevinhwang91/nvim-hlslens") -- 検索時にカーソルの隣にマッチ情報表示(nvim-scrollbarと連携してスクロールバーにハイライト表示)

    local hlslens_opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap(
        "n",
        "n",
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        hlslens_opts
    ) -- 標準コマンド拡張(順方向に再検索)
    vim.api.nvim_set_keymap(
        "n",
        "N",
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        hlslens_opts
    ) -- 標準コマンド拡張(逆方向に再検索)
    vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], hlslens_opts)
    vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], hlslens_opts)
    vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], hlslens_opts)
    vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], hlslens_opts)
    vim.api.nvim_set_keymap("n", "<Leader>h", ":noh<CR>", hlslens_opts) -- 標準コマンド実行(ハイライトを消す)

    -- コメント
    use({
        -- コメンティング(nvim-ts-context-commentstringを使用(treesitter), キーバインドは標準(標準コマンド拡張あり) see:github)
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup({
                pre_hook = function()
                    return require("ts_context_commentstring.internal").calculate_commentstring()
                end,
                post_hook = nil,
            })
        end,
    })

    -- 括弧
    use({
        "windwp/nvim-autopairs", -- 括弧を自動で閉じてくれる
        config = function()
            require("nvim-autopairs").setup({
                map_cr = false,
            })
        end,
    })

    -- テスト
    use({
        "michaelb/sniprun", -- 部分実行できるコードランナー
        run = "bash ./install.sh",
        config = function()
            require("sniprun").setup()
        end,
    })

    vim.api.nvim_set_keymap(
        "n",
        "<leader>rr",
        [[<Cmd>lua require('sniprun').run()<CR>]],
        { noremap = true, silent = true }
    ) -- runner run
    vim.api.nvim_set_keymap(
        "x",
        "<leader>rr",
        [[<Cmd>lua require('sniprun').run('v')<CR>]],
        { noremap = true, silent = true }
    ) -- runner run
    vim.api.nvim_set_keymap(
        "n",
        "<leader>rd",
        [[<Cmd>lua require('sniprun').reset()<CR>]],
        { noremap = true, silent = true }
    ) -- runner delete
    vim.api.nvim_set_keymap(
        "n",
        "<leader>rc",
        [[<Cmd>lua require('sniprun.display').close_all()<CR>]],
        { noremap = true, silent = true }
    ) -- runner close

    -- git
    use({
        "TimUntersberger/neogit", -- gitクライアント(dでdiffviewが起動できる)
        requires = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("neogit").setup({
                disable_commit_confirmation = true,
                kind = "tab",
                commit_popup = {
                    kind = "split",
                },
                integrations = {
                    diffview = true,
                },
            })
        end,
    })
    use({
        "sindrets/diffview.nvim", -- git diff(キーバインドは標準 see: github)
        requires = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("diffview").setup()
        end,
    })

    vim.api.nvim_set_keymap("n", "<leader><leader>gg", "<Cmd>Neogit<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader><leader>gd", "<Cmd>DiffviewOpen<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap(
        "n",
        "<leader><leader>gh",
        "<Cmd>DiffviewFileHistory<CR>",
        { noremap = true, silent = true }
    )

    use({
        "lewis6991/gitsigns.nvim", -- gitの状態をカラムにサイン表示
        config = function()
            require("gitsigns").setup({
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map("n", "]h", function()
                        if vim.wo.diff then
                            return "]h"
                        end
                        vim.schedule(function()
                            gs.next_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true })

                    map("n", "[h", function()
                        if vim.wo.diff then
                            return "[h"
                        end
                        vim.schedule(function()
                            gs.prev_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true })

                    -- Actions
                    map({ "n", "v" }, "<leader><leader>gs", ":Gitsigns stage_hunk<CR>")
                    map({ "n", "v" }, "<leader><leader>gr", ":Gitsigns reset_hunk<CR>")
                    map("n", "<leader><leader>gS", gs.stage_buffer)
                    map("n", "<leader><leader>gu", gs.undo_stage_hunk)
                    map("n", "<leader><leader>gR", gs.reset_buffer)
                    map("n", "<leader><leader>gg", gs.preview_hunk)
                    map("n", "<leader><leader>gb", function()
                        gs.blame_line({ full = true })
                    end)
                    map("n", "<leader><leader>gB", gs.toggle_current_line_blame)
                    -- map("n", "<leader><leader>gd", gs.diffthis) diffview
                    -- map("n", "<leader><leader>gD", function()
                    -- 	   gs.diffthis("~")
                    -- end) diffview
                    map("n", "<leader><leader>gD", gs.toggle_deleted)

                    -- Text object
                    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
                end,
            })
        end,
    })

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
    local dap_ext_vscode = require('dap.ext.vscode')
    dap_ext_vscode.load_launchjs('.vscode/launch.json') -- vscodeと違って標準JSONなので末尾のコンマはエラーになる点に注意

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
