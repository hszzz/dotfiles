return {
  -- event = "VeryLazy",
  event = "BufReadPre",
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },

  config = function()
    require("mason").setup({
      ui = {
        check_outdated_packages_on_open = true,
        border = "single",
        width = 0.8,
        height = 0.9,
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "bashls", "pyright", "rust_analyzer", "clangd", "gopls" },
    })

    local servers = {
      lua_ls = require("lsp.language.lua"),
      bashls = require("lsp.language.bash"),
      pyright = require("lsp.language.pyright"),
      rust_analyzer = require("lsp.language.rust"),
      clangd = require("lsp.language.clangd"),
      gopls = require("lsp.language.gopls"),
    }

    local lspconfig = require("lspconfig")
    for name, config in pairs(servers) do
      if config ~= nil and type(config) == "table" then
        config.on_setup(lspconfig[name])
      else
        lspconfig[name].setup({})
      end
    end
  end,
}
