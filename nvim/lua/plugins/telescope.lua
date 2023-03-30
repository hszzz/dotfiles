return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-lua/popup.nvim" },
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    { "nvim-telescope/telescope-live-grep-args.nvim" },
    { "nvim-telescope/telescope-hop.nvim" },
    { "nvim-telescope/telescope-project.nvim" },
    { "nvim-telescope/telescope-media-files.nvim" },
    { "nvim-telescope/telescope-dap.nvim" },
    { "benfowler/telescope-luasnip.nvim" },
  },
  event = "VeryLazy",

  config = function()
    -- Hot-reloaded function for telescope-hop
    if pcall(require, "plenary") then
      RELOAD = require("plenary.reload").reload_module
      R = function(name)
        RELOAD(name)
        return require(name)
      end
    end

    require("telescope").setup({
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        prompt_prefix = " ",
        selection_caret = "➜ ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            mirror = false,
          },
          vertical = {
            mirror = false,
          },
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        use_less = true,
        path_display = {},
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

        mappings = {
          i = {
            ["<C-h>"] = R("telescope").extensions.hop.hop, -- hop.hop_toggle_selection
            ["<C-space>"] = function(prompt_bufnr)
              local opts = {
                callback = require("telescope.actions").toggle_selection,
                loop_callback = require("telescope.actions").send_selected_to_qflist,
              }
              require("telescope").extensions.hop._hop_loop(prompt_bufnr, opts)
            end,
          },
        },
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      },
      pickers = {
        find_files = {
          theme = "ivy",
        },
        oldfiles = {
          theme = "ivy",
        },
        live_grep = {
          theme = "dropdown",
        },
      },

      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = false, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        },

        live_grep_args = {
          theme = "dropdown",
        },

        hop = {
          clear_selection_hl = false,
          trace_entry = true,
          reset_selection = true,
        },
      },
    })

    local extensions = {
      "fzf",
      "live_grep_args",
      "hop",
      "project",
      "notify",
      -- "dap",
      "luasnip",
    }
    for i = 1, #extensions do
      require("telescope").load_extension(extensions[i])
    end

    vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "Find files" })
    vim.keymap.set("n", "<leader>f?", require("telescope.builtin").help_tags, { desc = "Help tags" })
    vim.keymap.set("n", "<leader>fh", require("telescope.builtin").oldfiles, { desc = "Old files" })
    vim.keymap.set("n", "<leader>fb", require("telescope.builtin").marks, { desc = "Marks" })
    vim.keymap.set("n", "<leader>fc", require("telescope.builtin").colorscheme, { desc = "Colorscheme" })
    vim.keymap.set(
      "n",
      "<leader>fg",
      require("telescope").extensions.live_grep_args.live_grep_args,
      { desc = "Live grep" }
    )

    vim.keymap.set("n", "<leader>fp", require("telescope").extensions.project.project, { desc = "Project" })
    vim.keymap.set("n", "<leader>fm", require("telescope").extensions.media_files.media_files, { desc = "Media files" })
    vim.keymap.set("n", "<leader>fn", require("telescope").extensions.notify.notify, { desc = "Notify" })
    -- vim.keymap.set("n", "<leader>fde", require("telescope").extensions.dap.commands, { desc = "Commands" })
    -- vim.keymap.set("n", "<leader>fdc", require("telescope").extensions.dap.configurations, { desc = "Configurations" })
    -- vim.keymap.set("n", "<leader>fdb", require("telescope").extensions.dap.list_breakpoints, { desc = "Breakpoints" })
    -- vim.keymap.set("n", "<leader>fdv", require("telescope").extensions.dap.variables, { desc = "Variables" })
    -- vim.keymap.set("n", "<leader>fdf", require("telescope").extensions.dap.frames, { desc = "Frames" })
    -- vim.keymap.set("n", "<leader>fs", require("telescope").extensions.luasnip.luasnip, { desc = "Snippets" })
  end,
}
