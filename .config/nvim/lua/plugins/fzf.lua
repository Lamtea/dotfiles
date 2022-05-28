local m = {}

m.setup = function(use)
    -- ファインダー(ripgrep推奨 see:github)
    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
        },
    })
    -- ソーター(cmake必須 see:github)
    use({
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && "
            .. "cmake --build build --config Release && "
            .. "cmake --install build --prefix build",
    })

    m.setup_telescope()
end

m.setup_telescope = function()
    -- デフォルトキーマップ
    -- <C-n>/<Down>	Next item
    -- <C-p>/<Up>	Previous item
    -- j/k	        Next/previous (in normal mode)
    -- H/M/L	    Select High/Middle/Low (in normal mode)
    -- 'gg/G'	    Select the first/last item (in normal mode)
    -- <CR>	        Confirm selection
    -- <C-x>	    Go to file selection as a split
    -- <C-v>	    Go to file selection as a vsplit
    -- <C-t>	    Go to a file in a new tab
    -- <C-u>	    Scroll up in preview window
    -- <C-d>	    Scroll down in preview window
    -- <C-/>	    Show mappings for picker actions (insert mode)
    -- ?	        Show mappings for picker actions (normal mode)
    -- <C-c>	    Close telescope
    -- <Esc>	    Close telescope (in normal mode)
    -- <Tab>	    Toggle selection and move to next selection
    -- <S-Tab>	    Toggle selection and move to prev selection
    -- <C-q>	    Send all items not filtered to quickfixlist (qflist)
    -- <M-q>	    Send all selected items to qflist
    -- troubleと連携
    local trouble = require("trouble.providers.telescope")
    require("telescope").setup({
        defaults = {
            mappings = {
                i = { ["<C-t>"] = trouble.open_with_trouble },
                n = { ["<C-t>"] = trouble.open_with_trouble },
            },
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
        },
    })
    require("telescope").load_extension("fzf")
end

-- telescope builtin picker検索
vim.api.nvim_set_keymap("n", "<leader>fp", [[<cmd>lua require('telescope.builtin').builtin()<CR>]], { noremap = true })
-- ファイル検索
vim.api.nvim_set_keymap(
    "n",
    "<leader>ff",
    [[<cmd>lua require('telescope.builtin').find_files()<CR>]],
    { noremap = true }
)
-- ファイルヒストリ検索
vim.api.nvim_set_keymap(
    "n",
    -- find history
    "<leader>fF",
    [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]],
    { noremap = true }
)
-- カーソル下の文字列をgrep
vim.api.nvim_set_keymap(
    "n",
    -- find string
    "<leader>fs",
    [[<cmd>lua require('telescope.builtin').grep_string()<CR>]],
    { noremap = true }
)
-- grep
vim.api.nvim_set_keymap(
    "n",
    "<leader>fg",
    [[<cmd>lua require('telescope.builtin').live_grep()<CR>]],
    { noremap = true }
)
-- Searchヒストリ検索
vim.api.nvim_set_keymap(
    "n",
    "<leader>fS",
    [[<cmd>lua require('telescope.builtin').search_history()<CR>]],
    { noremap = true }
)
-- バッファ検索
vim.api.nvim_set_keymap("n", "<leader>fb", [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true })
-- 現在開いているバッファ内のライブ検索
vim.api.nvim_set_keymap(
    "n",
    "<leader>fB",
    [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]],
    { noremap = true }
)
-- コマンド検索
vim.api.nvim_set_keymap("n", "<leader>fc", [[<cmd>lua require('telescope.builtin').commands()<CR>]], { noremap = true })
-- コマンドヒストリ検索
vim.api.nvim_set_keymap(
    "n",
    "<leader>fC",
    [[<cmd>lua require('telescope.builtin').command_history()<CR>]],
    { noremap = true }
)
-- レジスタ検索
vim.api.nvim_set_keymap(
    "n",
    "<leader>fR",
    [[<cmd>lua require('telescope.builtin').registers()<CR>]],
    { noremap = true }
)
-- カーソル下にある単語のスペル候補を検索
vim.api.nvim_set_keymap(
    "n",
    -- find word
    "<leader>fw",
    [[<cmd>lua require('telescope.builtin').spell_suggest()<CR>]],
    { noremap = true }
)
-- quickfix検索
vim.api.nvim_set_keymap("n", "<leader>fq", [[<cmd>lua require('telescope.builtin').quickfix()<CR>]], { noremap = true })
-- quickfixヒストリ検索
vim.api.nvim_set_keymap(
    "n",
    "<leader>fQ",
    [[<cmd>lua require('telescope.builtin').quickfixhistory()<CR>]],
    { noremap = true }
)
-- loclist検索
vim.api.nvim_set_keymap("n", "<leader>fl", [[<cmd>lua require('telescope.builtin').loclist()<CR>]], { noremap = true })
-- mark検索
vim.api.nvim_set_keymap("n", "<leader>fm", [[<cmd>lua require('telescope.builtin').marks()<CR>]], { noremap = true })
-- jump list検索
vim.api.nvim_set_keymap("n", "<leader>fj", [[<cmd>lua require('telescope.builtin').jumplist()<CR>]], { noremap = true })
-- man page検索
vim.api.nvim_set_keymap(
    "n",
    -- find help
    "<leader>fh",
    [[<cmd>lua require('telescope.builtin').man_pages()<CR>]],
    { noremap = true }
)
-- normalモードのkeymap検索
vim.api.nvim_set_keymap("n", "<leader>fk", [[<cmd>lua require('telescope.builtin').keymaps()<CR>]], { noremap = true })
-- vimオプション検索
vim.api.nvim_set_keymap(
    "n",
    "<leader>fv",
    [[<cmd>lua require('telescope.builtin').vim_options()<CR>]],
    { noremap = true }
)
-- auto commands検索
vim.api.nvim_set_keymap(
    "n",
    "<leader>fa",
    [[<cmd>lua require('telescope.builtin').autocommands()<CR>]],
    { noremap = true }
)
-- 使用可能なファイルタイプ検索
vim.api.nvim_set_keymap(
    "n",
    -- find type
    "<leader>ft",
    [[<cmd>lua require('telescope.builtin').filetypes()<CR>]],
    { noremap = true }
)
-- 使用可能なカラースキーム検索
vim.api.nvim_set_keymap(
    "n",
    -- find theme
    "<leader>fT",
    [[<cmd>lua require('telescope.builtin').colorscheme()<CR>]],
    { noremap = true }
)
-- 使用可能なハイライト検索
vim.api.nvim_set_keymap(
    "n",
    "<leader>fH",
    [[<cmd>lua require('telescope.builtin').highlights()<CR>]],
    { noremap = true }
)
-- シンタックスノード検索
vim.api.nvim_set_keymap(
    "n",
    -- find node
    "<leader>fn",
    [[<cmd>lua require('telescope.builtin').treesitter()<CR>]],
    { noremap = true }
)
-- git branch検索
vim.api.nvim_set_keymap(
    "n",
    "<leader>gb",
    [[<cmd>lua require('telescope.builtin').git_branches()<CR>]],
    { noremap = true }
)
-- 現在ドキュメントのgit commit検索
vim.api.nvim_set_keymap(
    "n",
    "<leader>gc",
    [[<cmd>lua require('telescope.builtin').git_commits()<CR>]],
    { noremap = true }
)
-- 開いているすべてのバッファのgit commit検索
vim.api.nvim_set_keymap(
    "n",
    "<leader>gC",
    [[<cmd>lua require('telescope.builtin').git_bcommits()<CR>]],
    { noremap = true }
)
-- git file検索
vim.api.nvim_set_keymap(
    "n",
    "<leader>gf",
    [[<cmd>lua require('telescope.builtin').git_files()<CR>]],
    { noremap = true }
)
-- git status検索
vim.api.nvim_set_keymap(
    "n",
    -- 一番使うのでgg
    "<leader>gg",
    [[<cmd>lua require('telescope.builtin').git_status()<CR>]],
    { noremap = true }
)
-- git stash検索
vim.api.nvim_set_keymap(
    "n",
    "<leader>gs",
    [[<cmd>lua require('telescope.builtin').git_stash()<CR>]],
    { noremap = true }
)
-- カーソル下にある識別子の定義を検索(1つしかないときは移動する)
vim.api.nvim_set_keymap(
    "n",
    "<leader>ld",
    [[<cmd>lua require('telescope.builtin').lsp_definitions()<CR>]],
    { noremap = true }
)
-- カーソル下にある識別子の型定義を検索(1つしかないときは移動する)
vim.api.nvim_set_keymap(
    "n",
    "<leader>lt",
    [[<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>]],
    { noremap = true }
)
-- カーソル下にある識別子の実装を検索(1つしかないときは移動する)
vim.api.nvim_set_keymap(
    "n",
    "<leader>li",
    [[<cmd>lua require('telescope.builtin').lsp_implementations()<CR>]],
    { noremap = true }
)
-- カーソル下にある識別子の参照を検索
vim.api.nvim_set_keymap(
    "n",
    "<leader>lr",
    [[<cmd>lua require('telescope.builtin').lsp_references()<CR>]],
    { noremap = true }
)
-- 現在ドキュメントのシンボルを検索
vim.api.nvim_set_keymap(
    "n",
    "<leader>ls",
    [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]],
    { noremap = true }
)
-- ワークスペースのシンボルを検索
vim.api.nvim_set_keymap(
    "n",
    "<leader>lw",
    [[<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>]],
    { noremap = true }
)
-- ワークスペースのシンボルを動的に検索
vim.api.nvim_set_keymap(
    "n",
    -- 一番使うのでll
    "<leader>ll",
    [[<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>]],
    { noremap = true }
)
-- 開いているすべてのバッファの診断を検索
vim.api.nvim_set_keymap(
    "n",
    "<leader>lD",
    [[<cmd>lua require('telescope.builtin').diagnostics()<CR>]],
    { noremap = true }
)

return m
