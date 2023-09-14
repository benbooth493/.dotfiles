local wezterm = require("wezterm")
local act = wezterm.action

local function isViProcess(pane)
	return pane:get_foreground_process_name():find('n?vim') ~= nil
end

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
	if isViProcess(pane) then
		window:perform_action(
			act.SendKey({ key = vim_direction, mods = 'CTRL' }),
			pane
		)
	else
		window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
	end
end

wezterm.on('ActivatePaneDirection-right', function(window, pane)
	conditionalActivatePane(window, pane, 'Right', 'l')
end)
wezterm.on('ActivatePaneDirection-left', function(window, pane)
	conditionalActivatePane(window, pane, 'Left', 'h')
end)
wezterm.on('ActivatePaneDirection-up', function(window, pane)
	conditionalActivatePane(window, pane, 'Up', 'k')
end)
wezterm.on('ActivatePaneDirection-down', function(window, pane)
	conditionalActivatePane(window, pane, 'Down', 'j')
end)

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.font = wezterm.font("Iosevka Nerd Font Mono", { weight = "Regular" })
config.font_size = 15.0
config.freetype_load_target = 'Light'
config.color_scheme = "Catppuccin Mocha"
config.line_height = 1.05
config.show_update_window = false
config.launch_menu = {}
config.leader = { key = "s", mods = "CTRL" }
config.disable_default_key_bindings = false
config.set_environment_variables = {}
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 32
config.adjust_window_size_when_changing_font_size = false
config.animation_fps = 60
config.max_fps = 60

config.keys = {
	{ key = "s",  mods = "LEADER|CTRL",  action = wezterm.action { SendString = "\x01" } },
	{ key = "-",  mods = "LEADER",       action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
	{ key = "\\", mods = "LEADER",       action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
	{ key = "z",  mods = "LEADER",       action = "TogglePaneZoomState" },
	{ key = "c",  mods = "LEADER",       action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },
	{ key = 'h',  mods = 'CTRL',         action = act.EmitEvent('ActivatePaneDirection-left') },
	{ key = 'j',  mods = 'CTRL',         action = act.EmitEvent('ActivatePaneDirection-down') },
	{ key = 'k',  mods = 'CTRL',         action = act.EmitEvent('ActivatePaneDirection-up') },
	{ key = 'l',  mods = 'CTRL',         action = act.EmitEvent('ActivatePaneDirection-right') },
	{ key = "H",  mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Left", 5 } } },
	{ key = "J",  mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Down", 5 } } },
	{ key = "K",  mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Up", 5 } } },
	{ key = "L",  mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Right", 5 } } },
	{ key = "1",  mods = "LEADER",       action = wezterm.action { ActivateTab = 0 } },
	{ key = "2",  mods = "LEADER",       action = wezterm.action { ActivateTab = 1 } },
	{ key = "3",  mods = "LEADER",       action = wezterm.action { ActivateTab = 2 } },
	{ key = "4",  mods = "LEADER",       action = wezterm.action { ActivateTab = 3 } },
	{ key = "5",  mods = "LEADER",       action = wezterm.action { ActivateTab = 4 } },
	{ key = "6",  mods = "LEADER",       action = wezterm.action { ActivateTab = 5 } },
	{ key = "7",  mods = "LEADER",       action = wezterm.action { ActivateTab = 6 } },
	{ key = "8",  mods = "LEADER",       action = wezterm.action { ActivateTab = 7 } },
	{ key = "9",  mods = "LEADER",       action = wezterm.action { ActivateTab = 8 } },
	{ key = "&",  mods = "LEADER|SHIFT", action = wezterm.action { CloseCurrentTab = { confirm = true } } },
	{ key = "x",  mods = "LEADER",       action = wezterm.action { CloseCurrentPane = { confirm = true } } },
	{ key = "{",  mods = "LEADER",       action = act.MoveTabRelative(-1) },
	{ key = "}",  mods = "LEADER",       action = act.MoveTabRelative(1) },
	{ key = "r",  mods = "LEADER",       action = act.RotatePanes 'Clockwise' },
	{ key = "n",  mods = "LEADER",       action = act.ActivateTabRelative(1) },
	{ key = "p",  mods = "LEADER",       action = act.ActivateTabRelative(-1) },
	{ key = "v",  mods = "SHIFT|CTRL",   action = act.PasteFrom "Clipboard" },
	{ key = "c",  mods = "SHIFT|CTRL",   action = act.CopyTo "Clipboard" },
	{
		key = "E",
		mods = "LEADER",
		action = act.PromptInputLine {
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		},
	},
}

return config
