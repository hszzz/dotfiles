local default = require("lsp.language.default")

local opts = {
  capabilities = default.capabilities,
  flags = default.flags,

  on_attach = function(client, bufnr)
    default.disableFormat(client)
    default.keyAttach(bufnr)
  end,

  settings = {
    ["rust-analyzer"] = {
      checkOnSave = {
        command = "clippy",
      },
    },
  },
}

return {
  on_setup = function(server)
    local ok_rt, rust_tools = pcall(require, "rust-tools")
    if not ok_rt then
      print("Failed to load rust tools, will set up `rust_analyzer` without `rust-tools`.")
      server.setup(opts)
    else
      -- We don't want to call lspconfig.rust_analyzer.setup() when using rust-tools
      rust_tools.setup({
        server = opts,
        -- dap = require("dap.nvim-dap.config.rust"),
      })
    end
  end,
}
