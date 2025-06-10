return {
  {
    'zbirenbaum/copilot.lua',
    cmd = "Copilot",
    event = { "InsertEnter" },
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
          markdown = false,
          terraform = true,
          javascript = true,
          typescript = true,
          ["*"] = false, -- disable for all other filetypes and ignore default `filetypes`
        },
      })
    end
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function ()
      require("copilot_cmp").setup()
    end
  },
}

