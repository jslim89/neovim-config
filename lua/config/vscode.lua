local vscode = require('vscode')
local keymap = vim.keymap.set

-- share the system clipboard
vim.opt.clipboard = "unnamedplus"

local opts = { noremap = true, silent = true }

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- remove trailing spaces
keymap("n", "<leader>rs", function()
  local saved_search = vim.fn.getreg("/")
  vim.cmd("%s/\\s\\+$//e")
  vim.fn.setreg("/", saved_search)
end, opts)

-- VS Code specific actions --
keymap("n", "<leader>n", "<cmd>lua require('vscode').action('workbench.action.toggleSidebarVisibility')<CR>", opts)
keymap("n", "<leader>r", "<cmd>lua require('vscode').action('editor.action.rename')<CR>", opts)
keymap("n", "<leader>i", "<cmd>lua require('vscode').action('editor.action.goToDeclaration')<CR>", opts)
keymap("n", "<leader>b", "<cmd>lua require('vscode').action('workbench.action.navigateBack')<CR>", opts)
keymap("n", "<leader>d", "<cmd>lua require('vscode').action('extension.debugJest')<CR>", opts)

