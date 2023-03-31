return {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy",

  config = function()
    local null_ls = require("null-ls")

    local formatting = null_ls.builtins.formatting
    -- local diagnostics = null_ls.builtins.diagnostics
    local code_actions = null_ls.builtins.code_actions

    null_ls.setup({
      debug = false,
      sources = {

        formatting.shfmt,
        formatting.stylua,
        formatting.rustfmt,
        formatting.clang_format,
        formatting.black.with({ extra_args = { "--fast" } }),
        formatting.goimports,

        code_actions.gitsigns,
      },

      diagnostics_format = "[#{s}] #{m}",

      on_attach = function(_)
        vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format { async = true }']])
      end,
    })
  end,
}
