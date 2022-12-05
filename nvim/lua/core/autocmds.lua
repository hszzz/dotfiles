local nvimAutoGroup = vim.api.nvim_create_augroup("nvimAutoGroup", {
	clear = true,
})

local autocmd = vim.api.nvim_create_autocmd

autocmd("BufEnter", {
	nested = true,
	group = nvimAutoGroup,
	callback = function()
		if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
			vim.cmd("quit")
		end
	end,
})

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
	pattern = { "*.lua", "*.py", "*.sh", "*.c", "*.cc", "*.cpp", "*.h", "*.go" },
	callback = function()
		vim.lsp.buf.format()
	end,
})

autocmd("TextYankPost", {
	group = nvimAutoGroup,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
})

autocmd("FileType", {
	group = nvimAutoGroup,
	pattern = { "make" },
	callback = function()
		vim.o.expandtab = false
		vim.bo.expandtab = false
	end,
})

autocmd("FileType", {
	group = nvimAutoGroup,
	pattern = { "cpp", "html", "yaml", "json", "css", "xml" },
	callback = function()
		vim.o.tabstop = 2
		vim.bo.tabstop = 2
		vim.o.shiftwidth = 2
		vim.bo.shiftwidth = 2
	end,
})

-- Quit Nvim if we have only one window, and its filetype match our pattern.
vim.cmd([[
  
  function! s:quit_current_win() abort
    let l:quit_filetypes = ['qf', 'NvimTree']
  
    let l:should_quit = v:true
  
    let l:tabwins = nvim_tabpage_list_wins(0)
    for w in l:tabwins
      let l:buf = nvim_win_get_buf(w)
      let l:bf = getbufvar(l:buf, '&filetype')
  
      if index(l:quit_filetypes, l:bf) == -1
        let l:should_quit = v:false
      endif
    endfor

    if l:should_quit
      qall
    endif
  endfunction

  augroup auto_close_win
    autocmd!
    autocmd BufEnter * call s:quit_current_win()
  augroup END
]])

vim.cmd([[
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]])
