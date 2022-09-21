lua require('basic')
lua require('keybindings')
lua require('plugins')
lua require('colorscheme')
lua require('autocmds')

lua require('plugins-config/nvim-tree')
lua require('plugins-config/bufferline')
lua require('plugins-config/nvim-treesitter')
lua require('plugins-config/lualine')
lua require('plugins-config/telescope')

lua require('lsp/setup')
lua require('lsp/cmp')
lua require('lsp/ui')
lua require('lsp.null-ls')

set background=dark

