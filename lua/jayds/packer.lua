
-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use({
    'rose-pine/neovim',
    as = 'rose-pine',
  })
  use 'sainnhe/everforest'
  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  use('theprimeagen/harpoon')
  use('tpope/vim-fugitive')
  use('neovim/nvim-lspconfig', { tag = 'v1.8.0', pin = true })
  use('hrsh7th/cmp-nvim-lsp')
  use('hrsh7th/nvim-cmp')
  use 'onsails/lspkind.nvim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  use 'lewis6991/gitsigns.nvim'
end)

