return {
  {
    "rest-nvim/rest.nvim",
    keys = {
      { "<leader>rr", "<cmd>Rest run<cr>", desc = "Run API Request under the cursor" },
    },
    ft = { "http", "https" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      opts = function (_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, "http")
      end,
    }
  },
}

