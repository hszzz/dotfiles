local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins" },
    { import = "lsp" },
    { import = "format" },
    { import = "dap" },
  },

  dev = {
    path = "~/.vim/nvimplugin/",
    patterns = {},
    fallback = true,
  },

  performence = {
    cache = true,
  },

  install = {
    missing = true,
    colorscheme = { "habamax" },
  },

  diff = {
    cmd = "git",
  },

  checker = {
    enabled = false,
    concurrency = nil,
    notify = true,
    frequency = 3600,
  },

  change_detection = {
    enabled = false,
    notify = true,
  },

  ui = {
    size = { width = 0.8, height = 0.8 },
    wrap = true,
    border = "single", -- none, single, double, rounded, solid, shadow
    icons = {
      cmd = " ",
      config = "",
      event = "",
      ft = " ",
      init = " ",
      import = " ",
      keys = " ",
      lazy = "🍿",
      loaded = "●",
      not_loaded = "○",
      plugin = " ",
      runtime = " ",
      source = " ",
      start = "",
      task = "✔ ",
      list = {
        "●",
        "➜",
        "★",
        "‒",
      },
    },
    browser = nil,
    throttle = 20,
  },
})

