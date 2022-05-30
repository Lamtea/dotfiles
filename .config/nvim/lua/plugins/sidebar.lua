local m = {}

m.setup = function(use)
    -- 色々な情報を出すサイドバー
    use("sidebar-nvim/sidebar.nvim")

    m.setup_sidebar()
end

m.setup_sidebar = function()
    -- デフォルトキーマップ
    -- git
    -- e	hovering filename	            open file in the previous window
    -- diagnostics
    -- e	hovering diagnostic             message	open file in the previous window at the diagnostic position
    -- t	hovering filename	            toggle collapse on the group
    -- todos
    -- e	hovering todo location	        open file in the previous window at the todo position
    -- t	hovering the group	            toggle collapse on the group
    -- containers
    -- e	hovering a container location	open a new terminal and attach to the container with
    --                                      docker exec -it <container id> ${config.containers.attach_shell}
    -- buffers
    -- d	hovering an item	            close the identified buffer
    -- e	hovering an item	            open the identified buffer in a window
    -- w	hovering an item	            save the identified buffer
    -- files
    -- d	hovering an item	            delete file/folder
    -- y	hovering an item	            yank/copy a file/folder
    -- x	hovering an item	            cut a file/folder
    -- p	hovering an item	            paste a file/folder
    -- c	hovering an item	            create a new file
    -- e	hovering an item	            open the current file/folder
    -- r	hovering an item	            rename file/folder
    -- u	hovering the section	        undo operation
    -- <C-r>hovering the section	        redo operation
    -- <CR>	hovering an item	            open file/folder
    -- symbols
    -- t	hovering an item	            toggle group
    -- e	hovering an item	            open location
    require("sidebar-nvim").setup({
        disable_default_keybindings = 0,
        bindings = {
            -- qで閉じる
            ["q"] = function()
                require("sidebar-nvim").close()
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
end

-- サイドバー表示トグル
vim.api.nvim_set_keymap("n", "gs", "<Cmd>SidebarNvimToggle<CR>", { noremap = true, silent = true })

return m
