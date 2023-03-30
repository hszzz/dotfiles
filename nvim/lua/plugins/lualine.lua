return {
  event = "VeryLazy",
  "nvim-lualine/lualine.nvim",
  dependencies = { "arkav/lualine-lsp-progress" },

  config = function()
    require("lualine").setup({
      options = {
        theme = require("core.colorscheme").colorscheme,
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
      },

      extensions = { "nvim-tree", "toggleterm" },

      sections = {
        lualine_c = {
          "filename",
          {
            "lsp_progress",
            spinner_symbols = { " ", " ", " ", " ", " ", " " },
          },
        },

        lualine_x = {
          {
            "fileformat",
            symbols = {
              unix = " LF",
              dos = " CRLF",
              mac = " CR",
            },
          },
          "encoding",
          "filetype",
        },
      },
    })
  end,
}
