return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile", "BufWritePost" },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        lua = { "selene" },
      }

      -- Use the project's selene.toml when there is one, otherwise fall back to this config's.
      local fallback_config = vim.fn.stdpath("config") .. "/selene.toml"
      local selene = lint.linters.selene
      selene.args = {
        "--display-style",
        "json",
        "--config",
        function()
          return vim.fs.find("selene.toml", { upward = true, path = vim.fn.expand("%:p:h") })[1] or fallback_config
        end,
        "-",
      }

      vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("lint", { clear = true }),
        callback = function()
          lint.try_lint()
        end,
      })
      -- The event that lazy-loaded this plugin has already fired (before filetype detection), so lint that buffer once
      -- the filetype is known.
      vim.schedule(function()
        lint.try_lint()
      end)
    end,
  },
}
