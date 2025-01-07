return {
  {
    'stevearc/conform.nvim',
    opts = {},
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")

      conform.setup({
        formatters_by_ft     = {
          css             = { "prettier" },
          graphql         = { "prettier" },
          html            = { "prettier" },
          json            = { "prettier" },
          -- Conform will run the first available formatter
          javascript      = { "prettier", stop_after_first = true },
          javascriptreact = { "prettierd" },
          liquid          = { "prettierd" },
          lua             = { "stylua" },
          markdown        = { "prettierd" },
          python          = { "isort", "black" },
          rust            = { "rustfmt", lsp_format = "fallback" },
          shell           = { "shfmt" },
          svelte          = { "prettier" },
          typescript      = { "prettier" },
          typescriptreact = { "prettier" },
          yaml            = { "prettier" },
          ["*"]           = { "trim_whitespace" },
        },
        notify_on_error      = true, -- Conform will notify you when a formatter errors.
        quiet                = false,  -- Conform will suppress all output if quiet is true.
        notify_no_formatters = true,  -- Conform will notify you when no formatters are available for the buffer.
        formatters           = {
          prettierd = {
            condition = function()
              return vim.loop.fs_realpath(".prettierrc.js") ~= nil or vim.loop.fs_realpath(".prettierrc.mjs") ~= nil
            end,
          },
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>!", function()
        conform.format({
          lsp_fallback = true,
          async = true,
          timeout_ms = 500,
        })
      end, { desc = "Format file or range (in visual mode)" })
    end,
  },
}
