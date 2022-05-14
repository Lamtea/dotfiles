local api = vim.api

-- Variables.
local vars = {
    neo_tree_remove_legacy_commands = 1,
}

for key, val in pairs(vars) do
    api.nvim_set_var(key, val)
end

-- Running packer plugin manager.
vim.cmd[[packadd packer.nvim]]
require'packer'.startup(function()
    use { 'wbthomason/packer.nvim', opt = true }

    -- Libraries.
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use 'MunifTanjim/nui.nvim'

    -- Basics.
    use 'tpope/vim-fugitive'
    use 'tpope/vim-repeat'
    use 'tpope/vim-surround'
    use {
        'tpope/vim-unimpaired',
        opt = true,
        event = { 'FocusLost', 'CursorHold' }
    }

    -- Filers.
    use {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v2.x',
        requires = { 
            'nvim-lua/plenary.nvim',
            'kyazdani42/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
        }
    }

    -- Fuzzy finders.
    use 'junegunn/fzf'
    use 'junegunn/fzf.vim'
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
        }
    }
end)
