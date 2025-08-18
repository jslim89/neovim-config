-- format json output with `jq` command
vim.api.nvim_create_autocmd("FileType",  {
  pattern = { "json" },
  callback = function()
    vim.api.nvim_set_option_value("formatprg", "jq", { scope = 'local' })
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local filepath = vim.fn.expand("%:p")
    vim.fn.setenv("NVIM_FILE", filepath)
    vim.fn.system("tmux set-environment -g NVIM_FILE " .. filepath)
  end
})

