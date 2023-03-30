local nvimAutoGroup = vim.api.nvim_create_augroup("nvimAutoGroup", {
  clear = true,
})

local autocmd = vim.api.nvim_create_autocmd
vim.cmd([[
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]])

autocmd("FileType", {
  group = nvimAutoGroup,
  pattern = { "make" },
  callback = function()
    vim.o.expandtab = false
    vim.bo.expandtab = false
  end,
})

