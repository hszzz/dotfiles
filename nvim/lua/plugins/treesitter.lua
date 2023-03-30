return {
  event = "VeryLazy",
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "mrjones2014/nvim-ts-rainbow" },
  build = ":TSUpdate",

  config = function()
    require("nvim-treesitter").setup({
      ensure_installed = { "html", "vim", "lua", "c", "cpp", "go", "rust", "cmake", "bash", "python" },

      matchup = {
        enable = true, -- mandatory, false will disable the whole extension
      },

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = {},
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          node_decremental = "<BS>",
          scope_incremental = "<TAB>",
        },
      },

      indent = {
        enable = false,
      },

      rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
      },
    })
  end,
}
