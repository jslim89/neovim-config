return {
  {
    'zbirenbaum/copilot.lua',
    cmd = "Copilot",
    event = { "InsertEnter" },
    config = function()
      require("copilot").setup({
        auto_trigger = true,
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
}

