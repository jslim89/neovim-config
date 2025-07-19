return {
  {
    'zbirenbaum/copilot.lua',
    cmd = "Copilot",
    event = { "InsertEnter", "LspAttach" },
    fix_pairs = true,
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = false,
          auto_trigger = false,
        },
        panel = {
          enabled = false,
          auto_refresh = false,
        },
        filetypes = {
          markdown = false,
          terraform = true,
          javascript = true,
          typescript = true,
          go = true,
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

