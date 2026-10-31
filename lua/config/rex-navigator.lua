local dirs = { h = "left", j = "down", k = "up", l = "right" }
local tmux_fn = {
  h = "NvimTmuxNavigateLeft",  j = "NvimTmuxNavigateDown",
  k = "NvimTmuxNavigateUp",    l = "NvimTmuxNavigateRight",
}

local function navigate(key)
  -- inside tmux: delegate to the plugin, as before
  if vim.env.TMUX then
    local ok, nav = pcall(require, "nvim-tmux-navigation")
    if ok then
      nav[tmux_fn[key]]()
      return
    end
  end

  -- otherwise: move within nvim, and if that didn't move us
  -- (edge of the splits), ask Rex to move focus
  local win = vim.api.nvim_get_current_win()
  vim.cmd("wincmd " .. key)
  if vim.api.nvim_get_current_win() == win and vim.fn.executable("rex") == 1 then
    local out = {}
    local script = ("local _, e = rex.session.focus_direction{direction=%q}; if e then error(e, 0) end")
      :format(dirs[key])
    vim.fn.jobstart({ "rex", "do", "-e", script }, {
      stdout_buffered = true,
      stderr_buffered = true,
      on_stdout = function(_, d) vim.list_extend(out, d) end,
      on_stderr = function(_, d) vim.list_extend(out, d) end,
      on_exit = function(_, code)
        if code ~= 0 then
          vim.notify("rex do failed (" .. code .. "): " .. table.concat(out, "\n"),
            vim.log.levels.ERROR)
        end
      end,
    })
  end
end

for key in pairs(dirs) do
  vim.keymap.set("n", "<C-" .. key .. ">", function() navigate(key) end,
    { silent = true, desc = "Navigate " .. dirs[key] })
end

