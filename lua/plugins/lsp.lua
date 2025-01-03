return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {'williamboman/mason.nvim'},           -- Optional
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},         -- auto complete - base
      {'hrsh7th/cmp-nvim-lsp'},     -- auto complete from LSP
      {'hrsh7th/cmp-buffer'},       -- auto complete from buffer
    }
  },
}
