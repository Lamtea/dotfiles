local m = {}

m.setup = function(use)
    -- :Octo <Object> <Action> [Argument]
    -- Object		Action				Arguments
    -- issue		close				Close the current issue
    -- 			reopen				Reopen the current issue
    -- 			create [repo]			Creates a new issue in the current or specified repo
    -- 			edit [repo]			Edit issue <number> in current or specified repo
    -- 			list [repo] [key=value] (1)	List all issues satisfying given filter
    -- 			search				Live issue search
    -- 			reload				Reload issue. Same as doing e!
    -- 			browser				Open current issue in the browser
    -- 			url				Copies the URL of the current issue to the system clipboard
    -- pr		list [repo] [key=value] (2)	List all PRs satisfying given filter
    -- 			search				Live issue search
    -- 			edit [repo]			Edit PR <number> in current or specified repo
    -- 			reopen				Reopen the current PR
    -- 			close				Close the current PR
    -- 			checkout			Checkout PR
    -- 			commits				List all PR commits
    -- 			changes				Show all PR changes (diff hunks)
    -- 			diff				Show PR diff
    -- 			merge [commit|rebase|squash] [delete]	Merge current PR using the specified method
    -- 			ready				Mark a draft PR as ready for review
    -- 			checks				Show the status of all checks run on the PR
    -- 			reload				Reload PR. Same as doing e!
    -- 			browser				Open current PR in the browser
    -- 			url				Copies the URL of the current PR to the system clipboard
    -- repo		list (3)			List repos user owns, contributes or belong to
    -- 			fork				Fork repo
    -- 			browser				Open current repo in the browser
    -- 			url				Copies the URL of the current repo to the system clipboard
    -- gist		list [repo] [key=value] (4)	List user gists
    -- comment		add				Add a new comment
    -- 			delete				Delete a comment
    -- thread		resolve				Mark a review thread as resolved
    -- 			unresolve			Mark a review thread as unresolved
    -- label		add [label]			Add a label from available label menu
    -- 			remove [label]			Remove a label
    -- 			create [label]			Create a new label
    -- assignees	add [login]			Assign a user
    -- 			remove [login]			Unassign a user
    -- reviewer		add [login]			Assign a PR reviewer
    -- reaction		thumbs_up | +1			Add +1 reaction
    -- 			thumbs_down | -1		Add -1 reaction
    -- 			eyes				Add eyes reaction
    -- 			laugh				Add smile reaction
    -- 			confused			Add confused reaction
    -- 			rocket				Add rocket reaction
    -- 			heart				Add heart reaction
    -- 			hooray | party | tada		Add tada reaction
    -- card		add				Assign issue/PR to a project new card
    -- 			remove				Delete project card
    -- 			move				Move project card to different project/column
    -- review		start				Start a new review
    -- 			submit				Submit the review
    -- 			resume				Edit a pending review for current PR
    -- 			discard				Deletes a pending review for current PR if any
    -- 			comments			View pending review comments
    -- 			commit				Pick a specific commit to review
    -- actions						Lists all available Octo actions
    -- search						Search GitHub for issues and PRs matching the query
    use({
        "pwntester/octo.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "kyazdani42/nvim-web-devicons",
        },
    })

    m.setup_octo()
end

m.setup_octo = function()
    require("octo").setup({
        default_remote = { "upstream", "origin" }, -- order to try remotes
        reaction_viewer_hint_icon = "", -- marker for user reactions
        user_icon = " ", -- user icon
        timeline_marker = "", -- timeline marker
        timeline_indent = "2", -- timeline indentation
        right_bubble_delimiter = "", -- Bubble delimiter
        left_bubble_delimiter = "", -- Bubble delimiter
        github_hostname = "", -- GitHub Enterprise host
        snippet_context_lines = 4, -- number or lines around commented lines
        file_panel = {
            size = 10, -- changed files panel rows
            use_icons = true, -- use web-devicons in file panel
        },
        mappings = {
            issue = {
                close_issue = "<space>ic", -- close issue
                reopen_issue = "<space>io", -- reopen issue
                list_issues = "<space>il", -- list open issues on same repo
                reload = "<C-r>", -- reload issue
                open_in_browser = "<C-d>", -- open issue in browser
                copy_url = "<C-y>", -- copy url to system clipboard
                add_assignee = "<space>aa", -- add assignee
                remove_assignee = "<space>ad", -- remove assignee
                create_label = "<space>lc", -- create label
                add_label = "<space>la", -- add label
                remove_label = "<space>ld", -- remove label
                goto_issue = "<space>gi", -- navigate to a local repo issue
                add_comment = "<space>ca", -- add comment
                delete_comment = "<space>cd", -- delete comment
                next_comment = "]c", -- go to next comment
                prev_comment = "[c", -- go to previous comment
                react_hooray = "<space>rp", -- add/remove 🎉 reaction
                react_heart = "<space>rh", -- add/remove ❤️ reaction
                react_eyes = "<space>re", -- add/remove 👀 reaction
                react_thumbs_up = "<space>r+", -- add/remove 👍 reaction
                react_thumbs_down = "<space>r-", -- add/remove 👎 reaction
                react_rocket = "<space>rr", -- add/remove 🚀 reaction
                react_laugh = "<space>rl", -- add/remove 😄 reaction
                react_confused = "<space>rc", -- add/remove 😕 reaction
            },
            pull_request = {
                checkout_pr = "<space>po", -- checkout PR
                merge_pr = "<space>pm", -- merge commit PR
                squash_and_merge_pr = "<space>psm", -- squash and merge PR
                list_commits = "<space>pc", -- list PR commits
                list_changed_files = "<space>pf", -- list PR changed files
                show_pr_diff = "<space>pd", -- show PR diff
                add_reviewer = "<space>va", -- add reviewer
                remove_reviewer = "<space>vd", -- remove reviewer request
                close_issue = "<space>ic", -- close PR
                reopen_issue = "<space>io", -- reopen PR
                list_issues = "<space>il", -- list open issues on same repo
                reload = "<C-r>", -- reload PR
                open_in_browser = "<C-d>", -- open PR in browser
                copy_url = "<C-y>", -- copy url to system clipboard
                add_assignee = "<space>aa", -- add assignee
                remove_assignee = "<space>ad", -- remove assignee
                create_label = "<space>lc", -- create label
                add_label = "<space>la", -- add label
                remove_label = "<space>ld", -- remove label
                goto_issue = "<space>gi", -- navigate to a local repo issue
                add_comment = "<space>ca", -- add comment
                delete_comment = "<space>cd", -- delete comment
                next_comment = "]c", -- go to next comment
                prev_comment = "[c", -- go to previous comment
                react_hooray = "<space>rp", -- add/remove 🎉 reaction
                react_heart = "<space>rh", -- add/remove ❤️ reaction
                react_eyes = "<space>re", -- add/remove 👀 reaction
                react_thumbs_up = "<space>r+", -- add/remove 👍 reaction
                react_thumbs_down = "<space>r-", -- add/remove 👎 reaction
                react_rocket = "<space>rr", -- add/remove 🚀 reaction
                react_laugh = "<space>rl", -- add/remove 😄 reaction
                react_confused = "<space>rc", -- add/remove 😕 reaction
            },
            review_thread = {
                goto_issue = "<space>gi", -- navigate to a local repo issue
                add_comment = "<space>ca", -- add comment
                add_suggestion = "<space>sa", -- add suggestion
                delete_comment = "<space>cd", -- delete comment
                next_comment = "]c", -- go to next comment
                prev_comment = "[c", -- go to previous comment
                select_next_entry = "]q", -- move to previous changed file
                select_prev_entry = "[q", -- move to next changed file
                close_review_tab = "<C-c>", -- close review tab
                react_hooray = "<space>rp", -- add/remove 🎉 reaction
                react_heart = "<space>rh", -- add/remove ❤️ reaction
                react_eyes = "<space>re", -- add/remove 👀 reaction
                react_thumbs_up = "<space>r+", -- add/remove 👍 reaction
                react_thumbs_down = "<space>r-", -- add/remove 👎 reaction
                react_rocket = "<space>rr", -- add/remove 🚀 reaction
                react_laugh = "<space>rl", -- add/remove 😄 reaction
                react_confused = "<space>rc", -- add/remove 😕 reaction
            },
            submit_win = {
                approve_review = "<C-a>", -- approve review
                comment_review = "<C-m>", -- comment review
                request_changes = "<C-r>", -- request changes review
                close_review_tab = "<C-c>", -- close review tab
            },
            review_diff = {
                add_review_comment = "<space>ca", -- add a new review comment
                add_review_suggestion = "<space>sa", -- add a new review suggestion
                focus_files = "<leader>e", -- move focus to changed file panel
                toggle_files = "<leader>b", -- hide/show changed files panel
                next_thread = "]t", -- move to next thread
                prev_thread = "[t", -- move to previous thread
                select_next_entry = "]q", -- move to previous changed file
                select_prev_entry = "[q", -- move to next changed file
                close_review_tab = "<C-c>", -- close review tab
                toggle_viewed = "<leader><space>", -- toggle viewer viewed state
            },
            file_panel = {
                next_entry = "j", -- move to next changed file
                prev_entry = "k", -- move to previous changed file
                select_entry = "<cr>", -- show selected changed file diffs
                refresh_files = "R", -- refresh changed files panel
                focus_files = "<leader>e", -- move focus to changed file panel
                toggle_files = "<leader>b", -- hide/show changed files panel
                select_next_entry = "]q", -- move to previous changed file
                select_prev_entry = "[q", -- move to next changed file
                close_review_tab = "<C-c>", -- close review tab
                toggle_viewed = "<leader><space>", -- toggle viewer viewed state
            },
        },
    })
end

-- Find actions.
vim.api.nvim_set_keymap("n", "<leader><leader>hh", "<Cmd>Octo actions<CR>", { noremap = true, silent = true })
-- Find github issues and pull requests.
vim.api.nvim_set_keymap("n", "<leader><leader>hs", "<Cmd>Octo search<CR>", { noremap = true, silent = true })
-- For issue.
vim.api.nvim_set_keymap("n", "<leader><leader>hic", "<Cmd>Octo issue create<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader><leader>hil", "<Cmd>Octo issue list<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader><leader>hii", "<Cmd>Octo issue search<CR>", { noremap = true, silent = true })
-- For pull request.
vim.api.nvim_set_keymap("n", "<leader><leader>hpl", "<Cmd>Octo pr list<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader><leader>hps", "<Cmd>Octo pr search<CR>", { noremap = true, silent = true })

return m
