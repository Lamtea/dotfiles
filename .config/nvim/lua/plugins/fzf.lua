local m = {}

m.setup = function(use)
    -- telescope.nvim is a highly extendable fuzzy finder over lists.
    -- Built on the latest awesome features from neovim core.
    -- Telescope is centered around modularity, allowing for easy customization.
    -- Community driven builtin pickers, sorters and previewers.
    use({
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
        },
    })
    -- fzf-native is a c port of fzf.
    -- It only covers the algorithm and implements few functions to support calculating the score.
    use({
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && "
            .. "cmake --build build --config Release && "
            .. "cmake --install build --prefix build",
    })
    -- It sets vim.ui.select to telescope.
    -- That means for example that neovim core stuff can fill the telescope picker.
    -- Example would be lua vim.lsp.buf.code_action().
    use("nvim-telescope/telescope-ui-select.nvim")

    m.setup_telescope()
end

m.setup_telescope = function()
    -- Key mappings by default.
    -- <C-n>/<Down>	Next item
    -- <C-p>/<Up>	Previous item
    -- j/k	        Next/previous (in normal mode)
    -- H/M/L	    	Select High/Middle/Low (in normal mode)
    -- 'gg/G'	     	Select the first/last item (in normal mode)
    -- <CR>	        Confirm selection
    -- <C-x>	     	Go to file selection as a split
    -- <C-v>	    	Go to file selection as a vsplit
    -- <C-t>	    	Go to a file in a new tab
    -- <C-u>	    	Scroll up in preview window
    -- <C-d>	    	Scroll down in preview window
    -- <C-/>	    	Show mappings for picker actions (insert mode)
    -- ?	        Show mappings for picker actions (normal mode)
    -- <C-c>	    	Close telescope
    -- <Esc>	    	Close telescope (in normal mode)
    -- <Tab>	    	Toggle selection and move to next selection
    -- <S-Tab>	    	Toggle selection and move to prev selection
    -- <C-q>	    	Send all items not filtered to quickfixlist (qflist)
    -- <M-q>	    	Send all selected items to qflist
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
    require("telescope").load_extension("notify")
    require("telescope").load_extension("ui-select")
    require("telescope").load_extension("flutter")
end

-- telescope builtin picker.
vim.api.nvim_set_keymap("n", "<leader>fp", [[<cmd>lua require('telescope.builtin').builtin()<CR>]], { noremap = true })
-- Find files.
vim.api.nvim_set_keymap(
    "n",
    "<leader>ff",
    [[<cmd>lua require('telescope.builtin').find_files()<CR>]],
    { noremap = true }
)
-- Find histories.
vim.api.nvim_set_keymap("n", "<leader>fF", [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true })
-- grep the word on cursor.
vim.api.nvim_set_keymap(
    "n",
    -- find string
    "<leader>fs",
    [[<cmd>lua require('telescope.builtin').grep_string()<CR>]],
    { noremap = true }
)
-- live grep.
vim.api.nvim_set_keymap(
    "n",
    "<leader>fg",
    [[<cmd>lua require('telescope.builtin').live_grep()<CR>]],
    { noremap = true }
)
-- Find search histories.
vim.api.nvim_set_keymap(
    "n",
    "<leader>fS",
    [[<cmd>lua require('telescope.builtin').search_history()<CR>]],
    { noremap = true }
)
-- Find buffers.
vim.api.nvim_set_keymap("n", "<leader>fb", [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true })
-- live grep on the currently selected buffer.
vim.api.nvim_set_keymap(
    "n",
    "<leader>fB",
    [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]],
    { noremap = true }
)
-- Find commands.
vim.api.nvim_set_keymap("n", "<leader>fc", [[<cmd>lua require('telescope.builtin').commands()<CR>]], { noremap = true })
-- Find command histries.
vim.api.nvim_set_keymap(
    "n",
    "<leader>fC",
    [[<cmd>lua require('telescope.builtin').command_history()<CR>]],
    { noremap = true }
)
-- Find registers.
vim.api.nvim_set_keymap(
    "n",
    "<leader>fR",
    [[<cmd>lua require('telescope.builtin').registers()<CR>]],
    { noremap = true }
)
-- Find word spell on cursor.
vim.api.nvim_set_keymap(
    "n",
    -- find word
    "<leader>fw",
    [[<cmd>lua require('telescope.builtin').spell_suggest()<CR>]],
    { noremap = true }
)
-- Find quickfix.
vim.api.nvim_set_keymap("n", "<leader>fq", [[<cmd>lua require('telescope.builtin').quickfix()<CR>]], { noremap = true })
-- Find quickfix histories.
vim.api.nvim_set_keymap(
    "n",
    "<leader>fQ",
    [[<cmd>lua require('telescope.builtin').quickfixhistory()<CR>]],
    { noremap = true }
)
-- Find loclist.
vim.api.nvim_set_keymap("n", "<leader>fl", [[<cmd>lua require('telescope.builtin').loclist()<CR>]], { noremap = true })
-- Find marks.
vim.api.nvim_set_keymap("n", "<leader>fm", [[<cmd>lua require('telescope.builtin').marks()<CR>]], { noremap = true })
-- Find jumplist.
vim.api.nvim_set_keymap("n", "<leader>fj", [[<cmd>lua require('telescope.builtin').jumplist()<CR>]], { noremap = true })
-- Find man pages.
vim.api.nvim_set_keymap(
    "n",
    -- find help
    "<leader>fh",
    [[<cmd>lua require('telescope.builtin').man_pages()<CR>]],
    { noremap = true }
)
-- Find normal mode key mappings.
vim.api.nvim_set_keymap("n", "<leader>fk", [[<cmd>lua require('telescope.builtin').keymaps()<CR>]], { noremap = true })
-- Find vim options.
vim.api.nvim_set_keymap(
    "n",
    "<leader>fv",
    [[<cmd>lua require('telescope.builtin').vim_options()<CR>]],
    { noremap = true }
)
-- Find auto commands.
vim.api.nvim_set_keymap(
    "n",
    "<leader>fa",
    [[<cmd>lua require('telescope.builtin').autocommands()<CR>]],
    { noremap = true }
)
-- Find filetypes.
vim.api.nvim_set_keymap(
    "n",
    -- find type
    "<leader>ft",
    [[<cmd>lua require('telescope.builtin').filetypes()<CR>]],
    { noremap = true }
)
-- Find color schemes.
vim.api.nvim_set_keymap(
    "n",
    -- find theme
    "<leader>fT",
    [[<cmd>lua require('telescope.builtin').colorscheme()<CR>]],
    { noremap = true }
)
-- Find highlights.
vim.api.nvim_set_keymap(
    "n",
    "<leader>fH",
    [[<cmd>lua require('telescope.builtin').highlights()<CR>]],
    { noremap = true }
)
-- Find syntax nodes.
vim.api.nvim_set_keymap(
    "n",
    -- find node
    "<leader>fn",
    [[<cmd>lua require('telescope.builtin').treesitter()<CR>]],
    { noremap = true }
)
-- git branch.
vim.api.nvim_set_keymap(
    "n",
    "<leader>gb",
    [[<cmd>lua require('telescope.builtin').git_branches()<CR>]],
    { noremap = true }
)
-- git commit on the currently opened document.
vim.api.nvim_set_keymap(
    "n",
    "<leader>gc",
    [[<cmd>lua require('telescope.builtin').git_commits()<CR>]],
    { noremap = true }
)
-- git commit on the opened buffers.
vim.api.nvim_set_keymap(
    "n",
    "<leader>gC",
    [[<cmd>lua require('telescope.builtin').git_bcommits()<CR>]],
    { noremap = true }
)
-- git file.
vim.api.nvim_set_keymap(
    "n",
    "<leader>gf",
    [[<cmd>lua require('telescope.builtin').git_files()<CR>]],
    { noremap = true }
)
-- git status.
vim.api.nvim_set_keymap(
    "n",
    "<leader>gg",
    [[<cmd>lua require('telescope.builtin').git_status()<CR>]],
    { noremap = true }
)
-- git stash.
vim.api.nvim_set_keymap(
    "n",
    "<leader>gs",
    [[<cmd>lua require('telescope.builtin').git_stash()<CR>]],
    { noremap = true }
)
-- Find definitions of the identifier on cursor (move when there is only one).
vim.api.nvim_set_keymap(
    "n",
    "<leader>ld",
    [[<cmd>lua require('telescope.builtin').lsp_definitions()<CR>]],
    { noremap = true }
)
-- Find type definitions of the identifier on cursor (move when there is only one).
vim.api.nvim_set_keymap(
    "n",
    "<leader>lt",
    [[<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>]],
    { noremap = true }
)
-- Find implementations of the identifier on cursor (move when there is only one).
vim.api.nvim_set_keymap(
    "n",
    "<leader>li",
    [[<cmd>lua require('telescope.builtin').lsp_implementations()<CR>]],
    { noremap = true }
)
-- Find references of the identifier on cursor.
vim.api.nvim_set_keymap(
    "n",
    "<leader>lr",
    [[<cmd>lua require('telescope.builtin').lsp_references()<CR>]],
    { noremap = true }
)
-- Find symbols on the currently selected document.
vim.api.nvim_set_keymap(
    "n",
    "<leader>ls",
    [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]],
    { noremap = true }
)
-- Find symbols on the workspace.
vim.api.nvim_set_keymap(
    "n",
    "<leader>lw",
    [[<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<CR>]],
    { noremap = true }
)
-- Find symbols on the workspace (dynamic).
vim.api.nvim_set_keymap(
    "n",
    "<leader>ll",
    [[<cmd>lua require('telescope.builtin').lsp_dynamic_workspace_symbols()<CR>]],
    { noremap = true }
)
-- Find diagnostics on the opened buffers.
vim.api.nvim_set_keymap(
    "n",
    "<leader>lD",
    [[<cmd>lua require('telescope.builtin').diagnostics()<CR>]],
    { noremap = true }
)

return m
