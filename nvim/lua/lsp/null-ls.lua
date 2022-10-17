local status, null_ls = pcall(require, "null-ls")
if not status then
    vim.notify("没有找到 null-ls")
    return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
    debug = false,
    sources = {
        formatting.shfmt,
        formatting.stylua,
        formatting.rustfmt,
        formatting.clang_format,
        formatting.black.with({ extra_args = { "--fast" } }),

        code_actions.gitsigns,
    },
    diagnostics_format = "[#{s}] #{m}",
    on_attach = function(_)
        vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()']])
    end,
})
