local m = {}

m.setup = function(use)
    -- gitクライアント
    use({
        "TimUntersberger/neogit",
        requires = {
            "nvim-lua/plenary.nvim",
        },
    })
    -- git diffviewer
    use({
        "sindrets/diffview.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
        },
    })
    -- gitの状態をカラムにサイン表示
    use("lewis6991/gitsigns.nvim")

    m.setup_neogit()
    m.setup_diffview()
    m.setup_gitsigns()
end

m.setup_neogit = function()
    -- デフォルトキーマップ
    -- Tab		Toggle diff
    -- 1, 2, 3, 4	Set a foldlevel
    -- $		Command history
    -- b		Branch popup
    -- s		Stage (also supports staging selection/hunk)
    -- S		Stage unstaged changes
    -- <C-s>		Stage Everything
    -- u		Unstage (also supports staging selection/hunk)
    -- U		Unstage staged changes
    -- c		Open commit popup
    -- r		Open rebase popup
    -- L		Open log popup
    -- p		Open pull popup
    -- P		Open push popup
    -- Z		Open stash popup
    -- ?		Open help popup
    -- x		Discard changes (also supports discarding hunks)
    -- <enter>		Go to file
    -- <C-r>		Refresh Buffer
    -- d		Open diffview.nvim at hovered file
    -- D(TODO)		Open diff popup
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
end

m.setup_diffview = function()
    local actions = require("diffview.actions")
    require("diffview").setup({
        -- Show diffs for binaries
        diff_binaries = false,
        -- See |diffview-config-enhanced_diff_hl|
        enhanced_diff_hl = false,
        -- Requires nvim-web-devicons
        use_icons = true,
        -- Only applies when use_icons is true.
        icons = {
            folder_closed = "",
            folder_open = "",
        },
        signs = {
            fold_closed = "",
            fold_open = "",
        },
        file_panel = {
            -- One of 'list' or 'tree'
            listing_style = "tree",
            -- Only applies when listing_style is 'tree'
            tree_options = {
                -- Flatten dirs that only contain one single dir
                flatten_dirs = true,
                -- One of 'never', 'only_folded' or 'always'.
                folder_statuses = "only_folded",
            },
            -- See |diffview-config-win_config|
            win_config = {
                position = "left",
                width = 35,
            },
        },
        file_history_panel = {
            log_options = {
                -- Limit the number of commits
                max_count = 256,
                -- Follow renames (only for single file)
                follow = false,
                -- Include all refs under 'refs/' including HEAD
                all = false,
                -- List only merge commits
                merges = false,
                -- List no merge commits
                no_merges = false,
                -- List commits in reverse order
                reverse = false,
            },
            -- See |diffview-config-win_config|
            win_config = {
                position = "bottom",
                height = 16,
            },
        },
        commit_log_panel = {
            -- See |diffview-config-win_config|
            win_config = {},
        },
        -- Default args prepended to the arg-list for the listed commands
        default_args = {
            DiffviewOpen = {},
            DiffviewFileHistory = {},
        },
        -- See |diffview-config-hooks|
        hooks = {},
        keymaps = {
            -- Disable the default keymaps
            disable_defaults = false,
            view = {
                -- The `view` bindings are active in the diff buffers, only when the current
                -- tabpage is a Diffview.
                -- Open the diff for the next file
                ["<tab>"] = actions.select_next_entry,
                -- Open the diff for the previous file
                ["<s-tab>"] = actions.select_prev_entry,
                -- Open the file in a new split in previous tabpage
                ["gf"] = actions.goto_file,
                -- Open the file in a new split
                ["<C-w><C-f>"] = actions.goto_file_split,
                -- Open the file in a new tabpage
                ["<C-w>gf"] = actions.goto_file_tab,
                -- Bring focus to the files panel
                ["<leader>e"] = actions.focus_files,
                -- Toggle the files panel.
                ["<leader>b"] = actions.toggle_files,
            },
            file_panel = {
                -- Bring the cursor to the next file entry
                ["j"] = actions.next_entry,
                ["<down>"] = actions.next_entry,
                -- Bring the cursor to the previous file entry.
                ["k"] = actions.prev_entry,
                ["<up>"] = actions.prev_entry,
                -- Open the diff for the selected entry.
                ["<cr>"] = actions.select_entry,
                ["o"] = actions.select_entry,
                ["<2-LeftMouse>"] = actions.select_entry,
                -- Stage / unstage the selected entry.
                ["-"] = actions.toggle_stage_entry,
                -- Stage all entries.
                ["S"] = actions.stage_all,
                -- Unstage all entries.
                ["U"] = actions.unstage_all,
                -- Restore entry to the state on the left side.
                ["X"] = actions.restore_entry,
                -- Update stats and entries in the file list.
                ["R"] = actions.refresh_files,
                -- Open the commit log panel.
                ["L"] = actions.open_commit_log,
                -- Scroll the view up
                ["<c-d>"] = actions.scroll_view(-0.25),
                -- Scroll the view down
                ["<c-f>"] = actions.scroll_view(0.25),
                ["<tab>"] = actions.select_next_entry,
                ["<s-tab>"] = actions.select_prev_entry,
                ["gf"] = actions.goto_file,
                ["<C-w><C-f>"] = actions.goto_file_split,
                ["<C-w>gf"] = actions.goto_file_tab,
                -- Toggle between 'list' and 'tree' views
                ["i"] = actions.listing_style,
                -- Flatten empty subdirectories in tree listing style.
                ["f"] = actions.toggle_flatten_dirs,
                ["<leader>e"] = actions.focus_files,
                ["<leader>b"] = actions.toggle_files,
            },
            file_history_panel = {
                -- Open the option panel
                ["g!"] = actions.options,
                -- Open the entry under the cursor in a diffview
                ["<C-A-d>"] = actions.open_in_diffview,
                -- Copy the commit hash of the entry under the cursor
                ["y"] = actions.copy_hash,
                ["L"] = actions.open_commit_log,
                ["zR"] = actions.open_all_folds,
                ["zM"] = actions.close_all_folds,
                ["j"] = actions.next_entry,
                ["<down>"] = actions.next_entry,
                ["k"] = actions.prev_entry,
                ["<up>"] = actions.prev_entry,
                ["<cr>"] = actions.select_entry,
                ["o"] = actions.select_entry,
                ["<2-LeftMouse>"] = actions.select_entry,
                ["<c-b>"] = actions.scroll_view(-0.25),
                ["<c-f>"] = actions.scroll_view(0.25),
                ["<tab>"] = actions.select_next_entry,
                ["<s-tab>"] = actions.select_prev_entry,
                ["gf"] = actions.goto_file,
                ["<C-w><C-f>"] = actions.goto_file_split,
                ["<C-w>gf"] = actions.goto_file_tab,
                ["<leader>e"] = actions.focus_files,
                ["<leader>b"] = actions.toggle_files,
            },
            option_panel = {
                ["<tab>"] = actions.select_entry,
                ["q"] = actions.close,
            },
        },
    })
end

m.setup_gitsigns = function()
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
            end, { expr = true, desc = "Gitsigns next_hunk" })

            map("n", "[h", function()
                if vim.wo.diff then
                    return "[h"
                end
                vim.schedule(function()
                    gs.prev_hunk()
                end)
                return "<Ignore>"
            end, { expr = true, desc = "GitSigns prev_hunk" })

            -- Actions
            map({ "n", "v" }, "<leader><leader>gs", ":Gitsigns stage_hunk<CR>")
            map({ "n", "v" }, "<leader><leader>gr", ":Gitsigns reset_hunk<CR>")
            map("n", "<leader><leader>gS", gs.stage_buffer, { desc = "Gitsigns stage_buffer" })
            map("n", "<leader><leader>gu", gs.undo_stage_hunk, { desc = "GitSigns undo_stage_hunk" })
            map("n", "<leader><leader>gR", gs.reset_buffer, { desc = "GitSigns reset_buffer" })
            map("n", "<leader><leader>gg", gs.preview_hunk, { desc = "GitSigns preview_hunk" })
            map("n", "<leader><leader>gb", function()
                gs.blame_line({ full = true })
            end, { desc = "Gitsigns blame_line" })
            map(
                "n",
                "<leader><leader>gB",
                gs.toggle_current_line_blame,
                { desc = "Gitsigns toggle_current_line_blame" }
            )
            -- diffview使用
            -- map("n", "<leader><leader>gd", gs.diffthis)
            -- map("n", "<leader><leader>gD", function()
            -- 	   gs.diffthis("~")
            -- end)
            map("n", "<leader><leader>gD", gs.toggle_deleted, { desc = "Gitsigns toggle_deleted" })

            -- Text object
            map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
        end,
    })
end

-- gitクライアントをタブ表示
vim.api.nvim_set_keymap("n", "<leader><leader>gc", "<Cmd>Neogit kind=tab<CR>", { noremap = true, silent = true })
-- gitクライアントをフローティング表示(very unstable)
-- vim.api.nvim_set_keymap("n", "<leader><leader>gc", "<Cmd>Neogit kind=floating<CR>", { noremap = true, silent = true })
-- git commitをポップアップ表示
vim.api.nvim_set_keymap("n", "<leader><leader>gC", "<Cmd>Neogit commit<CR>", { noremap = true, silent = true })
-- git diff表示
vim.api.nvim_set_keymap("n", "<leader><leader>gd", "<Cmd>DiffviewOpen<CR>", { noremap = true, silent = true })
-- ヒストリをdiff表示
vim.api.nvim_set_keymap("n", "<leader><leader>gh", "<Cmd>DiffviewFileHistory<CR>", { noremap = true, silent = true })

return m
