require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
})

require("mason-lspconfig").setup({
    ensure_installed = {
        "sumneko_lua",
        "bashls",
        "pyright",
        "rust_analyzer",
        "clangd",
        "gopls",
    },
})

local lspconfig = require("lspconfig")

local servers = {
    sumneko_lua = require("lsp.config.lua"),
    bashls = require("lsp.config.bash"),
    pyright = require("lsp.config.pyright"),
    rust_analyzer = require("lsp.config.rust"),
    clangd = require("lsp.config.clangd"),
    gopls = require("lsp.config.gopls"),
}

for name, config in pairs(servers) do
    if config ~= nil and type(config) == "table" then
        config.on_setup(lspconfig[name])
    else
        lspconfig[name].setup({})
    end
end

