-- Rename the zellij tab to the current file name, and restore it when nvim exits.
if not (vim.env.ZELLIJ and vim.env.ZELLIJ_PANE_ID) then
  return
end

-- stable tab id of the tab holding this pane (the focused tab may be a different one)
local tab_id
local function get_tab_id()
  if tab_id then
    return tab_id
  end
  local out = vim.fn.system({ "zellij", "action", "list-panes", "--tab", "--json" })
  if vim.v.shell_error ~= 0 then
    return nil
  end
  local ok, panes = pcall(vim.json.decode, out)
  if not ok then
    return nil
  end
  for _, pane in ipairs(panes) do
    if not pane.is_plugin and tostring(pane.id) == vim.env.ZELLIJ_PANE_ID then
      tab_id = pane.tab_id
      return tab_id
    end
  end
end

local group = vim.api.nvim_create_augroup("ZellijTabTitle", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufFilePost" }, {
  group = group,
  callback = function(args)
    if vim.bo[args.buf].buftype ~= "" then
      return
    end
    local name = vim.fn.fnamemodify(args.file, ":t")
    local id = get_tab_id()
    if name ~= "" and id then
      vim.fn.jobstart({ "zellij", "action", "rename-tab", "--tab-id", tostring(id), name })
    end
  end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
  group = group,
  callback = function()
    local id = get_tab_id()
    if id then
      vim.fn.system({ "zellij", "action", "undo-rename-tab", "--tab-id", tostring(id) })
    end
  end,
})
