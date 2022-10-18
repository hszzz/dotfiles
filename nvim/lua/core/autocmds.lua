local nvimAutoGroup = vim.api.nvim_create_augroup("nvimAutoGroup", {
  clear = true,
})

local autocmd = vim.api.nvim_create_autocmd

autocmd("BufWritePost", {
  group = nvimAutoGroup,
  callback = function()
    if vim.fn.expand("<afile>") == "lua/plugins.lua" then
      vim.api.nvim_command("source lua/plugins.lua")
      vim.api.nvim_command("PackerSync")
    end
  end,
})

autocmd("BufWritePre", {
  group = nvimAutoGroup,
  -- pattern = { "*.lua", "*.py", "*.sh", "*.c", "*.cc", "*.cpp", "*.h" },
  callback = function()
    vim.lsp.buf.format()
  end,
})

autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = nvimAutoGroup,
  pattern = "*",
})

