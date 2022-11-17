local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer_bootstrap

if fn.empty(fn.glob(install_path)) > 0 then
	vim.notify("正在安装Pakcer.nvim，请稍后...")
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})

	local rtp_addition = vim.fn.stdpath("data") .. "/site/pack/*/start/*"
	if not string.find(vim.o.runtimepath, rtp_addition) then
		vim.o.runtimepath = rtp_addition .. "," .. vim.o.runtimepath
	end

	vim.notify("Pakcer.nvim 安装完毕")
end

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	vim.notify("没有安装 packer.nvim")
	return
end

packer.startup({
	function(use)
		use("wbthomason/packer.nvim")

		-- colorscheme
		-- use("folke/tokyonight.nvim")
		-- use("mhartington/oceanic-next")
		-- use("shaunsingh/nord.nvim")
		-- use("ful1e5/onedark.nvim")
		-- use("EdenEast/nightfox.nvim")
		use({ "glepnir/zephyr-nvim", requires = { "nvim-treesitter/nvim-treesitter", opt = true } })
		-- use { "ellisonleao/gruvbox.nvim" }

		-- file explore
		use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })

		-- bufferline
		use({ "akinsho/bufferline.nvim", requires = { "kyazdani42/nvim-web-devicons", "moll/vim-bbye" } })

		-- lueline
		use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
		use("arkav/lualine-lsp-progress")

		-- telescope
		use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })

		-- treesitter
		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

		-- lsp
		use("williamboman/mason.nvim")
		use("williamboman/mason-lspconfig.nvim")
		use("neovim/nvim-lspconfig")

		use("hrsh7th/nvim-cmp")
		use("hrsh7th/cmp-vsnip")
		use("hrsh7th/cmp-nvim-lsp")
		use("hrsh7th/cmp-buffer")
		use("hrsh7th/cmp-path")
		use("hrsh7th/cmp-cmdline")
		use("hrsh7th/cmp-nvim-lsp-signature-help")

		use("onsails/lspkind-nvim")

		use("mhartington/formatter.nvim")
		use({ "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" })

		-- snippets
		use("hrsh7th/vim-vsnip")
		use("rafamadriz/friendly-snippets")

		-- lua
		use("folke/neodev.nvim")

		-- rust
		use("simrat39/rust-tools.nvim")

		-- toggleterm
		use("akinsho/toggleterm.nvim")

		use({
			"jedrzejboczar/toggletasks.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
				"akinsho/toggleterm.nvim",
				"nvim-telescope/telescope.nvim/",
			},
			-- To enable YAML config support
			rocks = "lyaml",
		})

		use("skywind3000/asynctasks.vim")
		use("skywind3000/asyncrun.vim")

		if packer_bootstrap then
			packer.sync()
		end
	end,

	config = {
		-- 锁定插件版本在snapshots目录
		-- snapshot_path = require("packer.util").join_paths(vim.fn.stdpath("config"), "snapshots"),

		-- 这里锁定插件版本在v1，不会继续更新插件
		-- snapshot = "v1",

		max_jobs = 16,

		display = {
			-- 使用浮动窗口显示
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
	},
})
