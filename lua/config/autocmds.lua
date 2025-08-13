vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local filepath = vim.fn.expand("%:p")
    vim.fn.setenv("NVIM_FILE", filepath)
    vim.fn.system("tmux set-environment -g NVIM_FILE " .. filepath)
  end
})

