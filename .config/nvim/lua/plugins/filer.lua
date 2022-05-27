local m = {}

m.setup = function(use)
    -- 軽くて安定したlua製ファイラ(隠しファイルを表示する場合はサイドバーを使用)
    use({
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
    })

    -- neo-treeのレガシーコマンドは使用しない
    vim.g.neo_tree_remove_legacy_commands = 1

    m.setup_neotree()
end

m.setup_neotree = function()
    require("neo-tree").setup({
        -- Close Neo-tree if it is the last window left in the tab
        close_if_last_window = false,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        default_component_configs = {
            container = {
                enable_character_fade = true
            },
            indent = {
                indent_size = 2,
                -- extra padding on left hand side
                padding = 1,
                -- indent guides
                with_markers = true,
                indent_marker = "│",
                last_indent_marker = "└",
                highlight = "NeoTreeIndentMarker",
                -- expander config, needed for nesting files
                -- if nil and file nesting is enabled, will enable expanders
                with_expanders = nil,
                expander_collapsed = "",
                expander_expanded = "",
                expander_highlight = "NeoTreeExpander",
            },
            icon = {
                folder_closed = "",
                folder_open = "",
                folder_empty = "ﰊ",
                -- The next two settings are only a fallback,
                -- if you use nvim-web-devicons and configure default icons there
                -- then these will never be used.
                default = "*",
                highlight = "NeoTreeFileIcon"
            },
            modified = {
                symbol = "[+]",
                highlight = "NeoTreeModified",
            },
            name = {
                trailing_slash = false,
                use_git_status_colors = true,
                highlight = "NeoTreeFileName",
            },
            git_status = {
                symbols = {
                    -- Change type
                    -- or "✚", but this is redundant info if you use git_status_colors on the name
                    added     = "",
                    -- or "", but this is redundant info if you use git_status_colors on the name
                    modified  = "",
                    -- this can only be used in the git_status source
                    deleted   = "✖",
                    -- this can only be used in the git_status source
                    renamed   = "",
                    -- Status type
                    untracked = "",
                    ignored   = "",
                    unstaged  = "",
                    staged    = "",
                    conflict  = "",
                }
            },
        },
        window = {
            position = "left",
            width = 40,
            mapping_options = {
                noremap = true,
                nowait = true,
            },
            mappings = {
                ["<space>"] = {
                    "toggle_node",
                    -- disable `nowait` if you have existing combos starting with this char that you want to use
                    nowait = false,
                },
                ["<2-LeftMouse>"] = "open",
                ["<cr>"] = "open",
                ["S"] = "open_split",
                ["s"] = "open_vsplit",
                -- ["S"] = "split_with_window_picker",
                -- ["s"] = "vsplit_with_window_picker",
                ["t"] = "open_tabnew",
                ["w"] = "open_with_window_picker",
                ["C"] = "close_node",
                ["a"] = {
                    "add",
                    -- some commands may take optional config options, see `:h neo-tree-mappings` for details
                    config = {
                        -- "none", "relative", "absolute"
                        show_path = "none"
                    }
                },
                -- also accepts the config.show_path option.
                ["A"] = "add_directory",
                ["d"] = "delete",
                ["r"] = "rename",
                ["y"] = "copy_to_clipboard",
                ["x"] = "cut_to_clipboard",
                ["p"] = "paste_from_clipboard",
                -- takes text input for destination
                ["c"] = "copy",
                -- takes text input for destination
                ["m"] = "move",
                ["q"] = "close_window",
                ["R"] = "refresh",
                ["?"] = "show_help",
            }
        },
        nesting_rules = {},
        filesystem = {
            filtered_items = {
                -- when true, they will just be displayed differently than normal items
                visible = false,
                hide_dotfiles = false,
                hide_gitignored = false,
                -- only works on Windows for hidden files/directories
                hide_hidden = true,
                hide_by_name = {
                    --"node_modules"
                },
                -- uses glob style patterns
                hide_by_pattern = {
                    --"*.meta"
                },
                -- remains hidden even if visible is toggled to true
                never_show = {
                    --".DS_Store",
                    --"thumbs.db"
                },
            },
            -- This will find and focus the file in the active buffer every
            follow_current_file = false,
            -- time the current file is changed while the tree is open.
            -- when true, empty folders will be grouped together
            group_empty_dirs = false,
            -- netrw disabled, opening a directory opens neo-tree
            hijack_netrw_behavior = "open_default",
            -- in whatever position is specified in window.position
            -- netrw disabled, opening a directory opens within the
            -- "open_current",
            -- window like netrw would, regardless of window.position
            -- netrw left alone, neo-tree does not handle opening dirs
            -- "disabled",
            -- This will use the OS level file watchers to detect changes
            use_libuv_file_watcher = false,
            -- instead of relying on nvim autocmd events.
            window = {
                mappings = {
                    ["<bs>"] = "navigate_up",
                    ["."] = "set_root",
                    ["H"] = "toggle_hidden",
                    ["/"] = "fuzzy_finder",
                    ["f"] = "filter_on_submit",
                    ["<c-x>"] = "clear_filter",
                    ["[g"] = "prev_git_modified",
                    ["]g"] = "next_git_modified",
                }
            }
        },
        buffers = {
            -- This will find and focus the file in the active buffer every
            follow_current_file = true,
            -- time the current file is changed while the tree is open.
            -- when true, empty folders will be grouped together
            group_empty_dirs = true,
            show_unloaded = true,
            window = {
                mappings = {
                    ["bd"] = "buffer_delete",
                    ["<bs>"] = "navigate_up",
                    ["."] = "set_root",
                }
            },
        },
        git_status = {
            window = {
                position = "float",
                mappings = {
                    ["A"]  = "git_add_all",
                    ["gu"] = "git_unstage_file",
                    ["ga"] = "git_add_file",
                    ["gr"] = "git_revert_file",
                    ["gc"] = "git_commit",
                    ["gp"] = "git_push",
                    ["gg"] = "git_commit_and_push",
                }
            }
        }
    })
end

-- キーバインドはどのneotree windowでも ? で確認できる
-- サイドにfilesystemをトグル表示, xは特に意味はないが公式キーマップ((s)idebarの下の段)
vim.keymap.set("n", "gx", "<Cmd>Neotree filesystem reveal toggle<CR>", { noremap = true, silent = true })
-- サイドにbuffersをトグル表示, zに特に意味はないがxの隣
vim.keymap.set("n", "gz", "<Cmd>Neotree buffers toggle<CR>", { noremap = true, silent = true })
-- フローティングウィンドウにgit_statusを表示
vim.keymap.set("n", "gX", "<Cmd>Neotree git_status show<CR>", { noremap = true, silent = true })

return m
