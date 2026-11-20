return {
  {
    "alexghergh/nvim-tmux-navigation",
    config = function()
      require("nvim-tmux-navigation").setup({
        disable_when_zoomed = true, -- defaults to false
        keybindings = {
          last_active = "<C-\\>",
          next = "<C-Space>",
        },
      })
    end,
  },
  {
    "swaits/zellij-nav.nvim",
    lazy = true,
    cond = function()
      return vim.env.ZELLIJ ~= nil
    end,
    opts = {},
  },
  { "jlanzarotta/bufexplorer" },
}

