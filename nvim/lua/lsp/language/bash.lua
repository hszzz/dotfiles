local default = require("lsp.language.default")

local opts = {
  capabilities = default.capabilities,
  flags = default.flags,

  on_attach = function(client, bufnr)
    default.disableFormat(client)
    default.keyAttach(bufnr)
  end,
}

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
