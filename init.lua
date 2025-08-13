-- set the leader key to comma
vim.g.mapleader = ","
vim.g.maplocalleader = ","

require("config.lazy")

if vim.g.vscode then
  -- VSCode extension
  require("config.vscode")
else
  -- ordinary Neovim
  require("config.autocmds")
  require("config.keymaps")
  require("config.options")
  require("config.nvim-tree-config")
  require("config.lsp")
end

