return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",

  config = function()
    local notify = require("notify")

    notify.setup({
      background_colour = "Normal",
      fps = 30,
      icons = {
        DEBUG = "",
        ERROR = "",
        INFO = "",
        TRACE = "✎",
        WARN = "",
      },

      level = 2,
      minimum_width = 26,

      render = "compact",
      stages = "fade_in_slide_out",
      timeout = 2500,
      top_down = true,
    })

    -- vim.notify = notify
  end,
}
