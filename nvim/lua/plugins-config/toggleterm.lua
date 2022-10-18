local status, toggleterm = pcall(require, "toggleterm")
if not status then
	vim.notify("没有找到 toggleterm")
	return
end

toggleterm.setup({
	dir = "git_dir",
	start_in_insert = false,
	autochdir = true,

	size = function(term)
		if term.direction == "horizontal" then
			return vim.o.lines * 0.3
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.5
		end
	end,

	float_opts = {
		border = "curved",
		winblend = 3,
	},

	auto_scroll = true,
	close_on_exit = true,
	direction = "float",

	on_open = function()
		vim.keymap.set({ "n", "t" }, "<ESC>", "<C-\\><C-n>:ToggleTerm<CR>")
	end,

	on_close = function()
		if vim.fn.mapcheck("<ESC>", "t") ~= "" then
			vim.api.nvim_del_keymap("t", "<ESC>")
		end

		if vim.fn.mapcheck("<ESC>", "n") ~= "" then
			vim.api.nvim_del_keymap("n", "<ESC>")
		end
	end,
})

-- local toggle_float = function()
-- 	toggleterm.Terminal.direction = "float"
-- 	vim.cmd(":ToggleTerm<CR>")
-- end
--
-- local toggle_right = function()
-- 	toggleterm.Terminal.direction = "horizontal"
-- 	vim.cmd(":ToggleTerm<CR>")
-- end
--
-- local toggle_bottom = function()
-- 	toggleterm.Terminal.direction = "vertical"
-- 	vim.cmd(":ToggleTerm<CR>")
-- end
--
-- vim.keymap.set({ "n", "t" }, "<leader>tf", toggle_float)
-- vim.keymap.set({ "n", "t" }, "<leader>tr", toggle_right)
-- vim.keymap.set({ "n", "t" }, "<leader>tb", toggle_bottom)

vim.keymap.set({ "n" }, "<C-t>", ":ToggleTerm<CR>")
