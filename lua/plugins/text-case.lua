local conversions = {
  "to_camel_case",
  "to_pascal_case",
  "to_snake_case",
  "to_constant_case",
  "to_dash_case",
  "to_title_dash_case",
  "to_dot_case",
  "to_path_case",
  "to_phrase_case",
  "to_title_case",
  "to_comma_case",
  "to_upper_case",
  "to_lower_case",
}

local function pick_conversion()
  local mode = vim.api.nvim_get_mode().mode
  local visual = mode == "v" or mode == "V" or mode == "\22"
  if visual then
    -- Same as text-case's own picker: remember the selection so textcase.visual() converts it.
    local utils = require("textcase.shared.utils")
    require("strings.repeat.methods").state.telescope_previous_visual_region =
      utils.get_visual_region(0, true, nil, utils.get_mode_at_operator(mode))
  end

  vim.ui.select(conversions, {
    prompt = "Convert case",
    format_item = function(item)
      return (item:gsub("^to_", ""):gsub("_", " "))
    end,
  }, function(choice)
    if not choice then
      return
    end
    local textcase = require("textcase")
    if visual then
      textcase.visual(choice)
    else
      textcase.current_word(choice)
    end
  end)
end

return {
  {
    "johmsalas/text-case.nvim",
    opts = {},
    keys = {
      "ga", -- Default invocation prefix
      { "ga.", pick_conversion, mode = { "n", "x" }, desc = "Pick case conversion" },
    },
    cmd = {
      -- NOTE: The Subs command name can be customized via the option "substitude_command_name"
      "Subs",
      "TextCaseStartReplacingCommand",
    },
    -- If you want to use the interactive feature of the `Subs` command right away, text-case.nvim
    -- has to be loaded on startup. Otherwise, the interactive feature of the `Subs` will only be
    -- available after the first executing of it or after a keymap of text-case.nvim has been used.
    lazy = true,
  },
}
