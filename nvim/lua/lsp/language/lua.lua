local runtime_path = vim.split(package.path, ";")

table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local default = require("lsp.language.default")

local opts = {
  capabilities = default.capabilities,
  flags = default.flags,

  on_attach = function(client, bufnr)
    default.disableFormat(client)
    default.keyAttach(bufnr)
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
}

return {
  on_setup = function(server)
    require("neodev").setup()
    server.setup(opts)
  end,
}
