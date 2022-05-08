vim.cmd[[packadd packer.nvim]]

require'packer'.startup(function()
  -- Plugin manager.
  use {'wbthomason/packer.nvim', opt = true}

  -- Libraries.
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'

  -- Fuzzy finders.
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'nvim-telescope/telescope.nvim'
end)
