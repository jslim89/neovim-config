-- disable the default file explorer
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local function on_attach_change(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { 
      desc = "nvim-tree: " .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true
    }
  end

  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.set(
    'n',
    '<leader>t',
    function () api.tree.toggle{file_path = true} end,
    opts("Toggle nvimtree")
  )
end

require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  on_attach = on_attach_change,
})

