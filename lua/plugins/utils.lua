return {
  {
    "muhfaris/devtools.nvim",
    opts = function()
      local actions = require "devtools.actions"
      return {
        mappings = {
          v = {
            ["<Leader>jp"] = {
              func = actions.call "json.parse",
              desc = "Parse json string from selection visual text",
            },
            ["<Leader>je"] = {
              func = actions.call "json.escape",
              desc = "Parse json object into escaped json string",
            },
            ["<Leader>be"] = {
              func = actions.call "encode.v_base64_encode",
              desc = "Encode base64 string from selection text",
            },
            ["<Leader>bd"] = {
              func = actions.call "encode.v_base64_decode",
              desc = "Decode base64 string from selection text",
            },
          },
          n = {
            ["<Leader>jwt"] = {
              func = actions.call "jwt.decode_token",
              desc = "Decode JWT token",
            },
          },
        },
      }
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- refer to the configuration in https://github.com/folke/which-key.nvim
      keys = {
        scroll_down = "<c-n>", -- binding to scroll down inside the popup
        scroll_up = "<c-p>", -- binding to scroll up inside the popup
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
}

