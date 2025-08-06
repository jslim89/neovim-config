local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Modes
--   normal_mode = "n", insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- reload nvim config
keymap('n', '<leader>sv', ':source $MYVIMRC<CR>', { desc = 'Reload Neovim config' })
-- clear search
keymap("n", "<leader>/", ":nohlsearch<CR>", opts)
-- remove trailing spaces
vim.keymap.set("n", "<leader>rs", function()
  local saved_search = vim.fn.getreg("/")
  vim.cmd("%s/\\s\\+$//e")
  vim.fn.setreg("/", saved_search)
end, opts)
-- map ; to :
keymap("n", ";", ":", opts)
-- open directory listing
keymap("n", "<leader>t", ":NvimTreeToggle<cr>", opts)
-- search for files
keymap("n", "<C-p>", ":Telescope find_files<CR>", opts)
-- Navigate buffers
keymap("n", "<A-S-l>", ":bnext<CR>", opts)
keymap("n", "<A-S-h>", ":bprevious<CR>", opts)
-- Resize with arrows
keymap("n", "<A-Up>", ":resize +2<CR>", opts)
keymap("n", "<A-Down>", ":resize -2<CR>", opts)
keymap("n", "<A-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-Right>", ":vertical resize +2<CR>", opts)


-- Insert --
-- Press jj fast to enter normal mode
keymap("i", "jj", "<ESC>", opts)


-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)


-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

