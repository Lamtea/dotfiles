local m = {}

m.setup = function(use)
    -- The goal of nvim-treesitter is both to provide a simple and easy way to use the interface for tree-sitter
    -- in Neovim and to provide some basic functionality such as highlighting based on it.
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    })
    -- Syntax aware text-objects, select, move, swap, and peek support.
    use("nvim-treesitter/nvim-treesitter-textobjects")
    -- Location and syntax aware text objects.
    use("RRethy/nvim-treesitter-textsubjects")
    -- Plugin that provides region selection using hints on the abstract syntax tree of a document.
    -- This is intended to be used for pending operator mappings.
    use("mfussenegger/nvim-ts-hint-textobject")
    -- A tiny Neovim plugin to deal with treesitter units.
    -- A unit is defined as a treesitter node including all its children.
    -- It allows you to quickly select, yank, delete or replace language-specific ranges.
    -- For inner selections, the main node under the cursor is selected. For outer selections, the next node is selected.
    use("David-Kunz/treesitter-unit")
    -- Interactively select and swap: function arguments, list elements, function parameters, and more.
    -- Powered by tree-sitter.
    use("mizlan/iswap.nvim")
    -- A Neovim plugin for setting the commentstring option based on the cursor location in the file.
    -- The location is checked via treesitter queries.
    -- This is useful when there are embedded languages in certain types of files.
    -- For example, Vue files can have many different sections, each of which can have a different style for comments.
    -- Note that this plugin only changes the commentstring setting.
    -- It does not add any mappings for commenting.
    -- It is recommended to use a commenting plugin like vim-commentary alongside this plugin.
    use("JoosepAlviste/nvim-ts-context-commentstring")
    -- match-up is a plugin that lets you highlight, navigate, and operate on sets of matching text.
    -- It extends vim's % key to language-specific words instead of just single characters.
    use("andymass/vim-matchup")
    -- Lightweight alternative to context.vim implemented with nvim-treesitter.
    use("nvim-treesitter/nvim-treesitter-context")
    -- Shows virtual text of the current context after functions, methods, statements, etc.
    use("haringsrob/nvim_context_vt")
    -- Highlight arguments' definitions and usages, asynchronously, using Treesitter.
    use({
        "m-demare/hlargs.nvim",
        requires = {
            "nvim-treesitter/nvim-treesitter",
        },
    })
    -- Rainbow parentheses for neovim using tree-sitter.
    -- This is a module for nvim-treesitter, not a standalone plugin.
    -- It requires and is configured via nvim-treesitter
    -- Should work with any language supported by nvim-treesitter.
    -- If any language is missing, please open an issue/PR.
    -- Only neovim nightly is targeted.
    use("p00f/nvim-ts-rainbow")
    -- Use treesitter to autoclose and autorename html tag.
    -- It work with html,tsx,vue,svelte,php,rescript.
    use("windwp/nvim-ts-autotag")

    m.setup_treesitter()
    m.setup_context()
    m.setup_context_vt()
    m.setup_hlargs()
    m.setup_autotag()
end

m.setup_treesitter = function()
    require("nvim-treesitter.configs").setup({
        ensure_installed = "all",
        sync_install = true,
        highlight = {
            enable = true,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<CR>",
                node_incremental = "<CR>",
                scope_incremental = "<TAB>",
                node_decremental = "<S-TAB>",
            },
        },
        indent = {
            enable = true,
        },
        textobjects = {
            select = {
                enable = true,
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                    ["aB"] = "@block.outer",
                    ["iB"] = "@block.inner",
                    ["ai"] = "@conditional.outer",
                    ["ii"] = "@conditional.inner",
                    ["al"] = "@loop.outer",
                    ["il"] = "@loop.inner",
                    ["ap"] = "@parameter.outer",
                    ["ip"] = "@parameter.inner",
                    -- ["aF"] = "@frame.outer",
                    -- ["iF"] = "@frame.inner",
                    -- ["aS"] = "@statement.outer",
                    -- ["iS"] = "@scopename.inner",
                    -- ["a"] = "@comment.outer",
                    -- ["a"] = "@call.outer",
                    -- ["i"] = "@call.inner",
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    ["<leader>sn"] = "@parameter.inner",
                },
                swap_previous = {
                    ["<leader>sp"] = "@parameter.inner",
                },
            },
            move = {
                enable = true,
                goto_next_start = {
                    ["]m"] = "@function.outer",
                    ["]]"] = "@class.outer",
                },
                goto_next_end = {
                    ["]M"] = "@function.outer",
                    ["]["] = "@class.outer",
                },
                goto_previous_start = {
                    ["[m"] = "@function.outer",
                    ["[["] = "@class.outer",
                },
                goto_previous_end = {
                    ["[M"] = "@function.outer",
                    ["[]"] = "@class.outer",
                },
            },
            lsp_interop = {
                -- use lspsaga
                enable = false,
                peek_definition_code = {
                    ["<leader>lf"] = "@function.outer",
                    ["<leader>lc"] = "@class.outer",
                },
            },
        },
        textsubjects = {
            enable = true,
            prev_selection = ",",
            keymaps = {
                ["."] = "textsubjects-smart",
                [";"] = "textsubjects-container-outer",
                ["i;"] = "textsubjects-container-inner",
            },
        },
        rainbow = {
            enable = true,
            extended_mode = true,
            max_file_line = nil,
        },
        context_commentstring = {
            enable = true,
        },
        matchup = {
            enable = true,
        },
        autotag = {
            enable = true,
        },
    })
end

m.setup_context = function()
    require("treesitter-context").setup({
        enable = true,
    })
end

m.setup_context_vt = function()
    require("nvim_context_vt").setup({
        enabled = true,
        --Hide for indent bases such as python (virtual text makes it hard to see the lines).
        disable_virtual_lines = true,
    })
end

m.setup_autotag = function()
    require("nvim-ts-autotag").setup()
end

m.setup_hlargs = function()
    require("hlargs").setup()
end

vim.api.nvim_set_keymap("x", "iu", [[:lua require('treesitter-unit').select()<CR>]], { noremap = true })
vim.api.nvim_set_keymap("x", "au", [[:lua require('treesitter-unit').select(true)<CR>]], { noremap = true })
vim.api.nvim_set_keymap("o", "iu", [[:<c-u>lua require('treesitter-unit').select()<CR>]], { noremap = true })
vim.api.nvim_set_keymap("o", "au", [[:<c-u>lua require('treesitter-unit').select(true)<CR>]], { noremap = true })
vim.cmd([[omap <silent> m :<C-u>lua require('tsht').nodes()<CR>]]) -- motion
vim.cmd([[vnoremap <silent> m :lua require('tsht').nodes()<CR>]]) -- motion
vim.api.nvim_set_keymap("n", "<Leader>ss", "<cmd>ISwap<CR>", { noremap = true }) -- swap motion
vim.api.nvim_set_keymap("n", "<Leader>sw", "<cmd>ISwapWith<CR>", { noremap = true }) -- swap motion with

return m
