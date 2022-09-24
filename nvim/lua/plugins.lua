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

  -- lsp
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'

  -- dashboard
  -- use("glepnir/dashboard-nvim")

  -- 补全引擎
  use 'hrsh7th/nvim-cmp'
  -- snippet 引擎
  use 'hrsh7th/vim-vsnip'
  -- 补全源
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/cmp-nvim-lsp' -- { name = nvim_lsp }
  use 'hrsh7th/cmp-buffer' -- { name = 'buffer' },
  use 'hrsh7th/cmp-path' -- { name = 'path' }
  use 'hrsh7th/cmp-cmdline' -- { name = 'cmdline' }

  -- 常见编程语言代码段
  use 'rafamadriz/friendly-snippets'

  -- ui icon
  use 'onsails/lspkind-nvim'

  -- format
  use {
    "jose-elias-alvarez/null-ls.nvim",
    requires = "nvim-lua/plenary.nvim"
  }

  -- rust
  use("simrat39/rust-tools.nvim")

end)

