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
        "html",
        "pyright",
        "rust_analyzer",
        "clangd",
    },
})

local lspconfig = require("lspconfig")

local servers = {
    sumneko_lua = require("lsp.config.lua"),
    -- bashls = require("lsp.config.bash"),
    -- pyright = require("lsp.config.pyright"),
    -- html = require("lsp.config.html"),
    -- yamlls = require("lsp.config.yamlls"),
    -- rust_analyzer = require("lsp.config.rust"),
    -- taplo = require("lsp.config.taplo"),
    -- gopls = require("lsp.config.gopls"),
}

for name, config in pairs(servers) do
    if config ~= nil and type(config) == "table" then
        config.on_setup(lspconfig[name])
    else
        lspconfig[name].setup({})
    end
end

