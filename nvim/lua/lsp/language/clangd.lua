local default = require("lsp.language.default")

local opts = {
  capabilities = default.capabilities,
  flags = default.flags,
  autostart = true;

  on_attach = function(client, bufnr)
    default.disableFormat(client)
    default.keyAttach(bufnr)
  end,

  cmd = {
    "clangd",
    "--background-index",
    "--pch-storage=memory",
    "--clang-tidy",
    "--completion-style=detailed",
  },

  init_options = {
    clangdFileStatus = true,
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  },

  settings = {
  },
}

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
