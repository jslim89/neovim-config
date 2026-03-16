return {
  {
    "olimorris/codecompanion.nvim",
    version = "^19.0.0",
    opts = {
      interactions = {
        chat = {
          adapter = "copilot",
          model = "gpt-5.4",
        },
        inline = {
          adapter = "copilot",
        },
        cmd = {
          adapter = "copilot",
        },
        background = {
          adapter = {
            name = "copilot",
            model = "gpt-5.4",
          },
        },
      },
      -- NOTE: The log_level is in `opts.opts`
      opts = {
        log_level = "DEBUG",
      },
    },
    config = function()
      local codecompanion = require("codecompanion")

      vim.keymap.set({ "n", "v" }, "<LocalLeader>]", function()
        codecompanion.toggle({ window_opts = { layout = "float", width = 0.6 }})
      end, { noremap = true, silent = true })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "ravitemer/mcphub.nvim",
    },
  },
}

