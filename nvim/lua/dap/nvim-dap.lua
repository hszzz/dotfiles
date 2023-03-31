return {
  lazy = true,
  "mfussenegger/nvim-dap",
  dependencies = {
    { "rcarriga/nvim-dap-ui", lazy = true, config = true },
    { "theHamsta/nvim-dap-virtual-text", lazy = true, config = true },
    --  { "jbyuki/one-small-step-for-vimkind", lazy = true },
    --  { "williamboman/mason.nvim", event = "VeryLazy" },
    --  { "jay-babu/mason-nvim-dap.nvim", event = "VeryLazy", config = true, opts = { ensure_installed = {} } },
  },

  config = function()
    vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939", bg = "#31353f" })
    vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
    vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })

    vim.fn.sign_define(
      "DapBreakpoint",
      { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
    )
    vim.fn.sign_define(
      "DapBreakpointCondition",
      { text = "ﳁ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
    )
    vim.fn.sign_define(
      "DapBreakpointRejected",
      { text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
    )
    vim.fn.sign_define(
      "DapLogPoint",
      { text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint" }
    )
    vim.fn.sign_define(
      "DapStopped",
      { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
    )

    local vt = require("nvim-dap-virtual-text")
    local dapui = require("dapui")
    local dap = require("dap")

    vt.setup({
      commented = true,
    })

    dapui.setup({
      element_mappings = {
        scopes = {
          open = "<CR>",
          edit = "e",
          expand = "o",
          repl = "r",
        },
      },

      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.4 },
            "stacks",
            "watches",
            "breakpoints",
            "console",
          },
          size = 0.35, -- 40 columns
          position = "left",
        },
        {
          elements = {
            "repl",
          },
          size = 0.25, -- 25% of total lines
          position = "bottom",
        },
      },
      floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "rounded", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
    })

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    require("dap.language.cpp").setup()
    require("dap.language.python").setup()

    require("core.keybindings").mapDAP()
  end,
}
