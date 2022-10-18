local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local common = require("lsp.common")

local opts = {
    capabilities = common.capabilities,
    flags = common.flags,
    on_attach = function(client, bufnr)
        common.disableFormat(client)
        common.keyAttach(bufnr)
    end,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = runtime_path,
            },

            diagnostics = {
                globals = { "vim" },
            },

            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },

            telemetry = {
                enable = false,
            },
        },
    },

    -- custom handler
    -- handlers = {
    --   ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    --     virtual_text = false,
    --     signs = true,
    --     underline = true,
    --     update_in_insert = false,
    --   }),
    -- },
}

return {
    on_setup = function(server)
        require("neodev").setup()
        server.setup(opts)
    end,
}
