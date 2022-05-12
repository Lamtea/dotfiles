-- Running packer plugin manager.
vim.cmd[[packadd packer.nvim]]
require'packer'.startup(function()
  use { 'wbthomason/packer.nvim', opt = true }

  -- Libraries.
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'

  -- Basics.
  use 'tpope/vim-fugitive'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use { 'tpope/vim-unimpaired', opt = true, event = { 'FocusLost', 'CursorHold' }}

  -- Fuzzy finders.
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'nvim-telescope/telescope.nvim'
end)
