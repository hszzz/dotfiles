
return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons", "moll/vim-bbye" },
  event = "VeryLazy",

  config = function()
    require("bufferline").setup({
      options = {
        close_command = "bdelete! %d",
        right_mouse_command = "bdelete! %d",

        buffer_close_icon = "",
        modified_icon = "●",

        offsets = {
          { filetype = "NvimTree", text = "File Explorer", text_align = "left", saperator = true },
        },

        show_close_icon = true,
        show_buffer_close_icons = true,

        name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
          if buf.name:match "%.md" then
            return vim.fn.fnamemodify(buf.name, ":t:r")
          end
        end,

        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local s = " "
          for e, n in pairs(diagnostics_dict) do
            local sym = e == "error" and " " or (e == "warning" and " " or "")
            s = s .. n .. sym
          end
          return s
        end,

        color_icons = true, --- true | false, -- whether or not to add the filetype icon highlights
        show_buffer_icons = true, -- true | false, -- disable filetype icons for buffers
        show_buffer_default_icon = true, -- true | false, -- whether or not an unrecognised filetype should show a default icon
        show_tab_indicators = true, -- true | false,
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        separator_style = "thin", -- "slant" | "thick" | "thin" | { 'any', 'any' },
        enforce_regular_tabs = false, -- false | true,

        always_show_bufferline = true, -- true | false,
        sort_by = "id", -- 'insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
      },
    })
  end,
}
