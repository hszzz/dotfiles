return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- theme
  use {
    'ellisonleao/gruvbox.nvim',
    requires = { 'rktjmp/lush.nvim' }
  }
  use 'folke/tokyonight.nvim'
  use 'mhartington/oceanic-next'
  use 'shaunsingh/nord.nvim'
  use 'ful1e5/onedark.nvim'

  -- file explored
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons'
  }

  -- tab
  use {
    'akinsho/bufferline.nvim',
    requires = 'kyazdani42/nvim-web-devicons'
  }

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' } 
  }
  use 'arkav/lualine-lsp-progress'

  -- search
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use "LinArcX/telescope-env.nvim"
end)

