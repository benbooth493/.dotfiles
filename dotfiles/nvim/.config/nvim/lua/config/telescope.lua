local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local utils = require "telescope.utils"

-- https://github.com/nvim-telescope/telescope.nvim/issues/1048
local telescope_custom_actions = {}

function telescope_custom_actions._multiopen(prompt_bufnr, open_cmd)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local num_selections = #picker:get_multi_selection()
  if not num_selections or num_selections <= 1 then
    actions.add_selection(prompt_bufnr)
  end
  actions.send_selected_to_qflist(prompt_bufnr)
  vim.cmd("cfdo " .. open_cmd)
end

function telescope_custom_actions.multi_selection_open(prompt_bufnr)
  telescope_custom_actions._multiopen(prompt_bufnr, "edit")
end

require("telescope").setup {
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case", -- this is default
    },
    file_browser = {
      hidden = true,
    },
  },
  defaults = {
    preview = {
      timeout = 500,
      msg_bg_fillchar = "",
    },
    multi_icon = " ",
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
    },
    prompt_prefix = "❯ ",
    selection_caret = "❯ ",
    sorting_strategy = "descending",
    color_devicons = true,
    layout_config = {
      prompt_position = "bottom",
      horizontal = {
        preview_width = 0.6,
      },
      vertical = {
        preview_height = 0.5,
      },
    },
    -- using custom temp multi-select maps
    -- https://github.com/nvim-telescope/telescope.nvim/issues/1048
    mappings = {
      n = {
        ["<Del>"] = actions.close,
        ["<C-A>"] = telescope_custom_actions.multi_selection_open,
      },
      i = {
        ["<esc>"] = actions.close,
        ["<C-A>"] = telescope_custom_actions.multi_selection_open,
      },
    },
    dynamic_preview_title = true,
    winblend = 4,
  },
}

require("telescope").load_extension "fzf"
