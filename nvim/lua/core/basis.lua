vim.g.encoding = "UTF-8"
vim.o.fileencoding = "utf-8"

vim.o.scrolloff = 2
vim.o.sidescrolloff = 2

vim.o.number = true

vim.wo.cursorline = true
vim.wo.signcolumn = "number"

vim.o.tabstop = 2
vim.bo.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftround = true
vim.o.expandtab = true
vim.bo.expandtab = true

-- >> << 时移动长度
vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2

vim.o.autoindent = true

vim.bo.autoindent = true
vim.o.smartindent = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.hlsearch = true
vim.o.incsearch = true

vim.o.cmdheight = 0

vim.o.autoread = true
vim.bo.autoread = true

vim.wo.wrap = false
vim.o.whichwrap = "<,>,[,]"

vim.o.hidden = true

vim.o.mouse = "a"

vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

vim.o.updatetime = 300
vim.o.timeoutlen = 500

vim.o.splitbelow = true
vim.o.splitright = true

vim.g.completeopt = "menu,menuone,noselect,noinsert"

vim.o.termguicolors = true
vim.opt.termguicolors = true

vim.o.list = true
-- vim.o.listchars = "space:·,tab:··"

vim.o.wildmenu = true
vim.o.shortmess = vim.o.shortmess .. "c"

vim.o.pumheight = 10
vim.o.showtabline = 2
vim.o.showmode = false
vim.opt.clipboard = "unnamedplus"
