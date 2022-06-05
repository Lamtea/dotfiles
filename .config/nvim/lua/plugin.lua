-- Load plugins.
vim.cmd([[packadd packer.nvim]])
require("packer").startup(function(use)
    -- Plugin manager.
    use({
        "wbthomason/packer.nvim",
        opt = true,
    })

    -- Plugins.
    require("plugins.lib").setup(use)

    if not vim.g.vscode then
        require("plugins.notify").setup(use)
        require("plugins.colorscheme").setup(use)
        require("plugins.lsp").setup(use)
        require("plugins.null-ls").setup(use)
        require("plugins.completion").setup(use)
        require("plugins.fzf").setup(use)
    end

    require("plugins.treesitter").setup(use)

    if not vim.g.vscode then
        require("plugins.status-line").setup(use)
        require("plugins.buffer-line").setup(use)
        require("plugins.sidebar").setup(use)
        require("plugins.filer").setup(use)
        require("plugins.scrollbar").setup(use)
        require("plugins.start-page").setup(use)
        require("plugins.terminal").setup(use)
        require("plugins.help").setup(use)
        require("plugins.highlight").setup(use)
    end

    require("plugins.basic").setup(use)
    require("plugins.command").setup(use)

    if not vim.g.vscode then
        require("plugins.repl").setup(use)
        require("plugins.dap").setup(use)
        require("plugins.git").setup(use)
        require("plugins.github").setup(use)
        require("plugins.markdown").setup(use)
        require("plugins.javascript").setup(use)
        require("plugins.java").setup(use)
        require("plugins.sql").setup(use)
        require("plugins.log").setup(use)
    end
end)
